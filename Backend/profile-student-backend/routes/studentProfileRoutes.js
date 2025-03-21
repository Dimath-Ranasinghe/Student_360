const express = require('express');
const router = express.Router();

const {
    getStudentProfiles,
    getStudentProfile,
    createStudentProfile,
    updateStudentProfile,
    deleteStudentProfile,
    uploadStudentPhoto
} = require('../controllers/studentProfileController');

// Main routes
router.route('/')
.get(getStudentProfiles)
.post(createStudentProfile);

router.route('/:id')
.get(getStudentProfile)
.put(updateStudentProfile)
.delete(deleteStudentProfile);

// Photo upload route
router.route('/:id/photo')
.put(uploadStudentPhoto);

module.exports = router;