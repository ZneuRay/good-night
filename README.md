# GoodNight

GoodNight is a social application designed to help you track and analyze your sleep.

## Features

- 👥 **Social Sleep Tracking**: Follow friends and see their sleep patterns
- 😴 **Sleep Records**: Track your sleep sessions with start/end times
- 📊 **Sleep Diary**: Daily sleep summaries and analytics
- 🔗 **Following System**: Connect with other users to share sleep insights
- 📖 **API Documentation**: Interactive API docs with Apipie

## How to use

### Starting the application

The application now automatically handles database setup! Simply run:

```shell
docker compose up --build
```

The application will automatically:
- Wait for PostgreSQL to be ready
- Create the database (if it doesn't exist)
- Run any pending migrations
- Start the Rails server

The service will be available on port 3001 (to avoid conflicts with local development).

### Access the application

- **Main Application**: http://localhost:3001
- **API Documentation**: http://localhost:3001/apipie

## API Documentation

This application includes comprehensive API documentation powered by Apipie. Visit http://localhost:3001/apipie to explore:

- **10 documented API endpoints** across 3 controllers
- Interactive parameter documentation
- Response examples and error codes
- Real request/response samples

### API Endpoints Overview

#### Users API
- User management and social following features
- 6 endpoints for creating, viewing, and managing user relationships

#### Sleep Diary API  
- Daily sleep summaries and following users' reports
- 2 endpoints for accessing sleep diary data

#### Sleep Records API
- Individual sleep session tracking
- 2 endpoints for creating and viewing sleep records


