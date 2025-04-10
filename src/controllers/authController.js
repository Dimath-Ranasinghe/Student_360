const Student = require("../models/student");
const Teacher = require("../models/teacher");
const bcrypt = require("bcrypt");

const loginUser = async (req, res) => {
  try {
    const { userID, password } = req.body;

    if (!userID || !password) {
      return res.status(400).json({ message: "Missing user ID or password" });
    }

    // Check if the user is a student
    let user = await Student.findOne({ studentID: userID });
    let role = "student";

    if (!user) {
      // If not found, check if it's a teacher
      user = await Teacher.findOne({ teacherID: userID });
      role = "teacher";
    }

    if (!user) {
      return res.status(401).json({ message: "Invalid user ID or password" });
    }

    // Compare hashed password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: "Invalid user ID or password" });
    }

    res.status(200).json({ message: "Login successful", role });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = { loginUser };

