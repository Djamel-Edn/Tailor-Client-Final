const reviewModel = require('../Models/reviewModel');
const Tailor = require('../Models/tailorModel');

const createReview = async (req, res) => {
    const { clientId, text, rating } = req.body;
    const review = new reviewModel({
        clientId,
        text,
        rating
    });
    try {
        await review.save();

        await Tailor.findByIdAndUpdate(clientId, { $push: { reviews: review._id } });

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

module.exports = { createReview, deleteReview };
