const mongoose = require('mongoose');

const StudentProfileSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Please add student name'],
    trim: true
  },
  contactNumber: {
    father: {
      type: String,
      required: [true, 'Please add father\'s contact number']
    },
    mother: {
      type: String,
      required: [true, 'Please add mother\'s contact number']
    }
  },
  email: {
    type: String,
    required: [true, 'Please add an email address'],
    match: [
      /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,
      'Please add a valid email'
    ]
  },
  birthday: {
    type: Date,
    required: [true, 'Please add date of birth']
  },
  bloodType: {
    type: String,
    required: [true, 'Please add blood type'],
    enum: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
  },
  class: {
    grade: {
      type: String,
      required: [true, 'Please add class grade']
    },
    section: {
      type: String,
      required: [true, 'Please add class section']
    }
  },
  classTeacher: {
    type: String,
    required: [true, 'Please add class teacher name']
  },
  profileImage: {
    type: String,
    default: 'default-student.png'
  },
  createdAt: {
    type: Date,
    default: Date.now
  },
  updatedAt: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model('StudentProfile', StudentProfileSchema);