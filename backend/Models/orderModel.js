const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema({
    client: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Client'
    },
    tailor: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Tailor'
    },
    status: {
        type: String,
        enum: ['Pending', 'Accepted', 'Rejected', 'Completed'],
        default: 'Pending'
    },
    orderDate: {
        type: Date,
        default: Date.now
    },
   posts:[{
    type:mongoose.Schema.Types.ObjectId,
    ref:'Post'
   }],
   
   questionnaire:[],
    totalPrice: Number
       

  
});

module.exports = mongoose.model('Order', orderSchema);