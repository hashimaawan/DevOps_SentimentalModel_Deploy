from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from textblob import TextBlob
import os

app = FastAPI()

# Get allowed origins from environment or use default
origins = os.environ.get("CORS_ORIGINS", "http://localhost:3001").split(",")

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return {"message": "Sentiment Analysis API is running"}

@app.post("/analyze/")
async def analyze(request: Request):
    data = await request.json()
    text = data.get("text")
    
    if not text:
        return {"error": "No text provided"}
    
    blob = TextBlob(text)
    polarity = blob.sentiment.polarity
    
    label = "positive" if polarity > 0 else "negative" if polarity < 0 else "neutral"
    
    return {
        "label": label,
        "score": round(polarity, 2),
        "text": text[:50] + "..." if len(text) > 50 else text
    }