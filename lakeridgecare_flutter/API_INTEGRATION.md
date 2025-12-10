# API Integration Documentation

This document details how the Flutter frontend integrates with the LakeridgeCare backend API.

## Base Configuration

**File:** `lib/core/api.dart`

```dart
static const String baseUrl = 'http://localhost:5000/api';
```

All API endpoints are prefixed with this base URL.

## Authentication Flow

### 1. Registration

**Endpoint:** `POST /auth/register`

**Request Body:**

```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "phone": "1234567890",
  "password": "password123",
  "theme": "light"
}
```

**Response (Success):**

```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "user": {
      "id": "64a1b2c3d4e5f6g7h8i9j0k1",
      "name": "John Doe",
      "email": "john@example.com",
      "phone": "1234567890",
      "theme": "light"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

**Flutter Implementation:**

- File: `lib/services/auth_service.dart`
- Method: `register()`
- Provider: `AuthProvider.register()`
- Stores JWT token in secure storage

### 2. Login

**Endpoint:** `POST /auth/login`

**Request Body:**

```json
{
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:** Same as registration

**Flutter Implementation:**

- File: `lib/services/auth_service.dart`
- Method: `login()`
- Provider: `AuthProvider.login()`

### 3. Get Current User

**Endpoint:** `GET /auth/me`

**Headers:**

```
Authorization: Bearer <JWT_TOKEN>
```

**Response:**

```json
{
  "success": true,
  "data": {
    "id": "64a1b2c3d4e5f6g7h8i9j0k1",
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "1234567890",
    "theme": "light"
  }
}
```

**Flutter Implementation:**

- File: `lib/services/auth_service.dart`
- Method: `getMe()`
- Provider: `AuthProvider.loadUser()`
- Used for auto-login on app start

---

## Doctor API

### 1. Get All Doctors

**Endpoint:** `GET /doctors`

**Query Parameters (Optional):**

- `department`: Filter by department name
- `search`: Search by doctor name

**Examples:**

- Get all: `GET /doctors`
- Filter: `GET /doctors?department=Cardiology`
- Search: `GET /doctors?search=John`
- Combined: `GET /doctors?department=Cardiology&search=Smith`

**Response:**

```json
{
  "success": true,
  "count": 2,
  "data": [
    {
      "_id": "64a1b2c3d4e5f6g7h8i9j0k1",
      "name": "Dr. John Smith",
      "department": "Cardiology",
      "bio": "Experienced cardiologist...",
      "imageUrl": "https://example.com/image.jpg",
      "ratingAvg": 4.5,
      "ratingCount": 120,
      "createdAt": "2024-01-01T00:00:00.000Z",
      "updatedAt": "2024-01-01T00:00:00.000Z"
    }
  ]
}
```

**Flutter Implementation:**

- File: `lib/services/doctor_service.dart`
- Method: `getDoctors()`
- Provider: `DoctorProvider.fetchDoctors()`
- Screen: `DoctorListScreen`

### 2. Get Doctor by ID

**Endpoint:** `GET /doctors/:id`

**Response:**

```json
{
  "success": true,
  "data": {
    "_id": "64a1b2c3d4e5f6g7h8i9j0k1",
    "name": "Dr. John Smith",
    "department": "Cardiology",
    "bio": "Experienced cardiologist with 15 years...",
    "imageUrl": "https://example.com/image.jpg",
    "ratingAvg": 4.5,
    "ratingCount": 120
  }
}
```

**Flutter Implementation:**

- File: `lib/services/doctor_service.dart`
- Method: `getDoctorById()`
- Provider: `DoctorProvider.getDoctorById()`
- Screen: `DoctorDetailsScreen`

---

## Appointment API

### 1. Create Appointment

**Endpoint:** `POST /appointments`

**Headers:**

```
Authorization: Bearer <JWT_TOKEN>
```

**Request Body:**

```json
{
  "doctorId": "64a1b2c3d4e5f6g7h8i9j0k1",
  "date": "2024-12-15",
  "time": "14:30"
}
```

**Response:**

```json
{
  "success": true,
  "message": "Appointment booked successfully",
  "data": {
    "_id": "64b2c3d4e5f6g7h8i9j0k1l2",
    "userId": "64a1b2c3d4e5f6g7h8i9j0k1",
    "doctorId": {
      "_id": "64a1b2c3d4e5f6g7h8i9j0k1",
      "name": "Dr. John Smith",
      "department": "Cardiology",
      "imageUrl": "https://example.com/image.jpg"
    },
    "date": "2024-12-15",
    "time": "14:30",
    "status": "booked",
    "createdAt": "2024-12-10T00:00:00.000Z"
  }
}
```

**Flutter Implementation:**

- File: `lib/services/appointment_service.dart`
- Method: `createAppointment()`
- Provider: `AppointmentProvider.bookAppointment()`
- Screen: `BookAppointmentScreen`

### 2. Get My Appointments

**Endpoint:** `GET /appointments/me`

**Headers:**

```
Authorization: Bearer <JWT_TOKEN>
```

**Response:**

```json
{
  "success": true,
  "data": {
    "upcoming": [
      {
        "_id": "64b2c3d4e5f6g7h8i9j0k1l2",
        "userId": "64a1b2c3d4e5f6g7h8i9j0k1",
        "doctorId": {
          "_id": "64a1b2c3d4e5f6g7h8i9j0k1",
          "name": "Dr. John Smith",
          "department": "Cardiology",
          "imageUrl": "https://example.com/image.jpg"
        },
        "date": "2024-12-15",
        "time": "14:30",
        "status": "booked"
      }
    ],
    "past": [
      {
        "_id": "64b2c3d4e5f6g7h8i9j0k1l3",
        "userId": "64a1b2c3d4e5f6g7h8i9j0k1",
        "doctorId": {
          "_id": "64a1b2c3d4e5f6g7h8i9j0k2",
          "name": "Dr. Jane Doe",
          "department": "Dermatology",
          "imageUrl": "https://example.com/image2.jpg"
        },
        "date": "2024-12-01",
        "time": "10:00",
        "status": "completed"
      }
    ]
  }
}
```

**Flutter Implementation:**

- File: `lib/services/appointment_service.dart`
- Method: `getMyAppointments()`
- Provider: `AppointmentProvider.fetchAppointments()`
- Screen: `AppointmentListScreen`, `HomeScreen`

### 3. Get Next Appointment

**Endpoint:** `GET /appointments/me/next`

**Headers:**

```
Authorization: Bearer <JWT_TOKEN>
```

**Response:**

```json
{
  "success": true,
  "data": {
    "_id": "64b2c3d4e5f6g7h8i9j0k1l2",
    "userId": "64a1b2c3d4e5f6g7h8i9j0k1",
    "doctorId": {
      "_id": "64a1b2c3d4e5f6g7h8i9j0k1",
      "name": "Dr. John Smith",
      "department": "Cardiology",
      "imageUrl": "https://example.com/image.jpg"
    },
    "date": "2024-12-15",
    "time": "14:30",
    "status": "booked"
  }
}
```

**Flutter Implementation:**

- File: `lib/services/appointment_service.dart`
- Method: `getNextAppointment()`
- Provider: `AppointmentProvider.fetchAppointments()`
- Screen: `HomeScreen` (displays next appointment card)

### 4. Cancel Appointment

**Endpoint:** `PATCH /appointments/:id/cancel`

**Headers:**

```
Authorization: Bearer <JWT_TOKEN>
```

**Response:**

```json
{
  "success": true,
  "message": "Appointment cancelled successfully",
  "data": {
    "_id": "64b2c3d4e5f6g7h8i9j0k1l2",
    "status": "cancelled"
  }
}
```

**Flutter Implementation:**

- File: `lib/services/appointment_service.dart`
- Method: `cancelAppointment()`
- Provider: `AppointmentProvider.cancelAppointment()`
- Screen: `AppointmentListScreen`, `AppointmentCard` widget

---

## Review API

### 1. Create or Update Review

**Endpoint:** `POST /reviews`

**Headers:**

```
Authorization: Bearer <JWT_TOKEN>
```

**Request Body:**

```json
{
  "doctorId": "64a1b2c3d4e5f6g7h8i9j0k1",
  "rating": 5,
  "comment": "Excellent doctor, very professional!"
}
```

**Response (Create):**

```json
{
  "success": true,
  "message": "Review created successfully",
  "data": {
    "_id": "64c3d4e5f6g7h8i9j0k1l2m3",
    "userId": {
      "_id": "64a1b2c3d4e5f6g7h8i9j0k1",
      "name": "John Doe"
    },
    "doctorId": "64a1b2c3d4e5f6g7h8i9j0k1",
    "rating": 5,
    "comment": "Excellent doctor, very professional!",
    "createdAt": "2024-12-10T00:00:00.000Z"
  }
}
```

**Response (Update):**

```json
{
  "success": true,
  "message": "Review updated successfully",
  "data": { ... }
}
```

**Notes:**

- If user already has a review for this doctor, it will be updated
- Otherwise, a new review is created
- Doctor's rating is automatically recalculated

**Flutter Implementation:**

- File: `lib/services/review_service.dart`
- Method: `createOrUpdateReview()`
- Provider: `ReviewProvider.submitReview()`
- Screen: `DoctorDetailsScreen` (review dialog)

### 2. Get Reviews by Doctor

**Endpoint:** `GET /reviews/:doctorId`

**Response:**

```json
{
  "success": true,
  "count": 3,
  "data": [
    {
      "_id": "64c3d4e5f6g7h8i9j0k1l2m3",
      "userId": {
        "_id": "64a1b2c3d4e5f6g7h8i9j0k1",
        "name": "John Doe"
      },
      "doctorId": "64a1b2c3d4e5f6g7h8i9j0k1",
      "rating": 5,
      "comment": "Excellent doctor, very professional!",
      "createdAt": "2024-12-10T00:00:00.000Z"
    }
  ]
}
```

**Flutter Implementation:**

- File: `lib/services/review_service.dart`
- Method: `getReviewsByDoctor()`
- Provider: `ReviewProvider.fetchReviews()`
- Screen: `DoctorDetailsScreen`

---

## User Profile API

### 1. Get User Profile

**Endpoint:** `GET /users/me`

**Headers:**

```
Authorization: Bearer <JWT_TOKEN>
```

**Response:**

```json
{
  "success": true,
  "data": {
    "id": "64a1b2c3d4e5f6g7h8i9j0k1",
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "1234567890",
    "theme": "light"
  }
}
```

**Flutter Implementation:**

- File: `lib/services/user_service.dart`
- Method: `getProfile()`
- Screen: `ProfileScreen`

### 2. Update User Profile

**Endpoint:** `PATCH /users/me`

**Headers:**

```
Authorization: Bearer <JWT_TOKEN>
```

**Request Body (all fields optional):**

```json
{
  "name": "John Smith",
  "email": "johnsmith@example.com",
  "phone": "9876543210",
  "theme": "dark"
}
```

**Response:**

```json
{
  "success": true,
  "message": "Profile updated successfully",
  "data": {
    "id": "64a1b2c3d4e5f6g7h8i9j0k1",
    "name": "John Smith",
    "email": "johnsmith@example.com",
    "phone": "9876543210",
    "theme": "dark"
  }
}
```

**Flutter Implementation:**

- File: `lib/services/user_service.dart`
- Method: `updateProfile()`
- Provider: `SettingsProvider.updateProfile()`
- Screen: `ProfileScreen`

### 3. Update Password

**Endpoint:** `PATCH /users/me/password`

**Headers:**

```
Authorization: Bearer <JWT_TOKEN>
```

**Request Body:**

```json
{
  "currentPassword": "oldpassword123",
  "newPassword": "newpassword123"
}
```

**Response:**

```json
{
  "success": true,
  "message": "Password updated successfully"
}
```

**Flutter Implementation:**

- File: `lib/services/user_service.dart`
- Method: `updatePassword()`
- Provider: `SettingsProvider.updatePassword()`
- Screen: `ProfileScreen` (password change dialog)

---

## Error Handling

### Standard Error Response Format

```json
{
  "success": false,
  "message": "Error message here"
}
```

### HTTP Status Codes

- **200**: Success
- **201**: Created
- **400**: Bad Request (validation errors)
- **401**: Unauthorized (invalid/missing token)
- **403**: Forbidden
- **404**: Not Found
- **500**: Server Error

### Flutter Error Handling

All errors are caught and handled in:

1. **API Service** (`lib/core/api.dart`): Network-level errors
2. **Service Layer** (`lib/services/*.dart`): Service-specific errors
3. **Providers** (`lib/providers/*.dart`): State management errors
4. **UI Layer** (Screens): Display errors to users

**Example:**

```dart
try {
  await provider.bookAppointment(...);
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(e.toString()),
      backgroundColor: Colors.red,
    ),
  );
}
```

---

## JWT Token Management

### Token Storage

- Stored using `flutter_secure_storage` package
- Key: `auth_token`
- Automatically included in authenticated requests

### Token Lifecycle

1. **Login/Register**: Token received and stored
2. **Auto-Login**: Token retrieved on app start
3. **API Calls**: Token attached to `Authorization` header
4. **Logout**: Token deleted from storage

### Implementation

**Store Token:**

```dart
await _storage.write(key: 'auth_token', value: token);
```

**Retrieve Token:**

```dart
final token = await _storage.read(key: 'auth_token');
```

**Delete Token:**

```dart
await _storage.delete(key: 'auth_token');
```

**Attach to Request:**

```dart
headers['Authorization'] = 'Bearer $token';
```

---

## API Request Flow

### Example: Booking an Appointment

1. **User Action**: Click "Book Appointment" button
2. **UI Layer**: Call `appointmentProvider.bookAppointment()`
3. **Provider**: Set loading state, call service
4. **Service**: `appointmentService.createAppointment()`
5. **API Layer**:
   - Build request URL
   - Attach JWT token
   - Make HTTP POST request
6. **Response Handling**:
   - Success: Parse response, update state, show success message
   - Error: Catch exception, set error state, show error message
7. **UI Update**: Provider notifies listeners, UI rebuilds

---

## Network Configuration

### Android

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<application
    android:usesCleartextTraffic="true"
    ...>
```

### iOS

No additional configuration needed for localhost.

### Production

Update `baseUrl` in `lib/core/api.dart` to production URL:

```dart
static const String baseUrl = 'https://api.lakeridgecare.com/api';
```

---

## Testing API Integration

### Using Postman/Thunder Client

1. Import backend API collection
2. Set base URL: `http://localhost:5000/api`
3. Test each endpoint
4. Verify request/response format

### Testing in Flutter

1. **Check Network Tab**: Monitor API calls in Flutter DevTools
2. **Add Logging**: Print API requests/responses during development
3. **Test Error Cases**: Simulate network failures, invalid data
4. **Test Auth Flow**: Verify token storage and retrieval

---

## Best Practices

1. **Error Handling**: Always wrap API calls in try-catch
2. **Loading States**: Show loading indicators during API calls
3. **Token Refresh**: Implement token refresh if tokens expire
4. **Retry Logic**: Add retry for failed network requests
5. **Caching**: Cache frequently accessed data (e.g., doctor list)
6. **Optimistic Updates**: Update UI before API call completes (where appropriate)
7. **Request Cancellation**: Cancel pending requests when leaving screen

---

## Debugging Tips

### Print API Requests

```dart
print('API Request: $endpoint');
print('Request Body: ${jsonEncode(body)}');
```

### Print API Responses

```dart
print('API Response: ${response.body}');
```

### Check Token

```dart
final token = await _api.getToken();
print('Current Token: $token');
```

### Monitor Network

Use Flutter DevTools Network tab to inspect all HTTP traffic.

---

## Future Enhancements

- [ ] Implement request retry with exponential backoff
- [ ] Add request/response interceptors
- [ ] Implement GraphQL for complex queries
- [ ] Add pagination for large lists
- [ ] Implement WebSocket for real-time updates
- [ ] Add offline mode with local database
- [ ] Implement request caching with cache invalidation
