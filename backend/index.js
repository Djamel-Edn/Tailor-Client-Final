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
const reviewRoute = require('./Routes/reviewsRoute');
const { Server } = require("socket.io");
const http = require("http"); 

app.use(cors({
    origin: '*',
    methods: '*',
    allowedHeaders: '*',
    credentials: true
}));

app.use(bodyParser.json({ limit: '20mb' }));
app.use(bodyParser.urlencoded({ limit: '20mb', extended: true }));

// Routes
app.use(express.json());
app.use('/', usersRoute);
app.use('/post', postsRoute);
app.use('/chat', chatRoute);
app.use('/order', ordersRoute);
app.use('/message', messageRoute);
app.use('/review',reviewRoute)
mongoose.connect(process.env.MONGODB_URI, {})
    .then(() => {
        console.log("Connected to MongoDB successfully");
    }).catch((error) => {
        console.error("Error connecting to MongoDB:", error);
    });

const server = http.createServer(app);

const io = new Server(server, { cors: { origin: "*" } }); 

let onlineUsers = [];

io.on('connection', (socket) => {
    console.log('New client connected');
  
    socket.on('addNewUser', (userId) => {
      if (!onlineUsers.some(user => user.userId === userId)) {
        onlineUsers.push({ userId, socketId: socket.id });
        
      }
      io.emit('getOnlineUsers', onlineUsers);
      console.log(`User ${userId} connected. Online users:`, onlineUsers);
    });
  
  
    socket.on('message', ( message,senderId,receiverId) => {
      usertoget=onlineUsers.filter(user=> user.userId === receiverId)
      console.log('message',message)
      console.log('usertoget',usertoget)
      console.log('receiverId',receiverId)
        io.to(usertoget.socketId).emit('message', message);
    });
  socket.on('newOrder', ( order,tailorId) => {
    usertoget=onlineUsers.filter(user=> user.userId === tailorId)
 
      io.to(usertoget.socketId).emit('newOrder', order);
  
  })
  socket.on('newReview', ( review,tailorId) => {
    usertoget=onlineUsers.filter( user.userId === tailorId)
 
      io.to(usertoget.socketId).emit('newReview', review);
  })
  socket.on('updateOrder', ( order,clientId,tailorId) => {
    userstoget=onlineUsers.filter(user=> user.userId==tailorId ||user.userId === clientId)
    userstoget.forEach(user => {
      io.to(user.socketId).emit('updateOrder', order);
    });
  })
    socket.on('disconnect', () => {
      onlineUsers = onlineUsers.filter(user => user.socketId !== socket.id);
      io.emit('getOnlineUsers', onlineUsers);
      console.log(`Client disconnected. Online users:`, onlineUsers);
    });
  });
  


PORT =process.env.PORT 
server.listen(5001, () => {
    console.log(`Server is running on port ${PORT}`);
    console.log(`process.env.PORT: ${process.env.PORT}`);
});
