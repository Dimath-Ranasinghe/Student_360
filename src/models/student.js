const mongoose = require("mongoose");
const bcrypt = require("bcrypt");

const studentSchema = new mongoose.Schema({
  studentID: { type: String, required: true, unique: true },
  name: { type: String, required: true },
  grade: { type: Number, required: true, enum: [1,2,3,4,5]},
  class: { type: String, required: true, match: /^[A-Z]$/ },
  username: { type: String, required: true, unique: true },
  password: { type: String, required: true }
});

// Hash password before saving
studentSchema.pre("save", async function (next) {
  if (!this.isModified("password")) return next();
  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
  next();
});

const Student = mongoose.model("Student", studentSchema);
module.exports = Student;