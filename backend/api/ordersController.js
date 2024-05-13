const mongoose = require('mongoose');
const Tailor = require('../Models/tailorModel');
const Order = require('../Models/orderModel');
const Client = require('../Models/clientModel');


const createOrder = async (req, res) => {
    let { client, tailor, totalPrice, posts,questionnaire,postStyle,fabric } = req.body;
    try {
        if (!mongoose.Types.ObjectId.isValid(client) || !mongoose.Types.ObjectId.isValid(tailor)) {
            return res.status(400).json({ error: 'Invalid client or tailor ID' });
        }
        if (!postStyle){
            postStyle='';
        }
        const order = await Order.create({
            client,
            tailor,
            totalPrice,
            posts,
            questionnaire,
            postStyle,
            fabric
        });
       
        await Tailor.findByIdAndUpdate(tailor, { $push: { orders: order._id } });
        await Client.findByIdAndUpdate(client, { $push: { orders: order._id } });

        res.status(201).json(order);
    } catch (error) {
        console.error('Error creating order:', error);
        res.status(500).json({ error: 'Order creation failed' });
    }
};

const updateOrder = async (req, res) => {
    const { id } = req.params;
    const { status, totalPrice } = req.body; 
    try {
        if (!mongoose.Types.ObjectId.isValid(id)) {
            return res.status(400).json({ error: 'Invalid order ID' });
        }
        const order = await Order.findById(id);
        if (!order) {
            return res.status(400).json({ error: 'No order with that id' });
        }
        if (status) {
            order.status = status;
        }
        if (totalPrice) {
            order.totalPrice = totalPrice;
        }
        
        const updatedOrder = await order.save();
        res.json(updatedOrder);
    } catch (error) {
        console.error('Error updating order:', error);
        res.status(500).json({ error: 'Server error' });
    }
};

const deleteOrder = async (req, res) => {
    try {
        const { id } = req.params;
        if (!mongoose.Types.ObjectId.isValid(id)) {
            return res.status(400).json({error :'Invalid order ID'});
        }
        const order = await Order.findById(id);
        if (!order) {
            return res.status(400).json( {error:'no Order with that ID'} );
        }
        await Tailor.findByIdAndUpdate(order.tailor, { $pull: { orders: id } });
        await Order.findByIdAndDelete(id);
        res.json('Order deleted successfully');
    } catch (error) {
        console.error('Error deleting order:', error);
        res.status(500).json({ error: 'Server error' });
    }
};

module.exports = { createOrder, updateOrder, deleteOrder };
