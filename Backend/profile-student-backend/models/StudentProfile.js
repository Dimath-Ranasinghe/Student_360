const mongoose = require('mongoose');

const StudentProfileSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Please add student name'],
    trim: true
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
  }
});

module.exports = mongoose.model('StudentProfile', StudentProfileSchema);