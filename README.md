# LibraBookManagement

A comprehensive book management system built with Laravel backend and Vue.js frontends.

## Project Overview

LibraBookManagement is a full-stack web application designed for libraries to manage books, users, and borrowing processes. The system consists of:

- **Laravel Backend API**: Handles data management, authentication, and business logic
- **Admin Dashboard (Vue)**: For librarians to manage books, users, and monitor the system
- **User Portal (Vue)**: For library members to browse books, manage borrowings, and account details

## Technology Stack

### Backend
- Laravel 11+
- PHP 8.2+
- MySQL Database
- JWT Authentication
- Docker for containerization

### Admin Frontend
- Vue.js 3
- Vite
- Tailwind CSS
- Docker for containerization

### User Frontend
- Vue.js 3
- Vite
- Tailwind CSS
- Docker for containerization

## Project Structure

```
LibraBookManagement/
├── laravel/               # Backend API
├── vue/                   # Admin dashboard
└── vue-user/              # User portal
```

## Setup and Installation

### Prerequisites
- Docker and Docker Compose
- Node.js (v16+) and npm/yarn
- Git

### Backend Setup (Laravel)

1. Navigate to the Laravel directory:
   ```bash
   cd laravel
   ```

2. Start the Docker containers:
   ```bash
   docker-compose up -d
   ```

3. Install dependencies:
   ```bash
   docker-compose exec php composer install
   ```

4. Create environment file:
   ```bash
   cp src/.env.example src/.env
   ```

5. Generate application key:
   ```bash
   docker-compose exec php php artisan key:generate
   ```

6. Run database migrations and seeders:
   ```bash
   docker-compose exec php php artisan migrate --seed
   ```

7. The backend API will be available at: http://localhost:8000

### Admin Frontend Setup (Vue)

1. Navigate to the Vue directory:
   ```bash
   cd vue
   ```

2. Start the Docker containers:
   ```bash
   docker-compose up -d
   ```

3. Install dependencies:
   ```bash
   cd LibraManager
   npm install
   ```

4. Create environment file:
   ```bash
   cp .env.example .env
   ```

5. The admin dashboard will be available at: http://localhost:8080

### User Portal Setup (Vue)

1. Navigate to the Vue User directory:
   ```bash
   cd vue-user
   ```

2. Start the Docker containers:
   ```bash
   docker-compose up -d
   ```

3. Install dependencies:
   ```bash
   cd LibraBook
   npm install
   ```

4. Create environment file:
   ```bash
   cp .env.example .env
   ```

5. The user portal will be available at: http://localhost:8081

## Development

### Running Backend Tests
```bash
cd laravel
docker-compose exec php php artisan test
```

### Running Frontend Tests
```bash
cd vue/LibraManager
npm run test
```

### Code Standards
- Backend: PSR-12 coding standard (using Laravel Pint)
- Frontend: ESLint with Vue.js recommended configuration

## Features

- **User Management**: Registration, login, profile management
- **Book Management**: Add, edit, categorize, and track book inventory
- **Borrowing System**: Reserve, borrow, return, and track book status
- **Search & Filters**: Advanced search functionality for finding books
- **Notifications**: Email notifications for due dates, available books
- **Reports**: Generate usage reports and statistics

## Deployment

Each component (backend, admin frontend, user frontend) is containerized using Docker for easy deployment. See deployment documentation in each component's directory for specific instructions.

## License

[MIT License](LICENSE)

## Contributors

- Your Name - Initial development and maintenance

## Acknowledgments

- Laravel Team
- Vue.js Team
- All open-source libraries used in this project
