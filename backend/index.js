const express = require('express');
const app = express();
const port =  5001;
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();
const usersRoute = require('./Routes/usersRoute');
const postsRoute = require('./Routes/postsRoute');
const bodyParser = require('body-parser');
// Middleware
app.use(cors());
app.use(cors()); 

app.use(bodyParser.json({ limit: '20mb' }));
app.use(bodyParser.urlencoded({ limit: '20mb', extended: true }));
app.use(cors({
  origin: '*',
  methods: '*', 
  allowedHeaders: '*', 
}));


app.use(express.json());
app.use('/', usersRoute);
app.use('/post', postsRoute);


// Connect to MongoDB
mongoose.connect("mongodb+srv://dib:Ddjames035@cluster0.fd3ji68.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0", {})
    .then(() => {
        console.log("Connected to MongoDB successfully");
    }).catch((error) => {
        console.error("Error connecting to MongoDB:", error);
    });

// Start server
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
