const express = require('express');
const Message = require('../models/Message');

const router = express.Router();

// GET: Fetch messages between two users (using query parameters: from, to)
router.get('/', async (req, res) => {
  const { from, to } = req.query;
  try {
    const messages = await Message.find({
      $or: [
        { from, to },
        { from: to, to: from }
      ]
    }).sort({ timestamp: 1 });
    res.json(messages);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// POST: Create a new message
router.post('/', async (req, res) => {
    const { text, from, to } = req.body;
    const message = new Message({ text, from, to });
    try {
      const savedMessage = await message.save();
      res.status(201).json(savedMessage);
    } catch (err) {
      res.status(400).json({ message: err.message });
    }
  });
  

module.exports = router;
