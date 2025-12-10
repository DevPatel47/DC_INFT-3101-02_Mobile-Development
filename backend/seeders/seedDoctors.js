const mongoose = require("mongoose");
const Doctor = require("../models/Doctor");
require("dotenv").config();

const doctors = [
  {
    name: "Dr. Sarah Johnson",
    department: "Cardiology",
    bio: "Board-certified cardiologist with over 15 years of experience in treating heart diseases and performing cardiac procedures.",
    imageUrl: "https://randomuser.me/api/portraits/women/44.jpg",
    ratingAvg: 4.8,
    ratingCount: 124,
  },
  {
    name: "Dr. Michael Chen",
    department: "Pediatrics",
    bio: "Experienced pediatrician specializing in child healthcare, growth monitoring, and immunizations.",
    imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
    ratingAvg: 4.9,
    ratingCount: 156,
  },
  {
    name: "Dr. Emily Rodriguez",
    department: "Dermatology",
    bio: "Dermatology specialist focusing on skin conditions, cosmetic procedures, and skin cancer prevention.",
    imageUrl: "https://randomuser.me/api/portraits/women/68.jpg",
    ratingAvg: 4.7,
    ratingCount: 98,
  },
  {
    name: "Dr. James Williams",
    department: "Orthopedics",
    bio: "Orthopedic surgeon with expertise in joint replacement, sports injuries, and bone disorders.",
    imageUrl: "https://randomuser.me/api/portraits/men/52.jpg",
    ratingAvg: 4.6,
    ratingCount: 87,
  },
  {
    name: "Dr. Priya Patel",
    department: "Neurology",
    bio: "Neurologist specializing in brain and nervous system disorders, including migraines and epilepsy.",
    imageUrl: "https://randomuser.me/api/portraits/women/72.jpg",
    ratingAvg: 4.9,
    ratingCount: 142,
  },
  {
    name: "Dr. Robert Taylor",
    department: "General Medicine",
    bio: "General practitioner providing comprehensive healthcare for patients of all ages.",
    imageUrl: "https://randomuser.me/api/portraits/men/67.jpg",
    ratingAvg: 4.5,
    ratingCount: 203,
  },
  {
    name: "Dr. Lisa Anderson",
    department: "Ophthalmology",
    bio: "Eye care specialist experienced in cataract surgery, LASIK, and treatment of eye diseases.",
    imageUrl: "https://randomuser.me/api/portraits/women/85.jpg",
    ratingAvg: 4.8,
    ratingCount: 112,
  },
  {
    name: "Dr. David Kim",
    department: "Psychiatry",
    bio: "Psychiatrist specializing in mental health disorders, anxiety, depression, and cognitive therapy.",
    imageUrl: "https://randomuser.me/api/portraits/men/41.jpg",
    ratingAvg: 4.7,
    ratingCount: 89,
  },
  {
    name: "Dr. Maria Garcia",
    department: "Gynecology",
    bio: "Gynecologist providing comprehensive women's health services including prenatal care.",
    imageUrl: "https://randomuser.me/api/portraits/women/91.jpg",
    ratingAvg: 4.9,
    ratingCount: 167,
  },
  {
    name: "Dr. Kevin Brown",
    department: "ENT",
    bio: "Ear, Nose, and Throat specialist treating conditions related to head and neck disorders.",
    imageUrl: "https://randomuser.me/api/portraits/men/78.jpg",
    ratingAvg: 4.6,
    ratingCount: 76,
  },
  {
    name: "Dr. Amanda White",
    department: "Endocrinology",
    bio: "Endocrinologist specializing in diabetes, thyroid disorders, and hormonal imbalances.",
    imageUrl: "https://randomuser.me/api/portraits/women/12.jpg",
    ratingAvg: 4.8,
    ratingCount: 94,
  },
  {
    name: "Dr. Thomas Lee",
    department: "Gastroenterology",
    bio: "Gastroenterologist with expertise in digestive system disorders and endoscopic procedures.",
    imageUrl: "https://randomuser.me/api/portraits/men/25.jpg",
    ratingAvg: 4.7,
    ratingCount: 105,
  },
  {
    name: "Dr. Jessica Martinez",
    department: "Cardiology",
    bio: "Cardiologist specializing in preventive cardiology and non-invasive cardiac testing.",
    imageUrl: "https://randomuser.me/api/portraits/women/38.jpg",
    ratingAvg: 4.9,
    ratingCount: 131,
  },
  {
    name: "Dr. Daniel Harris",
    department: "Urology",
    bio: "Urologist treating kidney stones, prostate conditions, and urinary tract disorders.",
    imageUrl: "https://randomuser.me/api/portraits/men/64.jpg",
    ratingAvg: 4.5,
    ratingCount: 68,
  },
  {
    name: "Dr. Rachel Thompson",
    department: "Pediatrics",
    bio: "Pediatrician with special interest in developmental disorders and childhood nutrition.",
    imageUrl: "https://randomuser.me/api/portraits/women/55.jpg",
    ratingAvg: 4.8,
    ratingCount: 144,
  },
];

const seedDoctors = async () => {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log("Connected to MongoDB");

    await Doctor.deleteMany({});
    console.log("Existing doctors deleted");

    const createdDoctors = await Doctor.insertMany(doctors);
    console.log(`${createdDoctors.length} doctors created successfully`);

    mongoose.connection.close();
    console.log("Database connection closed");
  } catch (error) {
    console.error("Error seeding doctors:", error);
    process.exit(1);
  }
};

seedDoctors();
