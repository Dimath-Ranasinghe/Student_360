const mongoose = require('mongoose');
const TeacherProfile = require('../models/TeacherProfile');

// Create a new teacher profile
exports.createProfile = async (req, res) => {
    try {
        // Validate required fields
        const { fullName, email, phone } = req.body;
        if (!fullName || !email || !phone) {
            return res.status(400).json({ msg: 'Full name, email, and phone are required fields' });
        }

        // Check if profile already exists with this email - ensure we normalize the email
        const normalizedEmail = email.toLowerCase().trim();
        const existingProfile = await TeacherProfile.findOne({ email: normalizedEmail });
        if (existingProfile) {
            return res.status(409).json({ msg: 'A profile with this email already exists' });
        }

        // Create the new profile with normalized email
        const profileData = {
            ...req.body,
            email: normalizedEmail
        };
        
        const newProfile = new TeacherProfile(profileData);
        const savedProfile = await newProfile.save();
        res.status(201).json(savedProfile);
    } catch (error) {
        console.error('Profile creation error:', error);
        
        // Check for MongoDB duplicate key error (code 11000)
        if (error.code === 11000) {
            return res.status(409).json({ 
                msg: 'A profile with this email already exists',
                detail: error.message 
            });
        }
        
        // Handle mongoose validation errors
        if (error.name === 'ValidationError') {
            return res.status(400).json({ msg: 'Validation error', errors: error.errors });
        }
        
        res.status(500).json({ msg: 'Server Error', error: error.message });
    }
};

// Get all teacher profiles
exports.getAllProfiles = async (req, res) => {
    try {
        const profiles = await TeacherProfile.find();
        
        // Optional: Check if any profiles were found
        if (!profiles.length) {
            return res.status(404).json({ msg: 'No profiles found' });
        }
        
        res.json(profiles);
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ msg: 'Server Error', error: error.message });
    }
};

// Get a specific teacher profile by ID
exports.getProfileById = async (req, res) => {
    try {
        // Check if ID is valid MongoDB ObjectId format
        if (!mongoose.Types.ObjectId.isValid(req.params.id)) {
            return res.status(400).json({ msg: 'Invalid profile ID format' });
        }
        
        const profile = await TeacherProfile.findById(req.params.id);
        
        if (!profile) {
            return res.status(404).json({ msg: 'Profile not found' });
        }
        
        res.json(profile);
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ msg: 'Server Error', error: error.message });
    }
};

// Update a teacher profile
exports.updateProfile = async (req, res) => {
    try {
        // Check if ID is valid MongoDB ObjectId format
        if (!mongoose.Types.ObjectId.isValid(req.params.id)) {
            return res.status(400).json({ msg: 'Invalid profile ID format' });
        }
        
        // Normalize email if present in update data
        const updateData = { ...req.body };
        if (updateData.email) {
            // First check if the new email exists on another document
            const normalizedEmail = updateData.email.toLowerCase().trim();
            const existingProfile = await TeacherProfile.findOne({ 
                email: normalizedEmail,
                _id: { $ne: req.params.id } // Exclude current profile
            });
            
            if (existingProfile) {
                return res.status(409).json({ msg: 'Another profile with this email already exists' });
            }
            
            updateData.email = normalizedEmail;
        }
        
        const profile = await TeacherProfile.findByIdAndUpdate(
            req.params.id,
            updateData,
            { new: true, runValidators: true } // Enable validation on update
        );
        
        if (!profile) {
            return res.status(404).json({ msg: 'Profile not found' });
        }
        
        res.json(profile);
    } catch (error) {
        console.error(error.message);
        
        // Check for MongoDB duplicate key error (code 11000)
        if (error.code === 11000) {
            return res.status(409).json({ 
                msg: 'Another profile with this email already exists',
                detail: error.message 
            });
        }
        
        if (error.name === 'ValidationError') {
            return res.status(400).json({ msg: 'Validation error', errors: error.errors });
        }
        
        res.status(500).json({ msg: 'Server Error', error: error.message });
    }
};

// Delete a teacher profile
exports.deleteProfile = async (req, res) => {
    try {
        // Check if ID is valid MongoDB ObjectId format
        if (!mongoose.Types.ObjectId.isValid(req.params.id)) {
            return res.status(400).json({ msg: 'Invalid profile ID format' });
        }
        
        const profile = await TeacherProfile.findByIdAndDelete(req.params.id);
        
        if (!profile) {
            return res.status(404).json({ msg: 'Profile not found' });
        }
        
        res.json({ msg: 'Profile removed' });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ msg: 'Server Error', error: error.message });
    }
};