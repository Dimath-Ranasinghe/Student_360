
const express = require("express");
const router = express.Router();
const StudentRecord = require("../models/StudentRecord");

router.post("/enter-marks", async (req, res) => {
  try {
    const { studentID, grade, class: className, term, subjects } = req.body;

    let student = await StudentRecord.findOne({ studentID });

    if (!student) {
      student = new StudentRecord({ studentID, grade, class: className, terms: [] });
    }

    student.terms.push({ term, subjects });

    await student.save();
    res.status(200).json({ message: "Marks saved", student });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get("/view-marks/:studentID", async (req, res) => {
  try {
    const student = await StudentRecord.findOne({ studentID: req.params.studentID });
    if (!student) return res.status(404).json({ message: "Student not found" });
    res.status(200).json(student);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.delete("/delete/:studentID", async (req, res) => {
  try {
    const student = await StudentRecord.findOneAndDelete({ studentID: req.params.studentID });
    console.log(student);
  } catch (error) {
    console.error("Error deleting student:", error);
  }
});

module.exports = router;
