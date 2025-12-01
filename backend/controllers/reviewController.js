const Review = require("../models/Review");
const Doctor = require("../models/Doctor");
const catchAsync = require("../utils/catchAsync");

// @desc    Create or update a review
// @route   POST /api/reviews
// @access  Private
exports.createOrUpdateReview = catchAsync(async (req, res) => {
  const { doctorId, rating, comment } = req.body;

  // Validate input
  if (!doctorId || !rating) {
    return res.status(400).json({
      success: false,
      message: "Please provide doctorId and rating",
    });
  }

  // Validate rating range
  if (rating < 1 || rating > 5) {
    return res.status(400).json({
      success: false,
      message: "Rating must be between 1 and 5",
    });
  }

  // Check if doctor exists
  const doctor = await Doctor.findById(doctorId);

  if (!doctor) {
    return res.status(404).json({
      success: false,
      message: "Doctor not found",
    });
  }

  // Check if review already exists
  let review = await Review.findOne({
    userId: req.user.id,
    doctorId,
  });

  let isNew = false;

  if (review) {
    // Update existing review
    review.rating = rating;
    review.comment = comment || "";
    await review.save();
  } else {
    // Create new review
    review = await Review.create({
      userId: req.user.id,
      doctorId,
      rating,
      comment: comment || "",
    });
    isNew = true;
  }

  // Recalculate doctor's average rating
  const reviews = await Review.find({ doctorId });
  const totalRating = reviews.reduce((sum, r) => sum + r.rating, 0);
  const avgRating = totalRating / reviews.length;

  doctor.ratingAvg = Math.round(avgRating * 10) / 10;
  doctor.ratingCount = reviews.length;
  await doctor.save();

  // Populate user details
  await review.populate("userId", "name");

  res.status(isNew ? 201 : 200).json({
    success: true,
    message: isNew
      ? "Review created successfully"
      : "Review updated successfully",
    data: review,
  });
});

// @desc    Get all reviews for a doctor
// @route   GET /api/reviews/:doctorId
// @access  Public
exports.getReviewsByDoctor = catchAsync(async (req, res) => {
  const reviews = await Review.find({ doctorId: req.params.doctorId })
    .populate("userId", "name")
    .sort({ createdAt: -1 });

  res.status(200).json({
    success: true,
    count: reviews.length,
    data: reviews,
  });
});
