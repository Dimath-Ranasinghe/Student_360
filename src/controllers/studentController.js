const StudentRecord = require("../models/StudentRecord");

const FIXED_SUBJECTS=["Mathematics", "English", "Language", "Religion", "Environmental Studies"];

// Enter or update student marks
const enterMarks = async (req, res) => {
  try {
    const { studentID, grade, class: className, language, religion, term, subjects, totalDaysHeld, totalDaysAttended } = req.body;
    if (!studentID || !grade || !className || !language || !religion || !term || !subjects || !totalDaysHeld || !totalDaysAttended) {
      return res.status(400).json({ message: "Missing required fields" });
    }

    // Ensure fixed subjects are present, add if missing
    const subjectsWithFixed = FIXED_SUBJECTS.map(subject => {
      const existing =subjects.find(s => s.subjectName === subject);
      return existing || {subjectName : subject, marks:0};
    });

    // Include additional subjects provided by the teacher
    const finalSubjects = [
      ...subjectsWithFixed,
      ...subjects.filter(s => !FIXED_SUBJECTS.includes(s.subjectName))
    ];
    
    const totalMarks = finalSubjects.reduce((sum, subject) => sum + subject.marks, 0);
    const average = finalSubjects.length > 0 ? totalMarks / finalSubjects.length : 0;

    let student = await StudentRecord.findOne({ studentID });

    if (!student) {
      student = new StudentRecord({ studentID, grade, class: className, terms: [] });
    }

    const termIndex = student.terms.findIndex(t => t.term === term);

    if (termIndex !== -1) {
      student.terms[termIndex] = { term, subjects: finalSubjects, totalMarks, average, totalDaysHeld, totalDaysAttended };
    } else {
      student.terms.push({ term, subjects: finalSubjects, totalMarks, average, totalDaysHeld, totalDaysAttended });
    }

    await student.save();
    res.status(200).json({ message: "Marks updated successfully", student });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get student marks
const viewMarks = async (req, res) => {
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
};

// Delete student record
const deleteStudent = async (req, res) => {
  try {
    const { studentID } = req.params;
    const student = await StudentRecord.findOneAndDelete({ studentID });

    if (!student) {
      return res.status(404).json({ message: "Student not found" });
    }

    res.status(200).json({ message: "Student record deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = { enterMarks, viewMarks, deleteStudent };
