const express = require('express');
const { registerClient, registerTailor, login, verifyEmail, resetPassword, updatePassword, getallTailors, addFavorite } = require('../api/usersController');
const { updateProfile } = require('../api/usersController');
const router = express.Router();

router.post('/register/client',registerClient );
router.post('/register/tailor',registerTailor );
router.post('/login',login);
router.post('/resetPassword',resetPassword);
router.post('/verifyEmail/:userId',verifyEmail)
router.put('/update/:userId', updateProfile);
router.get('/getallTailors',getallTailors);
router.post('/addFavorite',addFavorite)
module.exports = router;