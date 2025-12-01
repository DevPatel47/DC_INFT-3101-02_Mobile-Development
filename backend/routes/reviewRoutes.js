const express = require("express");
const router = express.Router();
const {
  createOrUpdateReview,
  getReviewsByDoctor,
} = require("../controllers/reviewController");
const { protect } = require("../middleware/authMiddleware");

// Create/update review (private)
router.post("/", protect, createOrUpdateReview);

// Get reviews by doctor (public)
router.get("/:doctorId", getReviewsByDoctor);

module.exports = router;
