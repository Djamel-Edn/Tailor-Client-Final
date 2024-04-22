const mongoose = require('mongoose');
const tailorSchema = new mongoose.Schema({
    name: String,
    email: String,
    password: String,
    phone: Number,
    address: String,
    city: String,
    gender: String,
    speciality: String, // Corrected typo in the property name
    description: String,
    rating: Number,
    verified: Boolean,
    resetPasswordToken: String,
    profilePicture: {
        type: String,
        default: '../utils/pp.png'
    },
    reviews: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Review' }], // Array of reviews
    orders: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Order' }],
});


module.exports = mongoose.model('Tailor', tailorSchema);