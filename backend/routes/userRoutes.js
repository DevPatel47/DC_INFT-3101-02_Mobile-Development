const express = require("express");
const router = express.Router();
const {
  getProfile,
  updateProfile,
  updatePassword,
} = require("../controllers/userController");
const { protect } = require("../middleware/authMiddleware");

// All user routes are private
router.get("/me", protect, getProfile);
router.patch("/me", protect, updateProfile);
router.patch("/me/password", protect, updatePassword);

module.exports = router;
