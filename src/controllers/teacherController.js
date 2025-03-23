const Teacher = require("../models/teacher");

// Register a new teacher
const registerTeacher = async (req, res) => {
    try {
        const { teacherID, name, username, password } = req.body;

        if (!teacherID || !name || !username || !password) {
            return res.status(400).json({ message: "Missing required fields" });
        }

        const existingTeacher = await Teacher.findOne({ username });
        if (existingTeacher) {
            return res.status(400).json({ message: "Username already taken" });
        }

        const teacher = new Teacher({ teacherID, name, username, password });
        await teacher.save();

        res.status(201).json({ message: "Teacher registered successfully", teacher });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

module.exports = { registerTeacher };
