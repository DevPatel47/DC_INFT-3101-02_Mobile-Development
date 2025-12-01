const mongoose = require("mongoose");

const doctorSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, "Please provide doctor name"],
      trim: true,
    },
    department: {
      type: String,
      required: [true, "Please provide department"],
      trim: true,
    },
    bio: {
      type: String,
      default: "",
    },
    imageUrl: {
      type: String,
      default: "",
    },
    ratingAvg: {
      type: Number,
      default: 0,
      min: 0,
      max: 5,
    },
    ratingCount: {
      type: Number,
      default: 0,
      min: 0,
    },
  },
  {
    timestamps: true,
  }
);

// Index for faster search and filtering
doctorSchema.index({ name: "text", department: "text" });

module.exports = mongoose.model("Doctor", doctorSchema);
