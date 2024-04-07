const express = require('express');
const { registerClient, registerTailor, login, verifyEmail } = require('../api/usersController');
const router = express.Router();

router.get("/verify/:userId/:uniqueString",verifyEmail)
router.post('/register/client',registerClient );
router.post('/register/tailor',registerTailor );
router.post('/login',login);
module.exports = router;