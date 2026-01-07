🎓 Phnom Penh University Finder (Offline App)
=============================================

A **Flutter mobile application** that helps students — especially those living in **rural areas of Cambodia** — find **universities in Phnom Penh** based on their favorite **major**.  
The app works **100% offline**, using only **local JSON files** without any backend or API.

---

👥 Team Members
---------------

- Man Arafat  
- Chey Rotana

---

🛠️ Technologies Used
---------------------

- **Flutter**  
- **Dart**  
- **Local JSON**  
- **Material Design 3**

---

📁 Project Structure
-------------------

```
uni_finder/
│
├── android/           # Android platform-specific files
├── assets/            # App assets (images, fonts, JSON data)
│   ├── career/        # Career images
│   ├── data/          # Local JSON files (universities, majors, careers, etc.)
│   ├── fonts/         # Custom fonts
│   ├── logo/          # App logos
│   ├── majors/        # Major-related images
│   ├── panels/        # UI panel images
│   └── university/    # University images
├── build/             # Build outputs (auto-generated)
├── ios/               # iOS platform-specific files
├── lib/               # Main Dart source code
│   ├── main.dart      # App entry point
│   ├── Domain/        # Domain logic (data, models)
│   ├── routers/       # App routing (navigation)
│   ├── service/       # Data and business logic services
│   └── ui/            # UI components and screens
├── linux/             # Linux platform-specific files
├── macos/             # macOS platform-specific files
├── test/              # Unit and widget tests
│   ├── repository/
│   ├── service/
│   └── test_utils/
├── web/               # Web platform files (index.html, icons, etc.)
├── windows/           # Windows platform-specific files
├── analysis_options.yaml  # Dart analysis configuration
├── pubspec.yaml           # Project dependencies and metadata
├── uni_finder.iml         # IDE project file
└── README.md              # Project documentation
```

**What This Structure Covers:**
- All source code is in `lib/`, organized by domain, services, UI, and routing for maintainability.
- All offline data (universities, majors, careers, etc.) is in `assets/data/` as JSON files, so the app works 100% offline.
- Platform folders (`android/`, `ios/`, `linux/`, `macos/`, `web/`, `windows/`) allow building for any device.
- `test/` contains unit and widget tests for code reliability.
- `pubspec.yaml` manages dependencies, assets, and fonts.
- `analysis_options.yaml` enforces code quality and style.

This structure ensures the app is modular, maintainable, and fully functional offline for Cambodian students seeking university and major information in Phnom Penh.

