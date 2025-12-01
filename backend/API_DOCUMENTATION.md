# LakeridgeCare API Documentation

## Base URL

```
http://localhost:5000/api
```

## Authentication

Most endpoints require JWT authentication. Include the token in the Authorization header:

```
Authorization: Bearer <your_jwt_token>
```

---

## Table of Contents

1. [Authentication](#authentication-endpoints)
2. [Users](#user-endpoints)
3. [Doctors](#doctor-endpoints)
4. [Appointments](#appointment-endpoints)
5. [Reviews](#review-endpoints)
6. [Error Responses](#error-responses)

---

## Authentication Endpoints

### 1. Register User

**POST** `/auth/register`

Create a new user account.

**Request Body:**

```json
{
  "name": "John Doe",
  "email": "john.doe@example.com",
  "phone": "1234567890",
  "password": "password123",
  "theme": "light"
}
```

**Success Response (201):**

```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "user": {
      "id": "65a1b2c3d4e5f6g7h8i9j0k1",
      "name": "John Doe",
      "email": "john.doe@example.com",
      "phone": "1234567890",
      "theme": "light"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

**Error Response (400):**

```json
{
  "success": false,
  "message": "User with this email already exists"
}
```

---

### 2. Login User

**POST** `/auth/login`

Authenticate user and receive JWT token.

**Request Body:**

```json
{
  "email": "john.doe@example.com",
  "password": "password123"
}
```

**Success Response (200):**

```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": "65a1b2c3d4e5f6g7h8i9j0k1",
      "name": "John Doe",
      "email": "john.doe@example.com",
      "phone": "1234567890",
      "theme": "light"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

**Error Response (401):**

```json
{
  "success": false,
  "message": "Invalid credentials"
}
```

---

### 3. Get Current User

**GET** `/auth/me`

Get authenticated user's information.

**Headers:**

```
Authorization: Bearer <token>
```

**Success Response (200):**

```json
{
  "success": true,
  "data": {
    "id": "65a1b2c3d4e5f6g7h8i9j0k1",
    "name": "John Doe",
    "email": "john.doe@example.com",
    "phone": "1234567890",
    "theme": "light"
  }
}
```

**Error Response (401):**

```json
{
  "success": false,
  "message": "Not authorized to access this route"
}
```

---

## User Endpoints

### 1. Get User Profile

**GET** `/users/me`

Get current user's profile information.

**Headers:**

```
Authorization: Bearer <token>
```

**Success Response (200):**

```json
{
  "success": true,
  "data": {
    "id": "65a1b2c3d4e5f6g7h8i9j0k1",
    "name": "John Doe",
    "email": "john.doe@example.com",
    "phone": "1234567890",
    "theme": "light"
  }
}
```

---

### 2. Update User Profile

**PATCH** `/users/me`

Update user profile information.

**Headers:**

```
Authorization: Bearer <token>
```

**Request Body (all fields optional):**

```json
{
  "name": "John Updated",
  "email": "john.updated@example.com",
  "phone": "0987654321",
  "theme": "dark"
}
```

**Success Response (200):**

```json
{
  "success": true,
  "message": "Profile updated successfully",
  "data": {
    "id": "65a1b2c3d4e5f6g7h8i9j0k1",
    "name": "John Updated",
    "email": "john.updated@example.com",
    "phone": "0987654321",
    "theme": "dark"
  }
}
```

---

### 3. Update Password

**PATCH** `/users/me/password`

Change user password.

**Headers:**

```
Authorization: Bearer <token>
```

**Request Body:**

```json
{
  "currentPassword": "password123",
  "newPassword": "newpassword456"
}
```

**Success Response (200):**

```json
{
  "success": true,
  "message": "Password updated successfully"
}
```

**Error Response (401):**

```json
{
  "success": false,
  "message": "Current password is incorrect"
}
```

---

## Doctor Endpoints

### 1. Get All Doctors

**GET** `/doctors`

Get list of all doctors with optional filtering.

**Query Parameters:**

- `department` (optional): Filter by department name (case-insensitive)
- `search` (optional): Search by doctor name (case-insensitive)

**Examples:**

```
GET /doctors
GET /doctors?department=Cardiology
GET /doctors?search=smith
GET /doctors?department=Pediatrics&search=john
```

**Success Response (200):**

```json
{
  "success": true,
  "count": 2,
  "data": [
    {
      "_id": "65a1b2c3d4e5f6g7h8i9j0k1",
      "name": "Dr. Sarah Smith",
      "department": "Cardiology",
      "bio": "Experienced cardiologist with 15 years of practice",
      "imageUrl": "https://example.com/doctors/sarah-smith.jpg",
      "ratingAvg": 4.5,
      "ratingCount": 120,
      "createdAt": "2024-01-15T10:30:00.000Z",
      "updatedAt": "2024-01-15T10:30:00.000Z"
    },
    {
      "_id": "65a1b2c3d4e5f6g7h8i9j0k2",
      "name": "Dr. John Williams",
      "department": "Pediatrics",
      "bio": "Specialist in child healthcare",
      "imageUrl": "https://example.com/doctors/john-williams.jpg",
      "ratingAvg": 4.8,
      "ratingCount": 95,
      "createdAt": "2024-01-15T10:30:00.000Z",
      "updatedAt": "2024-01-15T10:30:00.000Z"
    }
  ]
}
```

---

### 2. Get Doctor by ID

**GET** `/doctors/:id`

Get detailed information about a specific doctor.

**Success Response (200):**

```json
{
  "success": true,
  "data": {
    "_id": "65a1b2c3d4e5f6g7h8i9j0k1",
    "name": "Dr. Sarah Smith",
    "department": "Cardiology",
    "bio": "Experienced cardiologist with 15 years of practice",
    "imageUrl": "https://example.com/doctors/sarah-smith.jpg",
    "ratingAvg": 4.5,
    "ratingCount": 120,
    "createdAt": "2024-01-15T10:30:00.000Z",
    "updatedAt": "2024-01-15T10:30:00.000Z"
  }
}
```

**Error Response (404):**

```json
{
  "success": false,
  "message": "Doctor not found"
}
```

---

## Appointment Endpoints

### 1. Create Appointment

**POST** `/appointments`

Book a new appointment with a doctor.

**Headers:**

```
Authorization: Bearer <token>
```

**Request Body:**

```json
{
  "doctorId": "65a1b2c3d4e5f6g7h8i9j0k1",
  "date": "2024-02-15",
  "time": "14:30"
}
```

**Success Response (201):**

```json
{
  "success": true,
  "message": "Appointment booked successfully",
  "data": {
    "_id": "65a1b2c3d4e5f6g7h8i9j0k3",
    "userId": "65a1b2c3d4e5f6g7h8i9j0k1",
    "doctorId": {
      "_id": "65a1b2c3d4e5f6g7h8i9j0k1",
      "name": "Dr. Sarah Smith",
      "department": "Cardiology",
      "imageUrl": "https://example.com/doctors/sarah-smith.jpg"
    },
    "date": "2024-02-15",
    "time": "14:30",
    "status": "booked",
    "createdAt": "2024-01-20T10:30:00.000Z",
    "updatedAt": "2024-01-20T10:30:00.000Z"
  }
}
```

**Error Response (404):**

```json
{
  "success": false,
  "message": "Doctor not found"
}
```

---

### 2. Get My Appointments

**GET** `/appointments/me`

Get all appointments for the authenticated user, separated into upcoming and past.

**Headers:**

```
Authorization: Bearer <token>
```

**Success Response (200):**

```json
{
  "success": true,
  "data": {
    "upcoming": [
      {
        "_id": "65a1b2c3d4e5f6g7h8i9j0k3",
        "userId": "65a1b2c3d4e5f6g7h8i9j0k1",
        "doctorId": {
          "_id": "65a1b2c3d4e5f6g7h8i9j0k1",
          "name": "Dr. Sarah Smith",
          "department": "Cardiology",
          "imageUrl": "https://example.com/doctors/sarah-smith.jpg"
        },
        "date": "2024-02-15",
        "time": "14:30",
        "status": "booked",
        "createdAt": "2024-01-20T10:30:00.000Z",
        "updatedAt": "2024-01-20T10:30:00.000Z"
      }
    ],
    "past": [
      {
        "_id": "65a1b2c3d4e5f6g7h8i9j0k4",
        "userId": "65a1b2c3d4e5f6g7h8i9j0k1",
        "doctorId": {
          "_id": "65a1b2c3d4e5f6g7h8i9j0k2",
          "name": "Dr. John Williams",
          "department": "Pediatrics",
          "imageUrl": "https://example.com/doctors/john-williams.jpg"
        },
        "date": "2024-01-10",
        "time": "10:00",
        "status": "completed",
        "createdAt": "2024-01-05T10:30:00.000Z",
        "updatedAt": "2024-01-10T11:00:00.000Z"
      }
    ]
  }
}
```

---

### 3. Get Next Appointment

**GET** `/appointments/me/next`

Get the user's next upcoming appointment.

**Headers:**

```
Authorization: Bearer <token>
```

**Success Response (200):**

```json
{
  "success": true,
  "data": {
    "_id": "65a1b2c3d4e5f6g7h8i9j0k3",
    "userId": "65a1b2c3d4e5f6g7h8i9j0k1",
    "doctorId": {
      "_id": "65a1b2c3d4e5f6g7h8i9j0k1",
      "name": "Dr. Sarah Smith",
      "department": "Cardiology",
      "imageUrl": "https://example.com/doctors/sarah-smith.jpg"
    },
    "date": "2024-02-15",
    "time": "14:30",
    "status": "booked",
    "createdAt": "2024-01-20T10:30:00.000Z",
    "updatedAt": "2024-01-20T10:30:00.000Z"
  }
}
```

**Error Response (404):**

```json
{
  "success": false,
  "message": "No upcoming appointments found"
}
```

---

### 4. Cancel Appointment

**PATCH** `/appointments/:id/cancel`

Cancel an existing appointment.

**Headers:**

```
Authorization: Bearer <token>
```

**Success Response (200):**

```json
{
  "success": true,
  "message": "Appointment cancelled successfully",
  "data": {
    "_id": "65a1b2c3d4e5f6g7h8i9j0k3",
    "userId": "65a1b2c3d4e5f6g7h8i9j0k1",
    "doctorId": "65a1b2c3d4e5f6g7h8i9j0k1",
    "date": "2024-02-15",
    "time": "14:30",
    "status": "cancelled",
    "createdAt": "2024-01-20T10:30:00.000Z",
    "updatedAt": "2024-01-22T09:15:00.000Z"
  }
}
```

**Error Response (403):**

```json
{
  "success": false,
  "message": "Not authorized to cancel this appointment"
}
```

**Error Response (400):**

```json
{
  "success": false,
  "message": "Appointment is already cancelled"
}
```

---

## Review Endpoints

### 1. Create or Update Review

**POST** `/reviews`

Create a new review or update an existing review for a doctor. If the user has already reviewed the doctor, the existing review will be updated.

**Headers:**

```
Authorization: Bearer <token>
```

**Request Body:**

```json
{
  "doctorId": "65a1b2c3d4e5f6g7h8i9j0k1",
  "rating": 5,
  "comment": "Excellent doctor! Very professional and caring."
}
```

**Success Response (201 for new, 200 for update):**

```json
{
  "success": true,
  "message": "Review created successfully",
  "data": {
    "_id": "65a1b2c3d4e5f6g7h8i9j0k5",
    "userId": {
      "_id": "65a1b2c3d4e5f6g7h8i9j0k1",
      "name": "John Doe"
    },
    "doctorId": "65a1b2c3d4e5f6g7h8i9j0k1",
    "rating": 5,
    "comment": "Excellent doctor! Very professional and caring.",
    "createdAt": "2024-01-20T10:30:00.000Z",
    "updatedAt": "2024-01-20T10:30:00.000Z"
  }
}
```

**Error Response (400):**

```json
{
  "success": false,
  "message": "Rating must be between 1 and 5"
}
```

**Error Response (404):**

```json
{
  "success": false,
  "message": "Doctor not found"
}
```

---

### 2. Get Reviews by Doctor

**GET** `/reviews/:doctorId`

Get all reviews for a specific doctor.

**Success Response (200):**

```json
{
  "success": true,
  "count": 2,
  "data": [
    {
      "_id": "65a1b2c3d4e5f6g7h8i9j0k5",
      "userId": {
        "_id": "65a1b2c3d4e5f6g7h8i9j0k1",
        "name": "John Doe"
      },
      "doctorId": "65a1b2c3d4e5f6g7h8i9j0k1",
      "rating": 5,
      "comment": "Excellent doctor! Very professional and caring.",
      "createdAt": "2024-01-20T10:30:00.000Z",
      "updatedAt": "2024-01-20T10:30:00.000Z"
    },
    {
      "_id": "65a1b2c3d4e5f6g7h8i9j0k6",
      "userId": {
        "_id": "65a1b2c3d4e5f6g7h8i9j0k2",
        "name": "Jane Smith"
      },
      "doctorId": "65a1b2c3d4e5f6g7h8i9j0k1",
      "rating": 4,
      "comment": "Very good experience overall.",
      "createdAt": "2024-01-18T14:20:00.000Z",
      "updatedAt": "2024-01-18T14:20:00.000Z"
    }
  ]
}
```

---

## Error Responses

### Common Error Status Codes

| Status Code | Description                                              |
| ----------- | -------------------------------------------------------- |
| 400         | Bad Request - Invalid input or validation error          |
| 401         | Unauthorized - Missing or invalid authentication token   |
| 403         | Forbidden - User doesn't have permission for this action |
| 404         | Not Found - Requested resource doesn't exist             |
| 500         | Internal Server Error - Server-side error                |

### Error Response Format

All errors follow this format:

```json
{
  "success": false,
  "message": "Error description here"
}
```

### Common Error Examples

**Validation Error:**

```json
{
  "success": false,
  "message": "Please provide email and password"
}
```

**Duplicate Entry:**

```json
{
  "success": false,
  "message": "Email already exists"
}
```

**Resource Not Found:**

```json
{
  "success": false,
  "message": "Resource not found"
}
```

**Unauthorized Access:**

```json
{
  "success": false,
  "message": "Not authorized to access this route"
}
```

---

## Additional Notes

### Date Format

- Dates should be in `YYYY-MM-DD` format (e.g., "2024-02-15")
- Times should be in `HH:mm` format (e.g., "14:30")

### Theme Values

- Acceptable values: `"light"` or `"dark"`

### Appointment Status Values

- `"booked"` - Active upcoming appointment
- `"cancelled"` - Cancelled appointment
- `"completed"` - Past completed appointment

### Rating Values

- Must be an integer between 1 and 5 (inclusive)

### Password Requirements

- Minimum length: 6 characters

### Token Expiration

- JWT tokens expire after 30 days
- Users will need to login again after expiration

---

## Getting Started

1. **Install dependencies:**

   ```bash
   npm install
   ```

2. **Set up environment variables:**
   Create a `.env` file in the backend root directory:

   ```
   PORT=5000
   MONGO_URI=your_mongodb_connection_string
   JWT_SECRET=your_secret_key
   ```

3. **Start the server:**

   ```bash
   npm start
   ```

   or for development with auto-restart:

   ```bash
   npm run dev
   ```

4. **Test the API:**
   The server will run on `http://localhost:5000`

   Health check endpoint:

   ```
   GET http://localhost:5000/api/health
   ```

---

## Contact & Support

For issues or questions about the API, please contact the development team.
