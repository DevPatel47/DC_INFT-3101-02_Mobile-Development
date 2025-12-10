# Testing Guide - LakeridgeCare Flutter App

## Testing Strategy

This document outlines comprehensive manual testing procedures for the LakeridgeCare Flutter application.

## Prerequisites

- Backend server running on `http://localhost:5000`
- Flutter app connected to backend
- Test data populated in database (doctors, etc.)

---

## 1. Authentication Module Testing

### 1.1 User Registration

**Test Case: Successful Registration**

- Navigate to Register screen
- Enter valid data:
  - Name: `John Doe`
  - Email: `john.doe@test.com`
  - Phone: `1234567890`
  - Password: `password123`
  - Confirm Password: `password123`
- Click "Register"
- **Expected**: User registered, navigated to Home screen, SnackBar shows success

**Test Case: Registration with Existing Email**

- Try registering with already used email
- **Expected**: Error message "User with this email already exists"

**Test Case: Password Mismatch**

- Enter different passwords in Password and Confirm Password
- **Expected**: Validation error "Passwords do not match"

**Test Case: Invalid Email Format**

- Enter email without @ symbol
- **Expected**: Validation error "Please enter a valid email"

**Test Case: Short Password**

- Enter password less than 6 characters
- **Expected**: Validation error "Password must be at least 6 characters"

**Test Case: Empty Fields**

- Leave any field empty and submit
- **Expected**: Validation error for empty field

### 1.2 User Login

**Test Case: Successful Login**

- Navigate to Login screen
- Enter valid credentials
- Click "Login"
- **Expected**: Logged in, navigated to Home screen

**Test Case: Invalid Credentials**

- Enter wrong email or password
- **Expected**: Error message "Invalid credentials"

**Test Case: Empty Fields**

- Leave email or password empty
- **Expected**: Validation error

### 1.3 Auto-Login

**Test Case: Auto-Login on Restart**

- Login successfully
- Close and restart app
- **Expected**: Automatically logged in, navigated to Home

**Test Case: After Logout**

- Logout
- Restart app
- **Expected**: Navigated to Login screen

---

## 2. Home Screen Testing

### 2.1 Initial Load

**Test Case: Home Screen Load**

- Login and navigate to Home
- **Expected**:
  - Welcome message with user's name
  - Quick action buttons visible
  - Next appointment shown (if exists)
  - Upcoming appointments list (if exists)

**Test Case: Pull to Refresh**

- Pull down on Home screen
- **Expected**: Loading indicator, data refreshed

### 2.2 Navigation

**Test Case: Navigate to Doctors**

- Click "Find Doctor" quick action
- **Expected**: Navigate to Doctor List screen

**Test Case: Navigate to Appointments**

- Click "Appointments" quick action
- **Expected**: Navigate to Appointment List screen

**Test Case: Drawer Navigation**

- Open drawer
- Click on each menu item
- **Expected**: Navigate to respective screens

---

## 3. Doctor Module Testing

### 3.1 Doctor List

**Test Case: View All Doctors**

- Navigate to Doctor List
- **Expected**: All doctors displayed with name, department, rating

**Test Case: Search Doctors**

- Enter doctor name in search bar
- **Expected**: Filtered list showing matching doctors

**Test Case: Clear Search**

- Search for doctor, then click X icon
- **Expected**: Search cleared, all doctors shown

**Test Case: Filter by Department**

- Click filter icon
- Select a department
- **Expected**: Only doctors from that department shown

**Test Case: Clear Filter**

- Apply filter, then select "All Departments"
- **Expected**: Filter cleared, all doctors shown

**Test Case: Combined Search and Filter**

- Apply department filter
- Then search by name
- **Expected**: Results match both criteria

**Test Case: Pull to Refresh**

- Pull down on doctor list
- **Expected**: List refreshed

### 3.2 Doctor Details

**Test Case: View Doctor Details**

- Click on a doctor card
- **Expected**:
  - Doctor image, name, department shown
  - Rating and review count displayed
  - Bio displayed (if exists)
  - Book Appointment button visible
  - Reviews list shown

**Test Case: Book from Doctor Details**

- Click "Book Appointment"
- **Expected**: Navigate to Book Appointment screen with doctor info

**Test Case: View Reviews**

- Scroll to reviews section
- **Expected**: All reviews displayed with user name, rating, comment, date

**Test Case: Write Review**

