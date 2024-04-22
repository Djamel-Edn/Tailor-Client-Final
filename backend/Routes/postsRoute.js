const express = require('express');
const { createPost, updatePost, deletePost, getallPosts, getNewestPosts, getTailorPosts } = require('../api/postsController');
const router = express.Router();
router.post('/create',createPost);
router.put('/update/:id',updatePost);
router.delete('/delete/:id',deletePost);
router.get('/getall',getallPosts);
router.get('/getnewest',getNewestPosts)
router.get('/:tailorId',getTailorPosts)



module.exports = router;