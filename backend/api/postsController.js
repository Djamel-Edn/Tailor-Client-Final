const Post = require('../Models/postModel');
const Tailor = require('../Models/tailorModel'); // Import the Tailor model
const mongoose = require('mongoose');

const createPost = async (req, res) => {
    const { title, image, description, price, category, postSpeciality:speciality, tailor } = req.body;

    try {
        const post = await Post.create({
            title,
            image,
            description,
            price,
            category,
            speciality,
            tailor
        });

        await Tailor.findByIdAndUpdate(tailor, { $push: { posts: post._id } });

        res.status(201).json(post);
    } catch (error) {
        console.error('Error creating post:', error);
        res.status(500).json({ error: 'Post creation failed' });
    }
};

const updatePost = async (req, res) => {
    try {
        const { id } = req.params;
        const { title, image, description, price, category, postSpeciality:speciality } = req.body;

        if (!mongoose.Types.ObjectId.isValid(id)) {
            return res.status(404).send('No post with that id');
        }

        const updatedPost = await Post.findByIdAndUpdate(id, {
            title,
            image,
            description,
            price,
            category,
            speciality,
        }, { new: true });

        res.json(updatedPost);
    } catch (error) {
        console.error('Error updating post:', error);
        res.status(500).json('Server error');
    }
};

const deletePost = async (req, res) => {
    try {
        const { id } = req.params;

        if (!mongoose.Types.ObjectId.isValid(id)) {
            return res.status(404).send('No post with that id');
        }

        // Get the tailor associated with the post
        const post = await Post.findById(id);
        const tailorId = post.tailor;

        await Post.findByIdAndde(id);

        // Update the posts array in the Tailor object
        await Tailor.findByIdAndUpdate(tailorId, { $pull: { posts: id } });

        res.json({ message: 'Post deleted successfully' });
    } catch (error) {
        console.error('Error deleting post:', error);
        res.status(500).json('Server error');
    }
};

const getallPosts = async (req, res) => {
    try {
        const posts = await Post.find().populate('tailor').sort({createdAt:-1});
        res.status(200).json(posts);
    } catch (error) {
        console.error('Error fetching all posts:', error);
        res.status(500).json({ error: 'Server error' });
    }
};

const getNewestPosts = async (req, res) => {
    try {
        const newestPosts = await Post.find().sort({ createdAt: -1 }).limit(20).populate('tailor');

        res.status(200).json(newestPosts);
    } catch (error) {
        console.error('Error fetching newest posts:', error);
        res.status(500).json({ error: 'Server error' });
    }
};

module.exports = { getNewestPosts };

const getTailorPosts = async (req, res) => {
    try {
        const { tailorId } = req.params;
        const posts = await Post.find({ tailor: tailorId });
        res.status(200).json(posts);
    } catch (error) {
        console.error('Error fetching tailor posts:', error);
        res.status(500).json('Server error');
    }
};

module.exports = { createPost, updatePost, deletePost, getallPosts, getNewestPosts, getTailorPosts };
