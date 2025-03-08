const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.send('Notices route');
});

module.exports = router;
