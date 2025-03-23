const mongoose = require('mongoose');
const TeacherProfile = require('../models/TeacherProfile');
const path = require('path');
const fs = require('fs');

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
        
        const profile = await TeacherProfile.findById(req.params.id);
        
        if (!profile) {
            return res.status(404).json({ msg: 'Profile not found' });
        }
        
        // Remove custom profile image if not the default
        if (profile.profilePicture !== 'default-teacher.png') {
            const imagePath = path.join(__dirname, '../public/uploads', profile.profilePicture);
            if (fs.existsSync(imagePath)) {
                fs.unlinkSync(imagePath);
            }
        }
        
        await profile.deleteOne();
        
        res.json({ msg: 'Profile removed' });
    } catch (error) {
        console.error(error.message);
        res.status(500).json({ msg: 'Server Error', error: error.message });
    }
};

// Upload teacher profile picture
exports.uploadProfilePicture = async (req, res) => {
    try {
        const teacher = await TeacherProfile.findById(req.params.id);
        
        if (!teacher) {
            return res.status(404).json({
                success: false,
                message: 'Teacher profile not found'
            });
        }
        
        // Check if file was uploaded
        if (!req.files || !req.files.file) {
            return res.status(400).json({
                success: false,
                message: 'Please upload a file'
            });
        }
        
        const file = req.files.file;
        
        // Check file type
        if (!file.mimetype.startsWith('image')) {
            return res.status(400).json({
                success: false,
                message: 'Please upload an image file'
            });
        }
        
        // Check file size
        if (file.size > process.env.MAX_FILE_SIZE) {
            return res.status(400).json({
                success: false,
                message: `Please upload an image less than ${process.env.MAX_FILE_SIZE / 1000000} MB`
            });
        }
        
        // Create custom filename
        file.name = `teacher_${teacher._id}${path.parse(file.name).ext}`;
        
        // Remove old profile image if not the default
        if (teacher.profilePicture !== 'default-teacher.png') {
            const oldImagePath = path.join(__dirname, '../public/uploads', teacher.profilePicture);
            if (fs.existsSync(oldImagePath)) {
                fs.unlinkSync(oldImagePath);
            }
        }
        
        // Move file to uploads folder
        file.mv(`${process.env.FILE_UPLOAD_PATH}/${file.name}`, async err => {
            if (err) {
                console.error(err);
                return res.status(500).json({
                    success: false,
                    message: 'Problem with file upload'
                });
            }
            
            // Update database
            await TeacherProfile.findByIdAndUpdate(req.params.id, { profilePicture: file.name });
            
            res.status(200).json({
                success: true,
                data: file.name
            });
        });
    } catch (err) {
        res.status(500).json({
            success: false,
            message: 'Server Error',
            error: err.message
        });
    }
};