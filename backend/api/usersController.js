const tailorModel = require('../Models/tailorModel');
const validator = require('validator');
const userVerification = require('../Models/userVerificationModel')
const nodemailer = require('nodemailer');
const bcrypt = require('bcrypt');
const path = require('path');
const clientModel = require('../Models/clientModel');
require('dotenv').config();
const transporter = nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: process.env.SMTP_PORT,
    secure: process.env.SMTP_SECURE === 'true',
    auth: {
        user: process.env.SMTP_USER,
        pass: process.env.SMTP_PASSWORD
    }
});

// Verify transporter
transporter.verify((error, success) => {
    if (error) {
        console.log('SMTP transporter verification failed:', error);
    } else {
        console.log('SMTP transporter ready for messages');
    }
});

const sendVerificationEmail = ({ _id, email }, res) => {
    const code = Math.floor(1000 + Math.random() * 9000); // Generate a random code between 1000 and 9999

    const mailOptions = {
        from: process.env.AUTH_EMAIL,
        to: email,
        subject: 'Verify your email',
        html: `<h1>Use this code to verify your email: ${code}</h1>`
    };

    const saltRounds = 10;
    const uniqueString = code.toString(); // Use the code as the uniqueString

    bcrypt.hash(uniqueString, saltRounds)
        .then((hashedUniqueString) => {
            const newVerification = new userVerification({
                userId: _id,
                uniqueString: hashedUniqueString,
                createdAt: Date.now()
            });

            newVerification.save()
                .then(() => {
                    transporter.sendMail(mailOptions, (error, info) => {
                        if (error) {
                            console.log('Error sending verification email:', error);
                            res.status(500).json(error);
                        } else {
                            console.log('Verification email sent:', info.response);
                            res.status(200).json('Verification email sent');
                        }
                    });
                })
                .catch((err) => {
                    console.log('Error saving verification data:', err);
                    res.status(500).json(err);
                });
        })
        .catch((err) => {
            console.log('Error hashing code:', err);
            res.status(500).json(err);
        });
};

const registerClient = async (req, res) => {
    try {
        const { name, email, password, gender,city } = req.body;

        let client = await clientModel.findOne({ email });
        if (client) return res.status(400).json("User with this email already exists...");

        let tailor = await tailorModel.findOne({ email });
        if (tailor) return res.status(400).json("User with this email already exists...");

        if (!validator.isEmail(email)) return res.status(400).json("Please enter a valid email ...");
        if (!validator.isStrongPassword(password)) return res.status(400).json("The password must be a strong one ...");

        const hashedPassword = await bcrypt.hash(password, 10); 

        client = new clientModel({ 
            name, 
            email, 
            password: hashedPassword,
            resetPasswordToken: "", 
            gender, 
            verified: false, 
            orders: [],
            city
        });

        await client.save();

        sendVerificationEmail(client, res); // Send verification email after client is saved
        clientObject=client.toObject();
        delete clientObject.password
        res.status(200).json(clientObject);
    } catch (error) {
        console.log('Error registering client:', error);
        res.status(500).json(error);
    }
};


const registerTailor = async (req, res) => {
    try {
        const { name, email, gender, password, phone, city } = req.body;

        let tailor = await tailorModel.findOne({ email });
        if (tailor) return res.status(400).json('Tailor already exists');

        let client = await clientModel.findOne({ email });
        if (client) return res.status(400).json("User with this email already exists...");

        if (!validator.isEmail(email)) return res.status(400).json('Invalid email');
        if (!validator.isStrongPassword(password)) return res.status(400).json('Password is weak');

        const code = Math.floor(1000 + Math.random() * 9000); // Génère un nombre aléatoire entre 1000 et 9999
        const hashedPassword = await bcrypt.hash(password, 10);

        tailor = new tailorModel({
            name,
            email,
            gender,
            password: hashedPassword,
            phone,
            city,
            verified: false,
            address: '',
            city: '',
            gender: '',
            speciality: '',
            description: '',
            rating: 0,
            profilePicture: '../utils/pp.png',
            reviews: [],
            orders: [],
            posts: []
        });

        await tailor.save()
            .then(result => { sendVerificationEmail(result, res) });
        tailorObject=tailor.toObject();
        delete tailorObject.password;
        res.status(200).json(tailorObject);
    } catch (err) {
        console.log(err);
        res.status(500).json('Server error');
    }
};




