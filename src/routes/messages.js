const express = require("express");
const messagesController = require("../controllers/messageController");

const router = express.Router();

router.get("/", messagesController.getMessages);
router.post("/", messagesController.createMessage);

module.exports = router;
