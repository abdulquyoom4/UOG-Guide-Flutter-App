# UOG Guide — Student Companion App
### University of Gujrat, Mandi Bahauddin Sub-Campus

A feature-rich Flutter application designed to provide UOG students with easy access to academic tools, campus information, and personal productivity features.

---

## 🚀 Key Features

- **🔐 Smart Student Authentication**:
  - Roll Number-based login (e.g., `23011519-000`).
  - Automatic appending of `@uog.edu.pk` domain.
  - Mandatory university email verification.
  - Guest mode support (browse home/campus without logging in).

- **📝 Academic Notes (CRUD)**:
  - Personal notes management synced across devices.
  - Powered by **Firebase Firestore** with real-time updates.
  - Secure data: users can only access their own notes.

- **📊 GPA Calculator**:
  - Real-time GPA calculation logic tuned to the **University of Gujrat** grading policy.
  - Interactive UI for adding, removing, and updating subject grades.

- **🌐 Integrated University Portals**:
  - Direct access to **LMS** and **CMS**.
  - Integrated **Academic Calendar** viewer.
  - Smooth in-app browser experience with progress indicators.

- **🏢 Campus & Programs**:
  - Detailed department insights (CS, BBA, English, etc.).
  - Campus facilities info (Library, Labs, Transport).

- **🌓 Professional UI/UX**:
  - Clean Material Design 3 interface.
  - Dynamic **Light & Dark Mode** with persistent preference.
  - Intuitive bottom navigation and profile management.

---

## 📁 Project Structure

```
lib/
├── main.dart                # App Shell & Bottom Navigation
├── firebase_options.dart    # Multi-platform Firebase configuration
├── theme/
│   └── app_theme.dart       # Colors & Light/Dark Theme definitions
├── models/
│   ├── note_model.dart      # Firestore Note data model
│   └── models.dart          # Subject & Department models
├── services/
│   ├── auth_service.dart    # Firebase Auth (Roll No logic & Verification)
│   └── notes_service.dart   # Firestore CRUD service
├── widgets/
│   └── common_widgets.dart  # Reusable UI (UOGHeader, QuickCard, etc.)
└── screens/
    ├── home_screen.dart     # Dashboard & Quick access
    ├── login_screen.dart    # Roll No-based login/signup UI
    ├── notes_screen.dart    # Student notes management UI
    ├── gpa_screen.dart      # Interactive GPA calculator
    ├── profile_screen.dart  # Account info & Developer details
    ├── campus_screen.dart   # Campus resources info
    ├── departments_screen.dart # Academic programs info
    └── webview_screen.dart  # In-app browser engine
```

---

## 🛠️ Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase Authentication, Cloud Firestore
- **Local Storage**: Shared Preferences (Theme persistence)
- **Networking**: `url_launcher`, `webview_flutter`

---

## 👨‍💻 Developed By

**Abdul Quyoom**
- 🌐 [Portfolio](https://abdulquyoom.tech/)
- 🔗 [LinkedIn](https://www.linkedin.com/in/abdulquyoom4/)
- 💻 [GitHub](https://github.com/abdulquyoom4)
