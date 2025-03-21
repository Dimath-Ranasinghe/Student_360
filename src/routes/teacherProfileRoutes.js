const express = require('express');
const router = express.Router();
const teacherProfileController = require('../controllers/teacherProfileController'); 

router.post('/', teacherProfileController.createProfile);
router.get('/', teacherProfileController.getAllProfiles);
router.put('/:id', teacherProfileController.updateProfile);
router.get('/:id', teacherProfileController.getProfileById);
router.delete('/:id', teacherProfileController.deleteProfile);

module.exports = router; 