
const express = require("express");
const router = express.Router();
const StudentRecord = require("../models/StudentRecord");

//API to enter or update marks
router.post("/enter-marks", async (req, res) => {
  try {
    const { studentID, grade, class: className, language, religion, term, subjects, totalDaysHeld, totalDaysAttended } = req.body;
    if (!studentID || !grade || !className || !language || !religion || !term || !subjects || !totalDaysHeld || !totalDaysAttended) {
      return res.status(400).json({ message: "Missing required fields" });
    }
    
    const totalMarks = subjects.reduce((sum, subject)=> sum+ subject.marks, 0);
    const average = subjects.length > 0 ? totalMarks / subjects.length : 0;

    let student = await StudentRecord.findOne({ studentID });

    if (!student) {
      student = new StudentRecord({ studentID, grade, class: className, language, religion, terms: [] });
    }

    const termIndex = student.terms.findIndex((t) => t.term === term);

    if (termIndex !== -1) {
      student.terms[termIndex] = { term, subjects, totalMarks, average, totalDaysHeld, totalDaysAttended };
    } else {
      student.terms.push({ term, subjects, totalMarks, average, totalDaysHeld, totalDaysAttended });
    }

    await student.save();
    res.status(200).json({ message: "Marks updated successfully", student });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//API to get student marks
router.get("/view-marks/:studentID", async (req, res) => {
  try {
    const { studentID } = req.params;
    const student = await StudentRecord.findOne({ studentID });

    if (!student) {
      return res.status(404).json({ message: "Student not found" });
    }

    res.status(200).json(student);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//Delete student record by studentID
router.delete("/delete/:studentID", async (req, res) => {
  try {
    const { studentID } = req.params;
    const student = await StudentRecord.findOneAndDelete({ studentID });

    if (!student) {
      return res.status(404).json({ message: "Student not found" });
    }

    res.status(200).json({ message: " Student record deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }

});

module.exports = router;
