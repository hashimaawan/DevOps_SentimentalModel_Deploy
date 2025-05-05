import React, { useState } from "react";
import axios from "axios";
import './App.css';

function App() {
  const [text, setText] = useState("");
  const [result, setResult] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [history, setHistory] = useState([]);

  const analyzeSentiment = async () => {
    if (!text.trim()) return;
    
    try {
      setLoading(true);
      setError(null);
      
      const response = await axios.post("http://localhost:8000/analyze/", { text });
      
      setResult(response.data);
      
      // Add to history
      setHistory(prev => [
        { 
          id: Date.now(), 
          text, 
          result: response.data 
        }, 
        ...prev
      ].slice(0, 5)); // Keep only the 5 most recent analyses
      
      // Clear the input
      setText("");
    } catch (err) {
      console.error("Error analyzing sentiment:", err);
      setError("Failed to analyze sentiment. Please check the server connection.");
    } finally {
      setLoading(false);
    }
  };

  const handleKeyDown = (e) => {
    if (e.key === 'Enter' && e.ctrlKey) {
      analyzeSentiment();
    }
  };

  const getSentimentColor = (label) => {
    switch(label) {
      case 'positive': return '#28a745';
      case 'negative': return '#dc3545';
      case 'neutral': return '#6c757d';
      default: return '#6c757d';
    }
  };

  const getSentimentEmoji = (label) => {
    switch(label) {
      case 'positive': return '😃';
      case 'negative': return '😞';
      case 'neutral': return '😐';
      default: return '❓';
    }
  };

  return (
    <div className="app-container">
      <header className="app-header">
        <h1>Sentiment Analyzer</h1>
        <p className="subtitle">Analyze the emotional tone of your text</p>
      </header>
      
      <main className="app-main">
        <div className="input-section">
          <textarea 
            className="text-input"
            rows="5"
            value={text} 
            onChange={(e) => setText(e.target.value)} 
            onKeyDown={handleKeyDown}
            placeholder="Enter text to analyze sentiment... (Ctrl+Enter to submit)"
          />
          
          <button 
            className={`analyze-button ${loading ? 'loading' : ''} ${!text.trim() ? 'disabled' : ''}`}
            onClick={analyzeSentiment}
            disabled={loading || !text.trim()}
          >
            {loading ? 'Analyzing...' : 'Analyze Sentiment'}
          </button>

          {error && (
            <div className="error-message">
              {error}
            </div>
          )}
        </div>
        
        {result && (
          <div className="result-section">
            <div 
              className="result-card" 
              style={{
                borderColor: getSentimentColor(result.label),
                backgroundColor: `${getSentimentColor(result.label)}10`
              }}
            >
              <div className="sentiment-header">
                <span className="sentiment-emoji">{getSentimentEmoji(result.label)}</span>
                <h2 className="sentiment-label" style={{ color: getSentimentColor(result.label) }}>
                  {result.label.charAt(0).toUpperCase() + result.label.slice(1)}
                </h2>
              </div>
              
              <div className="confidence-meter">
                <div className="confidence-label">Confidence: {(Math.abs(result.score) * 100).toFixed(1)}%</div>
                <div className="meter-container">
                  <div 
                    className="meter-fill" 
                    style={{
                      width: `${Math.abs(result.score) * 100}%`,
                      backgroundColor: getSentimentColor(result.label)
                    }}
                  ></div>
                </div>
              </div>
              
              <div className="analyzed-text">
                <h3>Analyzed Text:</h3>
                <p>{result.text}</p>
              </div>
            </div>
          </div>
        )}
        
        {history.length > 0 && (
          <div className="history-section">
            <h2>Recent Analyses</h2>
            <div className="history-list">
              {history.map(item => (
                <div 
                  key={item.id} 
                  className="history-item"
                  style={{ borderLeftColor: getSentimentColor(item.result.label) }}
                >
                  <div className="history-text">{item.text.substring(0, 50)}{item.text.length > 50 ? '...' : ''}</div>
                  <div className="history-result">
                    <span className="history-emoji">{getSentimentEmoji(item.result.label)}</span>
                    <span 
                      className="history-label"
                      style={{ color: getSentimentColor(item.result.label) }}
                    >
                      {item.result.label}
                    </span>
                    <span className="history-score">
                      {(Math.abs(item.result.score) * 100).toFixed(1)}%
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}
      </main>
      
      <footer className="app-footer">
        <p>Powered by FastAPI and React • {new Date().getFullYear()}</p>
      </footer>
    </div>
  );
}

export default App;