- Click "Write Review"
- Select rating (1-5 stars)
- Enter comment
- Click "Submit"
- **Expected**: Review submitted, list refreshed, success message shown

**Test Case: Update Existing Review**

- If user already reviewed this doctor
- Click "Write Review"
- Change rating/comment
- Submit
- **Expected**: Review updated, success message shown

---

## 4. Appointment Module Testing

### 4.1 Book Appointment

**Test Case: Successful Booking**

- Navigate to Book Appointment (from doctor details)
- Select future date
- Select time
- Click "Book Appointment"
- **Expected**:
  - Appointment created
  - Navigate to Home
  - Success message shown
  - Appointment appears in upcoming list

**Test Case: Date Selection**

- Click on date field
- **Expected**: Date picker opens, only future dates selectable

**Test Case: Time Selection**

- Click on time field
- **Expected**: Time picker opens

**Test Case: Booking Without Date**

- Leave date unselected
- Click book
- **Expected**: Error message "Please select a date"

**Test Case: Booking Without Time**

- Leave time unselected
- Click book
- **Expected**: Error message "Please select a time"

### 4.2 Appointment List

**Test Case: View Upcoming Appointments**

- Navigate to Appointments
- Check "Upcoming" tab
- **Expected**: All booked future appointments shown

**Test Case: View Past Appointments**

- Switch to "Past" tab
- **Expected**: All past/cancelled/completed appointments shown

**Test Case: Appointment Card Display**

- Check appointment cards
- **Expected**:
  - Doctor name, department
  - Date and time formatted correctly
  - Status badge (Booked/Cancelled/Completed)
  - Cancel button (for upcoming only)

**Test Case: Cancel Appointment**

- Click "Cancel Appointment" on upcoming appointment
- Confirm in dialog
- **Expected**:
  - Appointment cancelled
  - Moved to past appointments
  - Success message shown

**Test Case: Cancel Confirmation Dialog**

- Click cancel, then click "No"
- **Expected**: Appointment not cancelled

**Test Case: Empty States**

- If no appointments exist
- **Expected**: Appropriate empty state message shown

### 4.3 Next Appointment Widget

**Test Case: Next Appointment on Home**

- Have at least one upcoming appointment
- Check Home screen
- **Expected**: Next appointment card shown with earliest date/time

---

## 5. Profile Module Testing

### 5.1 View Profile

**Test Case: View Profile Info**

- Navigate to Profile
- **Expected**:
  - Name, email, phone displayed
  - Fields disabled initially
  - Edit button visible

### 5.2 Edit Profile

**Test Case: Successful Update**

- Click Edit icon
- Modify name, email, or phone
- Click Save
- **Expected**:
  - Profile updated
  - Success message
  - Fields disabled again

**Test Case: Cancel Edit**

- Click Edit
- Modify fields
- Click Cancel
- **Expected**: Changes discarded, original values shown

**Test Case: Invalid Email**

- Edit profile with invalid email
- **Expected**: Validation error

**Test Case: Empty Fields**

- Clear required field
- **Expected**: Validation error

### 5.3 Change Password

**Test Case: Successful Password Change**

- Click "Change Password"
- Enter current password
- Enter new password (6+ chars)
- Confirm new password
- Click "Change Password"
- **Expected**: Password updated, success message

**Test Case: Wrong Current Password**

- Enter incorrect current password
- **Expected**: Error "Current password is incorrect"

**Test Case: Password Mismatch**

- New password and confirm don't match
- **Expected**: Validation error

**Test Case: Short Password**

- New password less than 6 characters
- **Expected**: Validation error

---

## 6. Settings Module Testing

### 6.1 Theme Toggle

**Test Case: Switch to Dark Mode**

- Navigate to Settings
- Toggle "Dark Mode" switch ON
- **Expected**:
  - App switches to dark theme
  - Preference saved to backend
  - Theme persists after app restart

**Test Case: Switch to Light Mode**

- Toggle dark mode OFF
- **Expected**: App switches to light theme

**Test Case: Theme Persistence**

- Toggle theme
- Logout and login again
- **Expected**: Theme preference maintained

### 6.2 Logout

**Test Case: Successful Logout**

- Click Logout button
- Confirm in dialog
- **Expected**:
  - Logged out
  - Token cleared
  - Navigate to Login screen

**Test Case: Cancel Logout**

- Click Logout, then Cancel in dialog
- **Expected**: Remain on Settings screen

