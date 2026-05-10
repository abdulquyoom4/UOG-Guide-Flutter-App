# UOG Guide — Flutter App
### University of Gujrat, Mandi Bahauddin Sub-Campus

---

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry + Bottom Navigation Shell
├── theme/
│   └── app_theme.dart           # Colors, ThemeData
├── models/
│   └── models.dart              # Subject, Department, Announcement models
├── widgets/
│   └── common_widgets.dart      # Reusable: SectionLabel, UOGHeader, QuickCard, etc.
└── screens/
    ├── home_screen.dart         # Home with quick grid + announcements
    ├── gpa_screen.dart          # GPA Calculator (full logic + add/remove subjects)
    ├── departments_screen.dart  # Expandable department cards
    └── campus_screen.dart       # Campus info + important links
```

---

## 🚀 Setup

```bash
# 1. Create Flutter project
flutter create uog_guide
cd uog_guide

# 2. Replace lib/ folder with files from this project

# 3. Install dependencies
flutter pub get

# 4. Run
flutter run
```

---

## ✅ Features Implemented

- [x] Home screen with quick access grid (6 cards)
- [x] Announcements with colored dot indicators
- [x] GPA Calculator — live calculation, grade dropdown
- [x] Add Subject via bottom sheet
- [x] Swipe to delete subjects
- [x] UOG grade scale reference (A=4.0 ... F=0.0)
- [x] Departments screen — 5 departments with expandable cards
- [x] Campus info — facilities + important links
- [x] Bottom navigation bar (persistent)
- [x] Custom UOG navy color theme (#1A3A6B)

---

## 📦 Recommended Next Additions

| Feature | Package |
|---|---|
| Google Fonts (Poppins) | `google_fonts` |
| Local storage (GPA history) | `hive_flutter` |
| GPA trend chart | `fl_chart` |
| Firebase announcements | `firebase_core`, `cloud_firestore` |
| URL launcher (LMS links) | `url_launcher` |
| Campus map | `google_maps_flutter` |
