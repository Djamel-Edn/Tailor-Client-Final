const mongoose = require('mongoose');


const userVerificationSchema = new mongoose.Schema({
    userId:String,
    uniqueString:String,
    createdAt: {
        type: Date,
        default: Date.now,
        expires: 30000
    }

});
module.exports = mongoose.model('userVerification', userVerificationSchema);