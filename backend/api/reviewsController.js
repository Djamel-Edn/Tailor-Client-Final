const reviewModel = require('../Models/reviewModel');
const Tailor = require('../Models/tailorModel');

const createReview = async (req, res) => {
    const { client, text, rating,tailorId } = req.body;
    const review = new reviewModel({
        client,
        text,
        rating,
        tailorId
    });
    try {
        await review.save();

        await Tailor.findByIdAndUpdate(tailorId, { $push: { reviews: review._id } });

        res.status(201).json(review);
    } catch (error) {
        res.status(500).json({ error: 'Review creation failed' });
    }
}

const deleteReview = async (req, res) => {
    try {
        const { id } = req.params;

        const review = await reviewModel.findById(id);
        if (!review) {
            return res.status(404).send('No review with that id');
        }

        await Tailor.findByIdAndUpdate(review.client, { $pull: { reviews: id } });

        await reviewModel.findByIdAndRemove(id);
        res.json('Review deleted successfully');
    } catch (error) {
        res.status(500).json('Server error');
    }
}
const getTailorReviews = async (req, res) => {
const { tailorId } = req.params;
try {
const tailor = await Tailor.findById(tailorId).populate('reviews');
if (!tailor) {
    return res.status(400).json({ error: 'Tailor not found' });
}
const reviews=tailor.reviews;
res.status(200).json(reviews);
}catch(error){
console.error(error);
}}


module.exports = { createReview, deleteReview,getTailorReviews };
