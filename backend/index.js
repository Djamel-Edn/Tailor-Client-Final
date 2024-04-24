const express = require('express');
const app = express();
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();
const usersRoute = require('./Routes/usersRoute');
const postsRoute = require('./Routes/postsRoute');
const bodyParser = require('body-parser');
const ordersRoute = require('./Routes/ordersRoute');
const chatRoute = require('./Routes/chatRoute');
const messageRoute = require('./Routes/messageRoute');
const { Server } = require("socket.io");
const http = require("http"); 
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

const server = http.createServer(app);
const io = new Server(server, { cors: { origin: "*" } }); 

app.use(express.json());
app.use('/', usersRoute);
app.use('/post', postsRoute);
app.use('/chat', chatRoute);
app.use('/order', ordersRoute);
app.use('/message', messageRoute);
let onlineUsers = [];
const port =  5001;
io.on("connection", (socket) => {
    socket.on("addNewUser", (userId) => {
      onlineUsers.some((user) => user.userId === userId)
        ? null
        : onlineUsers.push({ userId, socketId: socket.id });
  
        io.emit("getOnlineUsers", onlineUsers);
      });
      socket.on("sendMessage", (data) => {
          const { chatId,senderId,text, secondUser } = data;
          if (text ) {
  
            const nvMessage={chatId,senderId,text}
            const user=onlineUsers.find((user)=>user.userId===secondUser);
            
            io.to(user?.socketId).emit("receiveMessage", nvMessage);
          }
      });
      socket.on("disconnect", () => {
        // Find the user object in the onlineUsers array
        const userIndex = onlineUsers.findIndex((user) => user.socketId === socket.id);
      
        // If the user exists in the array, remove them
        if (userIndex !== -1) {
          onlineUsers.splice(userIndex, 1);
        }
      
        // Emit the updated onlineUsers array to all connected clients
        io.emit("getOnlineUsers", onlineUsers);
      });})
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
