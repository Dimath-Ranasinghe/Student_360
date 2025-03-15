const express = require('express');
const User = require('../controllers/usersController');

const router = express.Router();

router.get('/search', usersController.searchUser);
router.post('/', usersController.createUser);

module.exports = router;