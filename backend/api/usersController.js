const clientModel = require('../Models/clientmodel'); 
const tailorModel = require('../Models/tailorModel');
const validator = require('validator');
const userVerification = require('../Models/userVerificationModel')
const nodemailer = require('nodemailer');
const { v4: uuidv4 } = require('uuid');
const bcrypt = require('bcrypt');
const path = require('path');
require('dotenv').config();
let transporter = nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: process.env.SMTP_PORT,
    secure: process.env.SMTP_SECURE === 'true', // true for 465, false for other ports
    auth: {
        user: process.env.SMTP_USER,
        pass: process.env.SMTP_PASSWORD
    }
});

// Verify transporter
transporter.verify((error, success) => {
    if (error) {
        console.log(error);
    } else {
        console.log('SMTP transporter ready for messages');
    }
});

const sendVerificationEmail = ({ _id, email }, res) => {
    const code = Math.floor(1000 + Math.random() * 9000); // Génère un nombre aléatoire entre 1000 et 9999

    const mailOptions = {
        from: process.env.AUTH_EMAIL,
        to: email,
        subject: 'Verify your email',
        html: `<h1>Use this code to verify your email: ${code}</h1>`
    };

    const saltRounds = 10;
    const uniqueString = code.toString(); // Utilisez le code comme uniqueString

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
                            console.log(error);
                            res.status(500).json(error);
                        } else {
                            console.log('Email sent:', info.response);
                            res.status(200).json('Email sent');
                        }
                    });
                })
                .catch((err) => {
                    console.log(err);
                    res.status(500).json(err);
                });
        })
        .catch((err) => {
            console.log(err);
            res.status(500).json(err);
        });
};


const registerClient = async (req, res) => {
    try {
        const { name, email, password, gender } = req.body;

        let client = await clientModel.findOne({ email });
        if (client) return res.status(400).json("User with this email already exists...");

        let tailor = await tailorModel.findOne({ email });
        if (tailor) return res.status(400).json("User with this email already exists...");

        if (!validator.isEmail(email)) return res.status(400).json("Please enter a valid email ...");
        if (!validator.isStrongPassword(password)) return res.status(400).json("The password must be a strong one ...");

        const code = Math.floor(1000 + Math.random() * 9000); // Génère un nombre aléatoire entre 1000 et 9999
        const hashedPassword = await bcrypt.hash(password, 10); 

        client = new clientModel({ 
            name, 
            email, 
            password: hashedPassword, 
            gender, 
            verified: false, 
            orders: [],
        });

        await client.save()
            .then(result => { sendVerificationEmail(result, res) });

        res.status(200).json({
            _id: client._id,
            name: client.name,
            email: client.email,
            gender: client.gender,
            profilePicture: client.profilePicture,
            verified: client.verified,
            orders: client.orders,
        });
    } catch (error) {
        console.log(error);
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

        res.status(200).json({
            _id: tailor._id,
            name: tailor.name,
            email: tailor.email,
            gender: tailor.gender,
            phone: tailor.phone,
            city: tailor.city,
            profilePicture: tailor.profilePicture,

            verified: false,
            address: '',
            city: '',
            gender: '',
            speciality: '',
            description: '',
            rating: 0,
            resetPasswordToken: code.toString(),

            reviews: [],
            orders: [],
            posts: []
        });
    } catch (err) {
        console.log(err);
        res.status(500).json('Server error');
    }
};


const login = async (req, res) => {
    try {
        const { email, password } = req.body;
        
        let user = await clientModel.findOne({ email });
        let userType = 'client'; 
        
        if (!user) {
            user = await tailorModel.findOne({ email });
            userType = 'tailor'; 
        }
        
        if (user) {
            const isPasswordValid = await bcrypt.compare(password, user.password);
            if (isPasswordValid) {
                if (userType === 'tailor') {
                    res.status(200).json({
                        _id: user._id,
                        name: user.name,
                        email: user.email,
                        phone: user.phone,
                        city: user.city,
                        gender:user.gender,
                        verified: user.verified,
                        userType: userType ,
                        orders: user.orders,
                        profilePicture: user.profilePicture,
                    });

                }else{
                    res.status(200).json({
                        _id: user._id,
                        name: user.name,
                        email: user.email,
                        verified: user.verified,
                        gender:user.gender,
                        userType: userType ,
                        profilePicture: user.profilePicture,
                    });
                }
            } else {
                res.status(400).json('Invalid credentials');
            }
        } else {
            res.status(400).json('User not found');
        }
    } catch (err) {
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


const resetPassword = async (req, res) => {
    try {
        const { email } = req.body;
        
        let user = await clientModel.findOne({ email });
        
        if (!user) {
            user = await tailorModel.findOne({ email });
        }
        
        if (user) {
            const resetToken = uuidv4();

            user.resetPasswordToken = resetToken;
            await user.save();

            const resetUrl = `http://localhost:5000/${email}/${resetToken}`;
            const mailOptions = {
                from: process.env.AUTH_EMAIL,
                to: email,
                subject: 'Password Reset',
                html: `<p>You have requested to reset your password. Please follow the link below to reset your password:</p><a href="${resetUrl}">here</a>`
            };

            transporter.sendMail(mailOptions, (error, info) => {
                if (error) {
                    console.error('Error sending email:', error);
                    res.status(500).json('Failed to send password reset email');
                } else {
                    console.log('Password reset email sent:', info.response);
                    res.status(200).json('Password reset email sent');
                }
            });
        } else {
            res.status(400).json('Email not found');
        }
    } catch (err) {
        console.error('Error:', err);
        res.status(500).json('Server error');
    }
};
const updatePassword = async (req, res) => {
    try {
        const { resetToken, newPassword } = req.body;
        
        let user = await clientModel.findOne({ resetPasswordToken: resetToken });

        if (!user) {
            user = await tailorModel.findOne({ resetPasswordToken: resetToken });
        }
        if (!validator.isStrongPassword(newPassword)) return res.status(400).json('Password is weak');

        if (user) {
            const hashedPassword = await bcrypt.hash(newPassword, 10);

            user.password = hashedPassword;
            user.resetPasswordToken = null; 
            await user.save();

            res.status(200).json('Password updated successfully');
        } else {
            res.status(400).json('Invalid or expired reset token');
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
        const tailors=await tailorModel.find();
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

        res.status(200).json({ message: 'Post added to favorites successfully', favorites: user.favorites });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ error: 'Server error' });
    }
};



module.exports = { registerClient, registerTailor, login, verifyEmail, resetPassword, updatePassword, updateProfile,getallTailors,verifyEmail,addFavorite};

