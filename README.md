#🚘 NCU RideShare App
An AI-powered, eco-friendly ride-sharing app tailored for NCU students. It enables users to book or offer rides with real-time matching, verified profiles, and a safety-first experience.

🧩 Project Overview
AI-driven ride-sharing platform built for NCU students

Developed using Flutter (frontend) and Node.js + WebSocket (backend)

Focused on safety, eco-friendliness, and real-time user matching

Supports features like OTP login, same-gender carpooling, and recurring rides

🖥️ Frontend – Flutter
Built with Flutter for Android platform

Clean and modern UI/UX inspired by Uber

Location access, route mapping, and real-time ride updates

Themes aligned with eco-friendly and safety-first design principles

⚙️ Backend – Node.js
Handles OTP-based login via WebSocket

Stores user profile data securely

Designed for real-time communication and future AI/ML enhancements

Supports ride request, match, and confirmation features

📱 App Screens & Flow
---
Splash & Onboarding – Intro to app values and usage

Login & OTP Verification – Secure sign-in using phone number

Profile Setup – Collects name, gender, promo code

Home Page – Choose to "Book a Ride" or "Offer a Ride"

Ride Input Page – Set pickup/drop and preferences

Match Results – Shows available ride matches

Invite Confirmation – Accept or reject ride requests

Ongoing Ride Page – Real-time ride tracking

End Ride Page – Trip completion and eco impact

Recurring Rides – Set up regular carpool schedules

Fare Setting Page – Specify ride fare

Profile & Safety Page – User info and safety features

Refer Page – Invite and earn credits

Eco Stats Page – See carbon savings

Help & ChatGPT Page – FAQs and AI support

🔁 App Flow Summary
---
User opens the app → Sees onboarding

Enters mobile number → Verifies via OTP

Completes profile setup

Chooses to Book or Offer Ride

Enters ride details → Matches displayed

Confirms ride → Shown in Ongoing Ride

Ends ride → Sees summary and eco stats

🚀 How to Run This Project Locally
---
📦 Prerequisites
Flutter SDK

Android Studio

Git

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/zubairehman/flutter-boilerplate-project.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

This project uses `inject` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```
🧠 Tech Stack
---
Frontend: Flutter (Dart)

Backend: Node.js + WebSocket

Database: MongoDB (planned)

AI/ML: For ride auto-matching (in progress)

Maps: Google Maps API (integration in progress)

👨‍💻 Developed By
---
* 22CSU125 ODITI AGARWAL
* 22CSU105 LATIKA MUKHI
* 22CSU106 LEANA 
