const express=require('express')
const { createChat,findChat } = require('../api/chatController')
const router = express.Router()

router.post('/',createChat)
router.get('/clientId/:tailorId',findChat)


module.exports=router