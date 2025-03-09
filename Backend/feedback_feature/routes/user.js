const express = require('express');
const User = require('../models/User');

const router = express.Router();

// GET: Search for a user by userId (query parameter: userId)
router.get('/search', async (req, res) => {
  const { userId } = req.query;
  try {
    const user = await User.findOne({ userId });
    if (user) {
      res.json(user);
    } else {
      res.status(404).json({ message: 'User not found' });
    }
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
