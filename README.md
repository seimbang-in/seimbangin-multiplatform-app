# 📱 Seimbang.in — AI-Powered Financial Management App

<div align="center">
  <img src="./assets/img_mascot-login.png" width="160" alt="Seimbang.in Logo"/>
</div>

<h3 align="center">
  Build better financial habits — one decision at a time.
</h3>

<p align="center">
  A mobile financial management app designed for students and Gen Z in Indonesia, combining <b>expense tracking</b>, <b>AI-driven insights</b>, and <b>visual analytics</b> to improve financial literacy and daily money habits.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-Android-brightgreen.svg" />
  <img src="https://img.shields.io/badge/status-active-success.svg" />
  <img src="https://img.shields.io/badge/license-MIT%20%26%20Apache-blue.svg" />
  <img src="https://img.shields.io/badge/Made%20with-Flutter-blue.svg?logo=flutter" />
</p>

---

## 🎯 Why Seimbang.in?

Financial literacy in Indonesia is still a real challenge.

- 📊 Only **49.68%** of Indonesians are financially literate (OJK, 2022)  
- 💸 **56.6% of Gen Z** rarely or never save (Katadata, 2021)

Most tools are either:
- too complex, or  
- not relevant to daily habits of young users  

👉 **Seimbang.in exists to fix that.**

We focus on:
- simplicity  
- actionable insights  
- habit-building, not just tracking  

---

## ✨ Core Features

| Feature | Description |
|--------|------------|
| 💸 **Transaction Tracking** | Log income & expenses with a clean, intuitive interface. |
| 📷 **Receipt Scanning (OCR)** | Automatically extract transaction data from receipts. |
| 🤖 **AI Financial Advisor** | Get personalized insights & recommendations based on your spending habits. |
| 📊 **Financial Analytics** | Understand your money through simple, visual charts (daily / weekly / monthly). |
| 💬 **AI Chat Advisor** | Ask financial questions and get contextual advice instantly. |

---

## 🎥 Demo

👉 [Watch Demo Video](https://drive.google.com/file/d/1wq2J7nDgCxOz-992rJpdLu2MGPT3u6Tw/view?usp=sharing)

---

## 🧱 Tech Stack

### 📱 Mobile
- Flutter (Dart)
- `flutter_bloc`
- `go_router`
- `fl_chart`

### ⚙️ Backend
- Node.js + Express  
- MySQL + Redis  
- Drizzle ORM  
- PassportJS  

### 🤖 AI
- OpenAI API  

### ☁️ Infrastructure
- Google Cloud Platform  

---

## 🏗️ Project Architecture

```text
lib/
├── blocs/        
├── models/       
├── routes/       
├── services/     
├── shared/       
├── ui/           
│   ├── pages/    
│   ├── sections/ 
│   └── widgets/  
└── main.dart
```

---

## 🚀 Getting Started

### 1. Requirements

- Flutter SDK (latest stable)
- Dart >= 3.6.0  
- Android Studio / VSCode  
- Emulator or physical device  
- Git  

---

### 2. Clone Repo

```bash
git clone https://github.com/seimbang-in/seimbangin-multiplatform-app.git
cd seimbangin-multiplatform-app
```

---

### 3. Setup Environment

```bash
cp .env.example .env
```

Edit `.env`:

```
BASE_URL=https://your-backend-url.com
```

⚠️ Do not commit `.env`

---

### 4. Install Dependencies

```bash
flutter pub get
```

---

### 5. Run App

```bash
flutter run
```

---

## 📦 APK (Quick Try)

👉 https://github.com/seimbang-in/seimbangin-multiplatform-app/releases/tag/v.0.2-alpha.2

Steps:
1. Enable **Install from Unknown Sources**
2. Install APK
3. Done 🚀

---

## ⚠️ Current Limitations

- Android only  
- Requires internet connection  
- No custom transaction categories yet  
- Not an e-wallet  
- English only  

---

## 🏆 Awards & Recognition

- 🥇 1st Place — GENETIC 2025  
- 🥉 3rd Place — ITFest Vol. 5  
- 🥉 3rd Runner Up — Unity #13  
- 🏆 Top 50 Capstone — Bangkit Academy 2024  

---

## 👥 Team

- Rama Syailana Dewa — Project Lead  
- Muhammad Khosyi Nawwari — Flutter Dev  
- Shandika David Ardiansyah — Flutter Dev  
- Claudio Hans Figo — Backend Dev  
- Muhammad Fawwaz Humam — Designer  

---

## 📜 License

MIT & Apache 2.0  

---

## 💡 Closing

Seimbang.in is not just about tracking money —  
it’s about building better financial habits over time.