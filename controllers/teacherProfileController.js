// const TeacherProfile = require('../models/TeacherProfile');

// // Function to create a new teacher profile
// exports.createProfile = async (req, res) => {
//     try {
//         // Validate fields
//         const {name, email, phone} = req.body;
//         if (!name || !email || !phone) {
//             return res.status(400).json({message: 'Name, email and phone are required!'});
//         }

//         // Check if profile already exists
//         const existingProfile = await TeacherProfile.findOne({ email });
//         if (existingProfile) {
//             return res.status(409).json({ message: 'A profile with this email already exists!' });
//         }

//         // Create new profile
//         const newProfile = new TeacherProfile(req.body);
//         // Save the profile to the database
//         const savedProfile = await newProfile.save();
//         // Send a success message with the saved profile
//         res.status(201).json(savedProfile);

//     } catch (error) {
//         // Handle errors and send an error message
//         res.status(500).json({message: 'Erroe creating profile.', error: error.message});
//     }
// };

// // Function to get all teacher profiles
// exports.getAllProfiles = async (req, res) => {
//     try {
//         // Get all teacher profiles from the database
//         const profiles = await TeacherProfile.find();
//         if (!profiles.length) {
//             return res.status(404).json({message: 'No profiles found!'});
//         }

//         // Sends success message 
//         res.status(200).json(profiles);

//     } catch (error) {
//         // Sends error message
//         res.status(500).json({message: 'Error retrieving profiles', error: error.message});
//     }
// };

// // Function to update an existing teacher profile
// exports.updateProfile = async (req, res) => {
//     try {
//         if (!req.params.id.match(/^[0-9a-fA-F]{24}$/)) {
//             return res.status(400).json({message: 'Invalid profile ID format!'});
//         }

//         // Find the profile by ID and update it with the request body data
//         const updatedProfile = await TeacherProfile.findByIdAndUpdate(
//             req.params.id,
//             req.body,
//             { new: true, runValidators: true } // Return updated profile and run validators
//         );

//         if (!updatedProfile) {
//             return res.status(404).json({message: 'Profile not found!'});
//         }

//         res.status(200).json(updatedProfile);
//     } catch (error) {
//         res.status(500).json({message: 'Error updating profile', error: error.message});
//     }
// };

// // Function to get single profile by ID
// exports.getProfileById = async (req, res) => {
//     try {
//         if (!req.params.id.match(/^[0-9a-fA-F]{24}$/)) {
//             return res.status(400).json({message: 'Invalid profile ID format!'});
//         }

//         const profile = await TeacherProfile.findById(req.params.id);
//         if (!profile) {
//             return res.status(404).json({message: 'Profile not found!'});
//         }

//         res.status(200).json(profile);
//     } catch (error) {
//         res.status(500).json({message: 'Error retrieving profile', error: error.message});
//     }
// };

// // Function to delete profile
// exports.deleteProfile = async (req, res) => {
//     try {
//         if (!req.params.id.match(/^[0-9a-fA-F]{24}$/)) {
//             return res.status(400).json({message: 'Invalid profile ID format!'});
//         }

//         const deletedProfile = await TeacherProfile.findByIdAndDelete(req.params.id);
//         if (!deletedProfile) {
//             return res.status(404).json({message: 'Profile not found!'});
//         }

//         res.status(200).json({message: 'Profile deleted successfully!'});
//     } catch (error) {
//         res.status(500).json({message: 'Error deleting profile!', error: error.message});
//     }
// };



const TeacherProfile = require('../models/TeacherProfile');

// Create a new teacher profile
exports.createProfile = async (req, res) => {
    try {
        const newProfile = new TeacherProfile(req.body);
        const savedProfile = await newProfile.save();
        res.status(201).json(savedProfile);
    } catch (error) {
        console.error(error.message);
        res.status(500).send('Server Error');
    }
};

// Get all teacher profiles
exports.getAllProfiles = async (req, res) => {
    try {
        const profiles = await TeacherProfile.find();
        res.json(profiles);
    } catch (error) {
        console.error(error.message);
        res.status(500).send('Server Error');
    }
};

// Get a specific teacher profile by ID
exports.getProfileById = async (req, res) => {
    try {
        const profile = await TeacherProfile.findById(req.params.id);
        
        if (!profile) {
            return res.status(404).json({ msg: 'Profile not found' });
        }
        
        res.json(profile);
    } catch (error) {
        console.error(error.message);
        if (error.kind === 'ObjectId') {
            return res.status(404).json({ msg: 'Profile not found' });
        }
        res.status(500).send('Server Error');
    }
};

// Update a teacher profile
exports.updateProfile = async (req, res) => {
    try {
        const profile = await TeacherProfile.findByIdAndUpdate(
            req.params.id,
            req.body,
            { new: true }
        );
        
        if (!profile) {
            return res.status(404).json({ msg: 'Profile not found' });
        }
        
        res.json(profile);
    } catch (error) {
        console.error(error.message);
        res.status(500).send('Server Error');
    }
};

// Delete a teacher profile
exports.deleteProfile = async (req, res) => {
    try {
        const profile = await TeacherProfile.findByIdAndRemove(req.params.id);
        
        if (!profile) {
            return res.status(404).json({ msg: 'Profile not found' });
        }
        
        res.json({ msg: 'Profile removed' });
    } catch (error) {
        console.error(error.message);
        if (error.kind === 'ObjectId') {
            return res.status(404).json({ msg: 'Profile not found' });
        }
        res.status(500).send('Server Error');
    }
};