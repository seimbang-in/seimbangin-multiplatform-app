<div align="center">
  <img src="./assets/img_mascot-login.png" width="200" alt="Seimbang.in Logo"/>
</div>

<h1 align="center">
  Seimbang.in: AI-Powered Financial Management App
</h1>

<p align="center">
  A mobile financial management application designed to improve the financial literacy and habits of students and Gen Z in Indonesia through easy expense tracking, AI-powered advice, and other innovative features.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-Android-brightgreen.svg" alt="Platform">
  <img src="https://img.shields.io/badge/license-MIT%20%26%20Apache-blue.svg" alt="License">
  <img src="https://img.shields.io/badge/status-active-success.svg" alt="Status">
  <img src="https://img.shields.io/badge/Made%20with-Flutter-blue.svg?logo=flutter" alt="Made with Flutter">
</p>

---

## 📱 About This Project

Indonesia faces a significant challenge in financial literacy. According to the Financial Services Authority (OJK) in 2022, the national financial literacy rate was only 49.68%. 

**Seimbang.in** is developed as a mobile app to address this issue by providing features that help students and Gen Z manage their finances effectively with a focus on:

- Ease of use,
- AI-assisted financial advice,
- Visual analytics.

🎥 Demo video: [Watch here](https://drive.google.com/file/d/1wq2J7nDgCxOz-992rJpdLu2MGPT3u6Tw/view?usp=sharing)

---

## ✨ Key Features

| Feature                | Description                                                                                     |
|------------------------|-------------------------------------------------------------------------------------------------|
| Transaction Tracking   | Track your income and expenses in real-time through an intuitive interface.                    |
| Receipt Scanning (OCR) | Extract data automatically from receipts using image scanning and OCR.                          |
| AI Financial Advisor   | Get personalized insights and recommendations based on your transaction history.               |
| Financial Analytics    | Visualize your income and spending using dynamic, easy-to-read charts.                         |

### 🛠️ Tech Stack
- **State Management:** `flutter_bloc`
- **Routing:** `go_router`
- **Networking:** `http`
- **Local Storage:** `shared_preferences`
- **Charts:** `fl_chart`
- **UI Components:** `carousel_slider`, `persistent_bottom_nav_bar_v2`, `flutter_animate`

---

## 📂 Project Architecture

This project follows a feature-first and layered architecture to maintain clean and scalable code:

```text
lib/
├── blocs/        # Business logic and state management (BLoC)
├── models/       # Data entities and structured models
├── routes/       # Application routing configuration (GoRouter)
├── services/     # External API integrations and network calls
├── shared/       # Shared themes, constants, and utilities
├── ui/           # Presentation layer
│   ├── pages/    # Main screen layouts
│   ├── sections/ # Reusable page sections
│   └── widgets/  # Atomic UI components
└── main.dart     # Application entry point
```

---

## 🚀 Getting Started with Flutter

Follow these steps to run this Flutter project locally:

### 1. 🔧 Requirements

Make sure the following tools are installed on your system:

- Flutter SDK (latest stable release)
- Dart SDK (>= 3.6.0)
- Android Studio / VSCode with Flutter extension
- Android device or emulator
- Git

### 2. 📦 Clone the Repository

```bash
git clone https://github.com/seimbang-in/seimbangin-multiplatform-app.git
cd seimbangin-multiplatform-app
```

### 3. 🛠️ Setup `.env` File

This project uses `flutter_dotenv` to manage environment variables.

1. Copy the example environment file:

```bash
cp .env.example .env
```

2. Open `.env` and **replace values** according to your backend and API configuration:

```
BASE_URL=https://your-backend-url.com
```

> ⚠️ **Note**: Do not commit your `.env` file to version control. It is excluded via `.gitignore`.

### 4. 📥 Install Dependencies

```bash
flutter pub get
```

### 5. ▶️ Run the App

Make sure an emulator or device is connected, then run:

```bash
flutter run
```

---

## 📦 APK Installation (Optional)

To try the latest version without building from source:

1. Download the latest APK from [Releases Page](https://github.com/seimbang-in/seimbangin-multiplatform-app/releases/tag/v.0.2-alpha.2)
2. Enable **Install from Unknown Sources** on your Android device
3. Open the APK file and install

---

## 🚧 Current Limitations

- Only available for **Android** (iOS not yet fully tested)
- Requires internet connection for AI Advisor and Syncing (no offline mode)
- Limited transaction category customization
- Not a digital wallet (no direct fund transfers)

---

## 👥 Meet the BMD Team

This project is proudly developed by the **BMD Team**. 

### 📱 Mobile Team
| [<img src="https://github.com/shandikadav.png" width="100px;" style="border-radius: 50%;"/><br /><sub><b>Shandika David Ardiansyah</b></sub>](https://github.com/shandikadav) | [<img src="https://github.com/mkhsnw.png" width="100px;" style="border-radius: 50%;"/><br /><sub><b>Muhammad Khosyi</b></sub>](https://github.com/mkhsnw) |
| :---: | :---: |

### ⚙️ Backend Team
| [<img src="https://github.com/MasDewaa.png" width="100px;" style="border-radius: 50%;"/><br /><sub><b>Rama Syailana Dewa</b></sub>](https://github.com/MasDewaa) | [<img src="https://github.com/hansfigo.png" width="100px;" style="border-radius: 50%;"/><br /><sub><b>Claudio Hans Figo</b></sub>](https://github.com/hansfigo) |
| :---: | :---: |

### 🎨 Designer Team
| [<img src="https://github.com/fawwazhumam.png" width="100px;" style="border-radius: 50%;"/><br /><sub><b>Muhammad Fawwaz Humam</b></sub>](https://github.com/fawwazhumam) |
| :---: |

---

## 📜 License

This project is dual-licensed under the **MIT** and **Apache 2.0** licenses.

---
