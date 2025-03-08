
require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const studentRoutes = require("./routes/studentRoutes");

const app = express();
const PORT = process.env.PORT || 5000;
const MONGO_URI = process.env.MONGO_URI;

if (!MONGO_URI) {
  console.error(" Missing MONGO_URI in .env file");
  process.exit(1);
}

app.use(express.json());

//Default Route
app.get("/", (req, res) => {
  res.send("Student360 Backend is Running...");
});

//Database Connection
app.use("/api/students", studentRoutes);
mongoose.connect(MONGO_URI)
.then(() => console.log("MongoDB Connected"))
.catch((err)=>{
  console.error("Database connection error:", err);
  process.exit(1);
});

//Start Server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
