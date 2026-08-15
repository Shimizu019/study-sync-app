# Study Sync

A Flutter mobile study planner app that helps students manage tasks, subjects, class timetables, and study sessions — all synced to a live backend.

## Features

- **Authentication** — Sign up, log in, forgot password flow
- **Home Dashboard** — At-a-glance overview of tasks, schedule, and study progress
- **Task Management** — Create, list, and track tasks with completion status
- **Subjects** — Organize coursework by subject
- **Timetable** — Add and view weekly class schedules
- **Calendar** — Visual calendar view of tasks and classes
- **Study Sessions** — Pomodoro-style timer with active session tracking and session summaries
- **Profile** — View and manage user profile

## Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** PHP / MySQL REST API — see [Study Sync backend](https://github.com/Shimizu019/study-sync-api)
- **State/Networking:** Custom service layer (`ApiService`) handling HTTP calls to the backend

## Project Structure

```
lib/
├── models/              # Data models (task, subject, user, study_session)
├── screens/
│   ├── auth/            # Login, signup, forgot password
│   │   └── study_session/  # Start, active, and session complete screens
│   ├── subjects/        # Add/list subjects
│   ├── tasks/           # Add, list, detail/edit tasks
│   ├── timetable/       # Add class, view timetable
│   ├── calendar/        # Calendar screen
│   ├── home/            # Home dashboard
│   └── profile/         # Profile screen
├── services/            # API, auth, calendar, profile, session, subject,
│                        # task, and timetable service classes
├── widgets/theme/       # App-wide theming
└── main.dart            # App entry point
```
## Getting Started

### Prerequisites
- Flutter SDK installed
- A running instance of the [Study Sync backend](https://github.com/Shimizu019/study-sync-api)

### Setup
1. Clone the repo
