const express = require('express');
const { getallPosts } = require('../api/postsController');
const router = express.Router();
router.get('/getall',getallPosts);



module.exports = router;