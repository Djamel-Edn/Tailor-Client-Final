const clientModel = require('../Models/clientmodel'); 
const tailorModel = require('../Models/tailorModel');
const validator=require('validator');

const registerClient = async (req, res) => {
    try {
        const { name,gender, password, email } = req.body;

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
        client = new clientModel({ name,gender, password, email });
        await client.save(); 
        res.status(201).json({_id: client._id, name:client.name, email: client.email});
    } catch (err) {
        console.log(err);
        res.status(500).json('Server error');
    }
}
const registerTailor = async (req, res) => {
    try {
        const { name, email,gender, password, phone, address, city } = req.body;

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
        tailor = new tailorModel({ name, email,gender, password, phone, address, city });
        await tailor.save(); 
        res.status(201).json({_id: tailor._id, name: tailor.name, email: tailor.email});
    } catch (err) {
        console.log(err);
        res.status(500).json('Server error');
    }
};
const loginClient = async (req, res) => {
    try {
        const { email, password } = req.body;
        let client = await clientModel.findOne({ email });
        if (client){
            if (client.password === password) {
                res.status(200).json({_id: client._id, name: client.name, email: client.email});
            } else {
                res.status(400).json('Invalid credentials');
            }
        }}
        catch (err) {
            res.status(500).json('Server error');

        }}
const loginTailor = async (req, res) => {
    try {
        const { email, password } = req.body;
        let tailor = await tailorModel.findOne({ email });
        if (tailor){
            if (tailor.password === password) {
                res.status(200).json({_id: tailor._id, name: tailor.name, email: tailor.email});
            } else {
                res.status(400).json('Invalid credentials');
            }
        }}
        catch (err) {
            res.status(500).json('Server error');

        }}

        
module.exports = { registerClient, registerTailor, loginClient, loginTailor };
