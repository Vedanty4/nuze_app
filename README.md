# 📰 Nuze News App

A modern Flutter news application built using Clean Architecture, Provider State Management, and Dio for networking.

The app fetches news from multiple sources and provides users with breaking news, article search, and detailed news summaries.

## ✨ Features

- 🔥 Top Headlines from NewsAPI
- 🌍 Latest News from GNews
- 🔍 Search News Articles
- 📄 Detailed News Summary Screen
- ⚡ Fast API Integration using Dio
- 🏗️ Clean Architecture
- 🎯 Provider State Management
- 🔐 Environment Variables using flutter_dotenv
- 🚨 Error Handling
- 📱 Responsive UI

## 📸 Screenshots

Add screenshots here:

| Home Screen | News Details | Search |
|------------|-------------|---------|
| Screenshot | Screenshot | Screenshot |

## 🛠️ Tech Stack

### Framework
- Flutter

### State Management
- Provider

### Networking
- Dio

### Routing
- Go Router

### APIs
- NewsAPI
- GNews

### Environment Variables
- flutter_dotenv

## 📂 Project Structure

```text
lib/
├── core/
│   ├── network/
│   ├── router/
│   ├── constants/
│   └── error/
│
├── data/
│   ├── model/
│   ├── repositories/
│   └── services/
│
├── domain/
│   └── usecases/
│
├── presentation/
│   ├── provider/
│   ├── screens/
│   └── widgets/
│
└── main.dart
```

## 🏛️ Architecture

The project follows Clean Architecture principles:

```text
Presentation Layer
       ↓
Domain Layer
       ↓
Data Layer
```

### Presentation
- UI Screens
- Widgets
- Providers

### Domain
- Use Cases
- Business Logic

### Data
- API Services
- Repository Implementations
- Models

## 🚀 Getting Started

### Clone Repository

```bash
git clone https://github.com/yourusername/nuze-news-app.git
```

### Install Dependencies

```bash
flutter pub get
```

### Create Environment File

Create a `.env` file in the root directory:

```env
NewsApi=YOUR_NEWSAPI_KEY
GNewsApi=YOUR_GNEWS_API_KEY
```

### Run Application

```bash
flutter run
```

## 🎯 Learning Outcomes

Through this project I learned:

- Clean Architecture in Flutter
- Provider State Management
- REST API Integration using Dio
- Environment Variable Management
- Error Handling
- Search Functionality
- Navigation using Go Router
- Building Scalable Flutter Applications

## 📌 Future Improvements

- Bookmark Articles
- Dark Mode
- Category Filters
- Offline Caching
- Infinite Scrolling
- News Sharing

## 👨‍💻 Author

Vedant Yadav

Flutter Developer | Android Enthusiast | Aspiring Software Engineer
