const mongoose = require('mongoose');


const clientSchema = new mongoose.Schema({
    name:String,
    email:String,
    verified:Boolean,
    password:String,
    orders: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Order'
        }
    ],


});
module.exports = mongoose.model('Client', clientSchema);