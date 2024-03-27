const mongoose = require('mongoose');


const clientSchema = new mongoose.Schema({
    firstname:String,
    lastname:String,
    password:{type:String,required:true},
    orders: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Order'
        }
    ],


});
module.exports = mongoose.model('Client', clientSchema);