
const mongoose = require("mongoose");

const studentRecordSchema = new mongoose.Schema({
  studentID: { type: String, required: true, unique: true },
  grade: { type: Number, required: true, enum: [1,2,3,4,5] },
  class: { type: String, required: true, match:/^[A-Z]$/ },
  language: { type: String, enum:["Sinhala", "Tamil"], required:true },
  religion: { type: String, enum:["Buddhism", "Hinduism", "Islam", "Christianity"], required:true },
  terms: [
    {
      term: { type: String, enum:["1st Term", "2nd Term", "3rd Term"], required: true },
      subjects: [
        {
          subjectName: { type: String, required: true },
          marks: { type: Number, required: true, min:0, max:100 },
        },
      ],
      totalMarks:{type: Number,default:0},
      average:{type: Number, default:0},
    },
  ],
});

const StudentRecord = mongoose.model("StudentRecord", studentRecordSchema);
module.exports = StudentRecord;

