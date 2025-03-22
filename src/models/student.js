const mongoose = require("mongoose");

const studentSchema = new mongoose.Schema({
  studentID: { type: String, required: true, unique: true },
  name: { type: String, required: true },
  grade: { type: Number, required: true, enum: [1, 2, 3, 4, 5] },
  class: { type: String, required: true, match: /^[A-Z]$/ },
  username: { type: String, required: true, unique: true },
  password: { type: String, required: true }, 
});

module.exports = mongoose.model("Student", studentSchema);
