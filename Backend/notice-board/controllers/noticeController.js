const Notice = require('../models/noticeModel');

// Create a new notice
exports.createNotice = async (req, res) => {
    try {
        const { title, content } = req.body;
        
        if (!title || !content) {
            return res.status(400).json({ error: 'Title and content are required' });
        }

        const notice = new Notice({ title, content });
        await notice.save();
        res.status(201).json({ message: 'Notice created successfully', notice });
    } catch (error) {
        res.status(500).json({ error: 'Unable to process request at this moment. Please try again later.' });
    }
};

// Get all notices  
exports.getNotices = async (req, res) => {
    try {
        const notices = await Notice.find({}, '_id title content date').sort({ date: -1 });
        res.status(200).json({ message: 'Notices fetched successfully', data: notices });
    } catch (error) {
        res.status(500).json({ error: 'Unable to process request at this moment. Please try again later.' });
    }
};

// Delete a notice by ID
exports.deleteNotice = async (req, res) => {
    try {
        const { id } = req.params;
        const notice = await Notice.findByIdAndDelete(id);
        if (!notice) {
            return res.status(404).json({ error: 'Notice not found' });
        }
        res.status(200).json({ message: 'Notice deleted successfully' });
    } catch (error) {
        res.status(500).json({ error: 'Unable to process request at this moment. Please try again later.' });
    }
};