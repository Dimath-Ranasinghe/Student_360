const mongoose = require("mongoose");

const UserSchema = new mongoose.Schema({
  userId: { type: String, required: true, unique: true },
  name: { type: String, required: true },
  role: { type: String, enum: ["teacher", "student"], required: true }
});

module.exports = mongoose.model("User", UserSchema);
