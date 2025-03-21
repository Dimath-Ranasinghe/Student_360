const mongoose = require("mongoose");

const studentRecordSchema = new mongoose.Schema({
  studentID: { type: String, required: true, unique: true },
  grade: { type: Number, required: true, enum: [1, 2, 3, 4, 5] },
  class: { type: String, required: true, match: /^[A-Z]$/ },
  
  terms: [
    {
      term: { type: String, enum: ["1st Term", "2nd Term", "3rd Term"], required: true },
      subjects: [
        {
           subjectName:{type: String, required:true },
           marks:{type:Number, default:0}
        }
      ],
      totalMarks: { type: Number, default: 0 },
      average: { type: Number, default: 0 },
      totalDaysHeld: { type: Number, required: true },
      totalDaysAttended: { type: Number, required: true },
    },
  ],
});

module.exports = mongoose.model("StudentRecord", studentRecordSchema);
