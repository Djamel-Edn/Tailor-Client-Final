const Review=require('../Models/reviewModel');

const createReview = async (req, res) => {
    const { clientId, text, rating } = req.body;
    const review = new Review({
        clientId,
        text,
        rating
    });
    try {
        await review.save();
        res.status(201).json(review);
    } catch (error) {
        res.status(500).json({ error: 'Review creation failed' });
    }
}

module.exports = { };

