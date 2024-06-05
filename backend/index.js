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
const Client = require('./Models/clientModel');
const Order = require('./Models/orderModel');

app.use(cors({
    origin: '*',
    methods: '*',
    allowedHeaders: '*',
    credentials: true
}));

app.use(bodyParser.json({ limit: '20mb' }));
app.use(bodyParser.urlencoded({ limit: '20mb', extended: true }));


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
  
  
    socket.on('message', (message) => {  
      const usertoget = onlineUsers.find(user => user.userId === message.RecieverId);
      
     
  
      if (usertoget && usertoget.socketId) {
        io.to(usertoget.socketId).emit('message', message);
      } else {
        console.log('User not found or socketId is not valid');
      }
    });
    socket.on('newOrder', async (order) => {
      try {
          const usertoget = onlineUsers.filter(user => user.userId === order.tailor);
        
          if (usertoget.length > 0) {
              
          OrderFull=await Order.findOne({_id:order._id}).populate('posts').populate('client')
             
                  order.client = OrderFull.client;
                  order.posts=OrderFull.posts
  
                  io.to(usertoget[0].socketId).emit('newOrder', order);
              
          } else {
              console.error(`Tailor with ID ${order.tailor} is not online`);
          }
      } catch (error) {
          console.error('Error processing new order:', error);
      }
  });
  
  
  socket.on('newReview', ( review) => {
    usertoget=onlineUsers.filter( user.userId === review.tailorId)
    console.log(review)
    console.log('usertoget',usertoget)
      io.to(usertoget.socketId).emit('newReview', review);
  })
  socket.on('updateOrder',async ( orderId) => {
    console.log('orderId',orderId)
    const order=await Order.findOne({_id:orderId}).populate('posts').populate('client').populate('tailor')
  const  user=onlineUsers.find(user=>  user.userId === order.client._id)
    
    console.log('order',order)
    console.log('userstoget',user)
      io.to(user.socketId).emit('updateOrder', order);

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
