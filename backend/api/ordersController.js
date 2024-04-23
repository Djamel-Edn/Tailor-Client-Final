const Tailor = require('../Models/tailorModel');
const Order = require('../Models/orderModel');
const mongoose = require('mongoose');

const createOrder = async (req, res) => {
    const { client, tailor, totalPrice } = req.body;
    try {
        const order = await Order.create({
            client,
            tailor,
            totalPrice
        });

        await Tailor.findByIdAndUpdate(tailor, { $push: { orders: order._id } });

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
        const order = await Order.findById(id);
        if (!order) {
            return res.status(404).send('No order with that id');
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
        res.status(500).json('Server error');
    }
};

const deleteOrder = async (req, res) => {
    try {
        const { id } = req.params;
        if (!mongoose.Types.ObjectId.isValid(id)) {
            return res.status(404).send('No order with that id');
        }
        const order = await Order.findById(id);
        if (!order) {
            return res.status(404).send('No order with that id');
        }
        await Tailor.findByIdAndUpdate(order.tailor, { $pull: { orders: id } });
        await Order.findByIdAndRemove(id);
        res.json('Order deleted successfully');
    } catch (error) {
        console.error('Error deleting order:', error);
        res.status(500).json('Server error');
    }
};

module.exports = { createOrder, updateOrder, deleteOrder };
