const express = require('express');
const { registerClient, registerTailor, login, verifyEmail, resetPassword, updatePassword, getallTailors, addFavorite, addLike, getTailor } = require('../api/usersController');
const { updateProfile } = require('../api/usersController');
const router = express.Router();

router.post('/register/client',registerClient );
router.post('/register/tailor',registerTailor );
router.post('/login',login);
router.post('/resetPassword',resetPassword);
router.post('/verifyEmail/:userId',verifyEmail)
router.put('/update/:userId', updateProfile);
router.get('/getallTailors',getallTailors);
router.post('/addFavorite/:userId',addFavorite)
router.post('/updatePassword/:userId',updatePassword)
router.post('/addLike',addLike)
router.get("/getTailor/:tailorId",getTailor)
module.exports = router;