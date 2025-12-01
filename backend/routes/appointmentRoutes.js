const express = require("express");
const router = express.Router();
const {
  createAppointment,
  getMyAppointments,
  getNextAppointment,
  cancelAppointment,
} = require("../controllers/appointmentController");
const { protect } = require("../middleware/authMiddleware");

// All appointment routes are private
router.post("/", protect, createAppointment);
router.get("/me", protect, getMyAppointments);
router.get("/me/next", protect, getNextAppointment);
router.patch("/:id/cancel", protect, cancelAppointment);

module.exports = router;
