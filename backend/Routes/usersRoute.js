const express = require('express');
const { registerClient, registerTailor, login, verifyEmail, resetPassword, updatePassword, getallTailors } = require('../api/usersController');
const { updateProfile } = require('../api/usersController');
const router = express.Router();

router.get("/verify/:userId/:uniqueString",verifyEmail)
router.post('/register/client',registerClient );
router.post('/register/tailor',registerTailor );
router.post('/login',login);
router.post('/resetPassword',resetPassword);
router.post('/updatePassword',updatePassword);
router.post('/verifyEmail/:userId',verifyEmail)
router.put('/update/:userId', updateProfile);
router.get('/getallTailors',getallTailors);
module.exports = router;