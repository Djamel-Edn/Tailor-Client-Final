const mongoose=require('mongoose');

const postSchema=new mongoose.Schema({
    title:String,
    image:String,
    description:String,
    Price:Number,
    category:String,
    speciality:String,
    tailor: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Tailor'
    },

});
module.exports=mongoose.model('Post',postSchema);