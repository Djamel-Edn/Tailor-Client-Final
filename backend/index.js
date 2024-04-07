const express=require('express');
const app=express();
const port =process.env.PORT || 5001;
const mongoose=require('mongoose');
require('dotenv').config();

app.use(express.json());






mongoose.connect(process.env.MONGODB_URI, {})
.then(() => {
    console.log("Connected to MongoDB successfully");
}).catch((error) => {
    console.error("Error connecting to MongoDB:", error);
});


app.listen(port,()=>{console.log(`Server is running on port ${port}`)});