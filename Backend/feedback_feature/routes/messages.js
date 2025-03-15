const express = require('express');
const Message = require('../controllers/messagesController');

const router = express.Router();

router.get('/', messagesController.getMessages);
router.post('/', messagesController.createMessage);

module.exports = router;
