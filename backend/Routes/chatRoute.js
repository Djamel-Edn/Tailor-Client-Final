const express=require('express')
const { createOrFindChat } = require('../api/chatController')
const router = express.Router()

router.post('/fetch',createOrFindChat)



module.exports=router