const mongoose = require('mongoose');


const clientSchema = new mongoose.Schema({
    name:String,
    password:{type:String,required:true},
    orders: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Order'
        }
    ],


});
module.exports = mongoose.model('Client', clientSchema);