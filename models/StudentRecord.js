
const mongoose = require("mongoose");

const studentRecordSchema = new mongoose.Schema({
  studentID: { type: String, required: true, unique: true },
  grade: { type: Number, required: true, enum: [1,2,3,4,5] },
  class: { type: String, required: true },
  language: { type: String },
  religion: { type: String },
  terms: [
    {
      term: { type: String, required: true },
      subjects: [
        {
          subjectName: { type: String, required: true },
          marks: { type: Number },
        },
      ],
    },
  ],
});

const StudentRecord = mongoose.model("StudentRecord", studentRecordSchema);
module.exports = StudentRecord;

