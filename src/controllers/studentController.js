const StudentRecord = require("../models/StudentRecord");
const Student = require("../models/student");

const FIXED_SUBJECTS=["Mathematics", "English", "Language", "Religion", "Environmental Studies"];

// Add a student to the school database
const addStudent = async (req, res) => {
  try {
    const { studentID, name, grade, class: className, username, password } = req.body;

    if (!studentID || !name || !grade || !className || !username || !password) {
      return res.status(400).json({ message: "Missing required fields" });
    }

    const existingStudent = await Student.findOne({ studentID });

    if (existingStudent) {
      return res.status(400).json({ message: "Student already exists" });
    }

    const student = new Student({ studentID, name, grade, class: className, username, password });
    await student.save();
    
    res.status(201).json({ message: "Student added successfully", student });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Enter or update student marks
const enterMarks = async (req, res) => {
  try {
    const { studentID, grade, class: className, term, subjects, totalDaysHeld, totalDaysAttended } = req.body;
    if (!studentID || !grade || !className || !term || !subjects || !totalDaysHeld || !totalDaysAttended) {
      return res.status(400).json({ message: "Missing required fields" });
    }

    // Check if student exists
    const existingStudent = await Student.findOne({ studentID });

    if (!existingStudent) {
      return res.status(404).json({ message: "Student not found in the school database." });
    }

    console.log("Received Data from Flutter:", req.body);  
    console.log("Stored Student Data from MongoDB:", existingStudent);
    const gradeAsInt = parseInt(grade, 10);

    // Validate grade and class
    if (existingStudent.grade !== gradeAsInt || existingStudent.class !== className) {
      return res.status(400).json({ message: "Grade or Class does not match the school records." });
    }

    // Ensure fixed subjects are present, add if missing
    const subjectsWithFixed = FIXED_SUBJECTS.map(subject => {
      const existing = subjects.find(s => s.subjectName === subject);
      return existing || { subjectName: subject, marks: 0 };
    });

    // Include additional subjects provided by the teacher
    const finalSubjects = [
      ...subjectsWithFixed,
      ...subjects.filter(s => !FIXED_SUBJECTS.includes(s.subjectName))
    ];

    const totalMarks = finalSubjects.reduce((sum, subject) => sum + subject.marks, 0);
    const average = finalSubjects.length > 0 ? totalMarks / finalSubjects.length : 0;

    let studentRecord = await StudentRecord.findOne({ studentID });

    if (!studentRecord) {
      studentRecord = new StudentRecord({ studentID, grade, class: className, terms: [] });
    }

    const termIndex = studentRecord.terms.findIndex(t => t.term === term);

    if (termIndex !== -1) {
      studentRecord.terms[termIndex] = { term, subjects: finalSubjects, totalMarks, average, totalDaysHeld, totalDaysAttended };
    } else {
      studentRecord.terms.push({ term, subjects: finalSubjects, totalMarks, average, totalDaysHeld, totalDaysAttended });
    }

    await studentRecord.save();
    res.status(200).json({ message: "Marks updated successfully", studentRecord });
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

module.exports = { enterMarks, viewMarks, deleteStudent, addStudent };
