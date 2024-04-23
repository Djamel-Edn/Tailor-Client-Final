
const mongoose=require('mongoose');

    const postSchema=new mongoose.Schema({
        title:String,
        image:String,
        description:String,
        price:Number,
        category:String,
        speciality:String,
        tailor: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Tailor'
        },
        createdAt: {
            type: Date,
            default: Date.now
        }
    });
module.exports=mongoose.model('Post',postSchema);