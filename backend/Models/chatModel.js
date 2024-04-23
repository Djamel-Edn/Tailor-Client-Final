const mongoose=require("mongoose");


const chatSchema= new mongoose.Schema({
    client: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Client'
    },
    tailor: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Tailor'
    },
    messages:[{
        type: mongoose.Schema.Types.ObjectId,
        ref:'Message'
    }]
},
{timestamps:true}
);

const chatModel = mongoose.model('Chat', chatSchema );
module.exports = chatModel;