const mongoose = require('mongoose');


const clientSchema = new mongoose.Schema({
    name:String,
    email:String,
    verified:Boolean,
    password:String,
    resetPasswordToken:String,
    profilePicture: {
        type: String,
        default: '/../utils/pp.png' 
    },
    orders: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Order'
        }
    ],


});
module.exports = mongoose.model('Client', clientSchema);