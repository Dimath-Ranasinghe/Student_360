const express = require("express");
const { enterMarks, viewMarks, deleteStudent, addStudent } = require("../controllers/studentController");
const router = express.Router();

router.post("/enter-marks", enterMarks);
router.post("/add-student", addStudent);
router.get("/view-marks/:studentID", viewMarks);
router.delete("/delete/:studentID", deleteStudent);

module.exports = router;
