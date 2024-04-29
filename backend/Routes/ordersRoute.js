const express = require('express');
const { createOrder, updateOrder, deleteOrder } = require('../api/ordersController');
const router = express.Router();
router.post('/create',createOrder)
router.put('/update/:id',updateOrder)
router.delete('/delete/:id',deleteOrder)

module.exports = router;