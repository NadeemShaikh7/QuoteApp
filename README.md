# QuoteVault

QuoteVault is a full-featured quote discovery and personalization mobile app built using **Flutter** and **Supabase**.  
The app allows users to browse, save, organize, personalize, and share inspirational quotes with cloud sync and daily engagement features.

---

## 📱 Features Overview

### Authentication & User Accounts
- Email/password sign-up and login
- Password reset flow
- Persistent user sessions
- User profile support (name, avatar via Supabase metadata)

### Quote Browsing & Discovery
- Paginated home feed
- Browse by category (Motivation, Love, Success, Wisdom, Humor)
- Search by keyword and author
- Pull-to-refresh
- Loading and empty states handled gracefully

### Favorites & Collections
- Save quotes to favorites
- Create custom collections
- Add/remove quotes from collections
- Cloud-synced across devices using Supabase

### Daily Quote & Notifications
- Quote of the Day logic
- Daily local notifications
- User-selectable notification time
- iOS & Android native notification support

### Sharing & Export
- Share quotes as text via system share sheet
- Generate shareable quote cards
- Save and share quote images
- Multiple card styles/templates

### Personalization & Settings
- Dark / Light mode toggle
- Multiple accent color themes
- Adjustable quote font size
- Settings persisted locally and synced to user profile

---

## 🧱 Architecture & Code Quality

The project follows a **clean, layered architecture**:


- **State Management:** GetX
- **Backend:** Supabase (Auth + Database)
- **Design Principles:** Separation of concerns, reusable components, reactive UI
- **Error Handling:** Try/catch in repositories, graceful UI fallbacks
- **No hardcoded strings:** Centralized constants used throughout the app

---

## ⚙️ Setup Instructions

### Prerequisites
- Flutter SDK (stable channel)
- Android Studio / Xcode
- Supabase account

---

## SupaBase Config
Auth

- Enable Email/Password authentication

Database Tables

- quotes

- user_favorites

- collections

- collection_quotes

## 🤖 AI Coding Approach & Workflow

This project was developed using an AI-assisted workflow to improve speed, correctness, and code quality.
How AI Was Used

- Generate initial architecture and boilerplate

- Accelerate repetitive UI and state management code

- Debug Flutter, GetX, Supabase, and platform-specific issues

- Validate best practices for notifications, image generation, and persistence

- Refactor code for readability and maintainability

- Human Oversight

- All AI-generated code was:

- Reviewed manually

- Adjusted for project-specific requirements

- Tested and debugged during implementation

- AI was used as a productivity accelerator, not a replacement for engineering judgment.

## 🧠 AI Tools Used

- ChatGPT – primary architecture design, Flutter & Supabase guidance, debugging


## ⚠️ Known Limitations / Incomplete Features

- Home screen widget (WidgetKit / Android App Widget) was intentionally skipped

- Offline quote caching is limited to previously loaded content

- No internationalization (i18n) — strings centralized but not localized

- Admin tooling for quote management not included

- These limitations were consciously chosen to prioritize core functionality, architecture quality, and reliability within the assignment timeframe.