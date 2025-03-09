const TeacherProfile = require('../models/TeacherProfile');

// Function to create a new teacher profile
exports.createProfile = async (req, res) => {
    try {
        const newProfile = new TeacherProfile(req.body);
        // Save the profile to the database
        const savedProfile = await newProfile.save();
        // Send a success message with the saved profile
        res.status(201).json(savedProfile);

    } catch (error) {
        // Handle errors and send an error message
        res.status(500).json({ error: error.message });
    }
};

// Function to get all teacher profiles
exports.getAllProfiles = async (req, res) => {
    try {
        // Get all teacher profiles from the database
        const profiles = await TeacherProfile.find();
        // Sends success message 
        res.status(200).json(profiles);
    } catch (error) {
        // Sends error message
        res.status(500).json({ error: error.message });
    }
};

// Function to update an existing teacher profile
exports.updateProfile = async (req, res) => {
    try {
        // Find the profile by ID and update it with the request body data
        const updatedProfile = await TeacherProfile.findByIdAndUpdate(
            req.params.id,
            req.body,
            { new: true, runValidators: true } // Return updated profile and run validators
        );
        if (!updatedProfile) {
            return res.status(404).json({ message: 'Profile not found' });
        }
        res.status(200).json(updatedProfile);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// Function to get single profile by ID
exports.getProfileById = async (req, res) => {
    try {
        const profile = await TeacherProfile.findById(req.params.id);
        if (!profile) {
            return res.status(404).json({ message: 'Profile not found' });
        }
        res.status(200).json(profile);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// Function to delete profile
exports.deleteProfile = async (req, res) => {
    try {
        const deletedProfile = await TeacherProfile.findByIdAndDelete(req.params.id);
        if (!deletedProfile) {
            return res.status(404).json({ message: 'Profile not found' });
        }
        res.status(200).json({ message: 'Profile deleted successfully' });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};