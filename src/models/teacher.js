const mongoose = require("mongoose");

const teacherSchema = new mongoose.Schema({
  teacherID: { type: String, required: true, unique: true },
  name: { type: String, required: true },
  username: { type: String, required: true, unique: true },
  password: { type: String, required: true },
});

module.exports = mongoose.model("Teacher", teacherSchema);
