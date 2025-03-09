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

module.exports = router;
