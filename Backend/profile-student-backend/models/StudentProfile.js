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

// Create formatted class virtual (5-C)
StudentProfileSchema.virtual('formattedClass').get(function() {
  return `${this.class.grade}-${this.class.section}`;
});

// Create formatted birthday virtual (30th March 2015)
StudentProfileSchema.virtual('formattedBirthday').get(function() {
    if (!this.birthday) return '';

    const date = new Date(this.birthday);
    const day = date.getDate();
    const month = date.toLocaleString('default', { month: 'long' });
    const year = date.getFullYear();
  
// Add ordinal suffix to day
    let suffix = 'th';
    if (day === 1 || day === 21 || day === 31) {
        suffix = 'st';
    } else if (day === 2 || day === 22) {
        suffix = 'nd';
    } else if (day === 3 || day === 23) {
        suffix = 'rd';
    }
  
    return `${day}${suffix} ${month} ${year}`;
    });

// Set updatedAt before save
StudentProfileSchema.pre('save', function(next) {
    this.updatedAt = Date.now();
    next();
});

// Enable virtuals
StudentProfileSchema.set('toJSON', { virtuals: true });
StudentProfileSchema.set('toObject', { virtuals: true });

module.exports = mongoose.model('StudentProfile', StudentProfileSchema);