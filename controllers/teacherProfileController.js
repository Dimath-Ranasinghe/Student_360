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

exports.updateProfile = async (req, res) => {
    try {
        const updatedProfile = await TeacherProfile.findByIdAndUpdate(
            req.params.id,
            req.body,
            { new: true, runValidators: true }
        );
        if (!updatedProfile) {
            return res.status(404).json({ message: 'Profile not found' });
        }
        res.status(200).json(updatedProfile);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};