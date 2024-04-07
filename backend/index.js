const express=require('express');
const app=express();
const port =process.env.PORT || 5001;
const mongoose=require('mongoose');
const cors=require('cors');
require('dotenv').config();
const usersRoute=require('./Routes/usersRoute');
app.use(express.json());
app.use(cors({ origin: true }));
app.use('/',usersRoute)




mongoose.connect(process.env.MONGODB_URI, {})
.then(() => {
    console.log("Connected to MongoDB successfully");
}).catch((error) => {
    console.error("Error connecting to MongoDB:", error);
});


app.listen(port,()=>{console.log(`Server is running on port ${port}`)});