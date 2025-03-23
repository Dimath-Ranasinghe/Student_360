const mongoose = require('mongoose');

const StudentProfileSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'Please add student name'],
        trim: true,
        minlength: [2, 'Name must be at least 2 characters'],
        maxlength: [50, 'Name cannot be more than 50 characters']
    },
    contactNumber: {
        father: {
            type: String,
            required: [true, 'Please add father\'s contact number'],
            match: [
                /^\d{10}$/,
                'Please add a valid 10-digit contact number'
            ]
        },
        mother: {
            type: String,
            required: [true, 'Please add mother\'s contact number'],
            match: [
                /^\d{10}$/,
                'Please add a valid 10-digit contact number'
            ]
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
        required: [true, 'Please add date of birth'],
        validate: {
            validator: function(value) {
                return value <= new Date();
            },
            message: 'Birthday cannot be in the future'
        }
    },
    bloodType: {
        type: String,
        required: [true, 'Please add blood type'],
        enum: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
    },
    class: {
        grade: {
            type: String,
            required: [true, 'Please add class grade'],
            match: [
                /^([1-9]|1[0-2])$/,
                'Grade must be a number between 1 and 12'
            ]
        },
        section: {
            type: String,
            required: [true, 'Please add class section'],
            match: [
                /^[A-Z]$/,
                'Section must be a single uppercase letter'
            ]
        }
    },
    classTeacher: {
        type: String,
        required: [true, 'Please add class teacher name'],
        minlength: [2, 'Teacher name must be at least 2 characters'],
        maxlength: [50, 'Teacher name cannot be more than 50 characters']
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