const mongoose = require('mongoose');
const tailorSchema = new mongoose.Schema({
    name: String,
    email: String,
    password: String,
    phone: Number,
    address: String,
    city: String,
    gender:String,
    Speciality:String,
    description: String,
    rating: Number,
    verified:Boolean,
    reviews: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Review'
        }
    ],
    orders: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Order'
        }
    ],
});


module.exports = mongoose.model('Tailor', tailorSchema);