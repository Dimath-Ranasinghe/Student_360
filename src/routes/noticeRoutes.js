const express = require("express");
const { createNotice, getNotices, deleteNotice } = require("../controllers/noticeController");

const router = express.Router();

// Routes
router.post("/", createNotice);
router.get("/", getNotices);
router.delete("/:id", deleteNotice);

module.exports = router;