---

## 7. Review Module Testing

### 7.1 Submit Review

**Test Case: First Review for Doctor**

- Navigate to doctor details who you haven't reviewed
- Click "Write Review"
- Select 5 stars
- Enter comment
- Submit
- **Expected**: Review created, appears in list

**Test Case: Update Existing Review**

- Review same doctor again
- **Expected**: Existing review updated, not duplicated

**Test Case: Review Without Comment**

- Submit review with only rating, no comment
- **Expected**: Review submitted successfully

**Test Case: Invalid Rating**

- Try selecting 0 or 6 stars (if possible)
- **Expected**: Validation prevents invalid rating

---

## 8. Navigation Testing

### 8.1 Navigation Flow

**Test Case: Forward Navigation**

- Login → Home → Doctors → Doctor Details → Book Appointment
- **Expected**: Each screen navigates correctly

**Test Case: Back Navigation**

- From Book Appointment, press back
- **Expected**: Return to Doctor Details

**Test Case: Bottom Drawer**

- Open drawer from Home
- Test all menu items
- **Expected**: All navigate correctly

**Test Case: Deep Linking**

- Navigate to nested screen
- Press back multiple times
- **Expected**: Proper navigation stack maintained

---

## 9. Error Handling Testing

### 9.1 Network Errors

**Test Case: Backend Offline**

- Stop backend server
- Try any API operation
- **Expected**: Error message displayed

**Test Case: Network Timeout**

- Simulate slow network
- **Expected**: Appropriate timeout handling

**Test Case: Invalid Response**

- Backend returns unexpected data
- **Expected**: Graceful error handling

### 9.2 Validation Errors

**Test Case: Backend Validation**

- Submit form that backend will reject
- **Expected**: Backend error message shown to user

---

## 10. UI/UX Testing

### 10.1 Responsive Design

**Test Case: Different Screen Sizes**

- Test on phone, tablet, different orientations
- **Expected**: Layout adapts properly

### 10.2 Loading States

**Test Case: Loading Indicators**

- Perform async operations
- **Expected**: Loading indicators shown appropriately

### 10.3 Pull to Refresh

**Test Case: Refresh Functionality**

- Pull to refresh on supported screens
- **Expected**: Data refreshes, indicator shown

---

## 11. Data Persistence Testing

### 11.1 Token Persistence

**Test Case: Token Storage**

- Login, close app, reopen
- **Expected**: Still logged in

**Test Case: Token Expiry**

- Wait for token to expire (30 days)
- Try API call
- **Expected**: Redirect to login

---

## 12. Edge Cases

### 12.1 Empty States

**Test Case: No Doctors**

- Empty doctor database
- **Expected**: Appropriate empty state shown

**Test Case: No Appointments**

- User with no appointments
- **Expected**: Empty state with call-to-action

**Test Case: No Reviews**

- Doctor with no reviews
- **Expected**: "No reviews yet" message

### 12.2 Boundary Values

**Test Case: Long Text**

- Enter very long names, comments
- **Expected**: Text truncated or scrollable

**Test Case: Special Characters**

- Test with special characters in inputs
- **Expected**: Handled properly

---

## Test Results Template

```
Module: [Module Name]
Test Case: [Test Case Name]
Date: [Date]
Tester: [Name]
Result: ✅ Pass / ❌ Fail
Notes: [Any observations]
```

## Bug Report Template

```
Title: [Brief description]
Severity: Critical / High / Medium / Low
Steps to Reproduce:
1.
2.
3.

Expected Result: [What should happen]
Actual Result: [What actually happened]
Screenshots: [If applicable]
Device: [Device model and OS version]
App Version: 1.0.0
```

---

## Regression Testing Checklist

After any code changes, verify:

- [ ] Authentication flow works
- [ ] Doctor list loads
- [ ] Booking creates appointment
- [ ] Profile updates work
- [ ] Theme toggle works
- [ ] Logout clears session

---

## Performance Testing

### Metrics to Monitor

- App startup time
- Screen transition speed
- API response times
- Image loading performance
- Memory usage

---

## Automated Testing (Future)

Planned automated tests:

- Unit tests for models and services
- Widget tests for UI components
- Integration tests for user flows
- Golden tests for pixel-perfect UI

---

## Test Coverage Goals

- Core Features: 100%
- Edge Cases: 80%
- UI Components: 90%
- Error Scenarios: 100%
