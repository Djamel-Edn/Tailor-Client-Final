const clientModel = require('../Models/clientmodel'); 
const tailorModel = require('../Models/tailorModel');
const validator=require('validator');

const registerClient = async (req, res) => {
    try {
        const { firstname, lastname, password, email } = req.body;

        let client = await clientModel.findOne({ email });
        if (client) {
            return res.status(400).json('Client already exists');
        }
        if (!validator.isEmail(email)) {
            return res.status(400).json('Invalid email');
        }
        if (!validator.isStrongPassword(password)) {
            return res.status(400).json('Password is weak');
        }
        client = new clientModel({ firstname, lastname, password, email });
        await client.save(); 
        res.status(201).json({_id: client._id, firstname: client.firstname, lastname: client.lastname, email: client.email});
    } catch (err) {
        console.log(err);
        res.status(500).json('Server error');
    }
}
const registerTailor = async (req, res) => {
    try {
        const { name, email, password, phone, address, city, country, Speciality, description } = req.body;

        let tailor = await tailorModel.findOne({ email });
        if (tailor) {
            return res.status(400).json('Tailor already exists');
        }
        if (!validator.isEmail(email)) {
            return res.status(400).json('Invalid email');
        }
        if (!validator.isStrongPassword(password)) {
            return res.status(400).json('Password is weak');
        }
        tailor = new tailorModel({ name, email, password, phone, address, city, country, Speciality, description });
        await tailor.save(); 
        res.status(201).json({_id: tailor._id, name: tailor.name, email: tailor.email});
    } catch (err) {
        console.log(err);
        res.status(500).json('Server error');
    }


};
