const express = require('express');
const { registerClient, registerTailor, loginClient, loginTailor } = require('../api/usersController');
const router = express.Router();

router.post('/register/client',registerClient );
router.post('/register/tailor',registerTailor );
router.post('/login/client',loginClient );
router.post('/login/tailor',loginTailor );