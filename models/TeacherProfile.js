const mongoose = require('mongoose');

const teacherProfileSchema = new mongoose.Schema({
    fullName: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    phone: { type: String },
    subjects: { type: [String], default: [] },
    profilePicture: { type: String }, 
    bio: { type: String },
    createdAt: { type: Date, default: Date.now },
});

const TeacherProfile = mongoose.model('TeacherProfile', teacherProfileSchema);

module.exports = TeacherProfile;