const express = require('express');
const router = express.Router();
// const Message = require('../controllers/messagesController');
const messagesController = require('../controllers/messagesController');




router.get('/', messagesController.getMessages);
router.post('/', messagesController.createMessage);

module.exports = router;
