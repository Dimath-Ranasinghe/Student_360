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

// Get all notices  
router.get('/', async (req, res) => {
    try {
      const notices = await Notice.find({}, '_id title content date').sort({ date: -1 });
      res.status(200).json(notices);
    } catch (error) {
      res.status(500).json({ error: 'Internal server error' });
    }
  });

// Delete a notice by ID
router.delete('/:id', async (req, res) => {
    try {
      const { id } = req.params;
      const notice = await Notice.findByIdAndDelete(id);
      if (!notice) {
        return res.status(404).json({ error: 'Notice not found' });
      }
      res.status(200).json({ message: 'Notice deleted successfully' });
    } catch (error) {
      res.status(500).json({ error: 'Internal server error' });
    }
});
  

module.exports = router;
