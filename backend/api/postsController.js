const Post=require('../Models/postModel');
const createPost = async (req, res) => {
    const { title, image, description, price, category, speciality, tailor } = req.body;
    const post = new Post({
        title,
        image,
        description,
        price,
        category,
        speciality,
        tailor
    });
    try {
        await post.save();
        res.status(201).json(post);
    } catch (error) {
        res.status(500).json({ error: 'Post creation failed' });
    }
};

const updatePost = async (req, res) => {
    try {
        const { id } = req.params;
        const { title, image, description, price, category, speciality, tailor } = req.body;
        
        if (!mongoose.Types.ObjectId.isValid(id)) {
            return res.status(404).send('No post with that id');
        }
        
        const updatedPost = { title, image, description, price, category, speciality, tailor, _id: id };
        
        const updatedPostDocument = await Post.findByIdAndUpdate(id, updatedPost, { new: true });
        
        res.json(updatedPostDocument);
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json('Server error');
    }
};

const deletePost = async (req, res) => {
    try {
        const { id } = req.params;
        
        if (!mongoose.Types.ObjectId.isValid(id)) {
            return res.status(404).send('No post with that id');
        }
        
        await Post.findByIdAndRemove(id);
        
        res.json({ message: 'Post deleted successfully' });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json('Server error');
    }
};
const getallPosts=async (req,res)=>{
    try{
        const posts=await Post.find();
        res.status(200).json(posts);
    }catch(error){
        res.status(500).json({error:'Server error'});
    }

}
const getNewestPosts = async (req, res) => {
    try {
        const newestPosts = await Post.find().sort({ createdAt: -1 }).limit(20)

        res.status(200).json(newestPosts); 
    } catch (error) {
        console.error('Error fetching newest posts:', error);
        res.status(500).json({ error: 'Server error' });
    }
};
const getTailorPosts = async (req, res) => {
    try {   
        const { tailorId } = req.params;
        const posts = await Post.find({ tailor: tailorId });

        res.status(200).json(posts);
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json('Server error');
    }
};

module.exports = { createPost,updatePost,deletePost,getallPosts,getNewestPosts,getTailorPosts};

