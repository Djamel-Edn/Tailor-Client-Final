const express = require('express');
const router = express.Router();
router.post('/create',createReview)
router.delete('/delete/:id',deleteReview)

module.exports = router;