const login = async (req, res) => {
    try {
        const { email, password } = req.body;
        let user = await clientModel.findOne({ email }).populate({
            path: 'orders',
            populate: {
                path: 'tailor',
                model: 'Tailor'
            }
        }).populate({
            path: 'orders',
            populate: {
                path: 'posts',
                model: 'Post'
            }
        });
        let userType="Client";
        if (!user) {
            user = await tailorModel.findOne({ email })
            .populate({
                path: 'orders',
                populate: {
                    path: 'client',
                    model: 'Client'
                }
            })
            .populate({
                path: 'orders',
                populate: {
                    path: 'posts',
                    model: 'Post'
                }
            })
            .populate('reviews')
            .populate('posts')
            
            userType="Tailor";
        }
        if (user) {
            const isPasswordValid = await bcrypt.compare(password, user.password);
             let tri=await bcrypt.compare("newTest!", user.password)
            if (isPasswordValid) {
                user = user.toObject(); 
                delete user.password;
                const userData = { ...user, userType };
                
                res.status(200).json(userData);
                
            } else {
                res.status(400).json('Invalid credentials');
            }
        } else {
            res.status(400).json('User not found');
        }
    } catch (err) {
        console.error('Error in login:', err);
        res.status(500).json('Server error');
    }
};



const verifyEmail = async (req, res) => {
    try {
        const { userId } = req.params;
        const { uniqueString } = req.body;
        
        let user = await clientModel.findById(userId);
        let userType = 'client';
        
        if (!user) {
            user = await tailorModel.findById(userId);
            userType = 'tailor';
        }
        
        if (!user) {
            return res.status(404).json('User not found');
        }
        
        const userVerificationEntry = await userVerification.findOne({ userId });
        
        if (!userVerificationEntry) {
            return res.status(404).json('User verification entry not found');
        }
        
        bcrypt.compare(uniqueString, userVerificationEntry.uniqueString)
        .then(async (isMatch) => {
            if (isMatch) {
                if (userType === 'client') {
                    await clientModel.findByIdAndUpdate(userId, { verified: true });
                } else {
                    await tailorModel.findByIdAndUpdate(userId, { verified: true });
                }
                
                await userVerification.findByIdAndDelete(userVerificationEntry._id);
                
                res.status(200).json('Email verified successfully');
            } else {
                res.status(400).json('Invalid verification code');
            }
        })
            .catch((err) => {
                console.log(err);
                res.status(500).json('Server error');
            });
        } catch (error) {
            console.log(error);
            res.status(500).json('Server error');
        }
    };
    
    const updatePassword = async (req, res) => {
        try {
            const { userId } = req.params;
            const { newPassword } = req.body;
    
            let user = await clientModel.findById(userId) || await tailorModel.findById(userId);
    
            if (!user) {
                return res.status(404).json('User not found');
            }
    
            // Update the password directly
            user.password = await bcrypt.hash(newPassword, 10);
            await user.save();
    
            res.status(200).json('Password updated successfully');
        } catch (error) {
            console.log(error);
            res.status(500).json('Server error');
        }
    };
    
        
    const resetPassword = async (req, res) => {
        try {
            const { email } = req.body;
            
            let user = await clientModel.findOne({ email });
            
            if (!user) {
                user = await tailorModel.findOne({ email });
            }
            
            if (user) {
                sendVerificationEmail(user,res);
                res.status(200).json(user._id)
            } else {
                res.status(400).json('Email not found');
            }
        } catch (error) {
            console.error('Error:', error);
            res.status(500).json('Server error');
        }
    };
    
    
    const updateProfile = async (req, res) => {
        try {
            const { userId } = req.params;
            const { name, email, city, phone, profilePicture,speciality } = req.body;
            if (!userId) {
                return res.status(400).json('User ID is required');
            }
            
            let user = await clientModel.findById(userId);
            let userType = 'client';
            if (!user) {
                user = await tailorModel.findById(userId);
                userType = 'tailor';
            }
            
            if (!user) {
                return res.status(404).json('User not found');
            }
            if (name) {user.name = name;}
            if (email) user.email = email;
            if (city) user.city = city;
            if (phone) user.phone = phone;
            if (profilePicture) user.profilePicture = profilePicture;
            if (speciality) user.speciality = speciality;
            
            await user.save();
            
            const userWithoutPassword = user.toObject();
            delete userWithoutPassword.password;
            
            const responseObject = {
                ...userWithoutPassword,
                userType: userType
            };
            
            res.status(200).json(responseObject);
        } catch (error) {
            console.error('Error:', error);
            res.status(500).json('Server error');
        }
    };
    
    const getallTailors=async (req,res)=>{
        try{
            const tailors=await tailorModel.find().populate({
                path:'reviews',
                model:'Review',
                populate:{
                    path:'client',
                    model:'Client'
                }
            });
            res.status(200).json(tailors);
        }catch(error){
            res.status(500).json({error:'Server error'});
        }
        
    }
    const addFavorite = async (req, res) => {
        try {
            const { userId } = req.params;
            const { postId } = req.body;
            
            
            const user = await clientModel.findById(userId);
            if (!user) {
                return res.status(404).json({ error: 'User not found' });
            }
            
            
            const postExists = user.favorites.some(favorite => favorite.equals(postId));
            if (postExists) {
                return res.status(400).json({ error: 'Post is already in favorites' });
            }
            
            
            user.favorites.push(postId);
            await user.save();
            
            res.status(200).json({ favorites: user.favorites });
        } catch (error) {
            console.error('Error:', error);
            res.status(500).json({ error: 'Server error' });
        }
    };

    const addLike = async (req, res) => {
        try {
            const { userId } = req.params;
            const { tailorId } = req.body;
    
            const user = await clientModel.findById(userId);
    
            if (!user) {
                return res.status(404).json({ error: 'User not found' });
            }
    
            const tailorIndex = user.likes.indexOf(tailorId);
            if (tailorIndex !== -1) {
                user.likes.splice(tailorIndex, 1);
                await user.save();
                return res.status(200).json( {likes: user.likes} );
            } else {
                user.likes.push(tailorId);
                await user.save();
                return res.status(200).json( {likes: user.likes} );
            }
    
        } catch (error) {
            console.error('Error:', error);
            res.status(500).json({ error: 'Server error' });
        }
    }
    const getTailor = async (req, res) => {
        const { tailorId } = req.params;
        try {
            const user = await tailorModel.findOne({ _id: tailorId })
                .populate({
                    path: 'orders',
                    populate: {
                        path: 'client',
                        model: 'Client'
                    }
                })
                .populate({
                    path: 'orders',
                    populate: {
                        path: 'posts',
                        model: 'Post'
                    }
                })
                .populate('reviews')
                .populate('posts');
            
            if (user) {
                const userData = user.toObject(); 
                delete userData.password;
            
                res.status(200).json(userData);
            } else {
                res.status(404).json('User not found');
            }
        } catch (error) {
            console.error("Error:", error);
            res.status(500).json({ error: 'Server error' });
        }
    };

    
    module.exports = {getTailor,addLike,updatePassword, registerClient, registerTailor, login, verifyEmail, resetPassword, updateProfile,getallTailors,verifyEmail,addFavorite};
    
    