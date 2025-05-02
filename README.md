
# Sentiment Analysis App

![License](https://img.shields.io/badge/license-MIT-blue.svg)

> A containerized sentiment analysis application with FastAPI backend and React frontend.

## ✨ Features

- Analyze text sentiment (positive, negative, or neutral)
- Docker-ready deployment
- CI/CD with GitHub Actions (To be added)

## 🛠️ Tech Stack

- **Backend**: FastAPI, TextBlob
- **Frontend**: React
- **Infrastructure**: Docker, Docker Compose

## 📁 Project Structure

sentimentflow/
│
├── backend/
│   ├── app/
│   │   ├── main.py
│   │   ├── model.py
│   └── requirements.txt
│   └── Dockerfile
│
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── App.js
│   │   ├── index.js
│   └── Dockerfile
│
├── docker-compose.yml
└── README.md

## Running the App
- Clone repository
- git clone https://github.com/yourusername/sentiment-analysis-app.git
- cd sentiment-analysis-app

# Start containers
- docker-compose up

# Access app at:
# - Frontend: http://localhost:3001
# - API: http://localhost:8000
