const express = require('express');
const Notice = require('../models/noticeModel');

const router = express.Router();

// Create a new notice
router.post('/', async (req, res) => {
    try {
      const { title, content } = req.body;
      const notice = new Notice({ title, content });
      await notice.save();
      res.status(201).json({ message: 'Notice created successfully', notice });
    } catch (error) {
      res.status(500).json({ error: 'Internal server error' });
    }
  });


router.get('/', (req, res) => {
  res.send('Notices route');
});

module.exports = router;
