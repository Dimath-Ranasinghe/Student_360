const TeacherProfile = require('../models/TeacherProfile');

exports.createProfile = async (req, res) => {
    try {
        const newProfile = new TeacherProfile(req.body);
        const savedProfile = await newProfile.save();
        res.status(201).json(savedProfile);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.getAllProfiles = async (req, res) => {
    try {
        const profiles = await TeacherProfile.find();
        res.status(200).json(profiles);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};