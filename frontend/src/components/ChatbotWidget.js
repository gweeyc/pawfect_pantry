import React, { useState } from 'react';
import './css/ChatbotWidget.css';

const ChatbotWidget = () => {
  const [open, setOpen] = useState(false);
  const [input, setInput] = useState('');
  const [messages, setMessages] = useState([]);

  const toggleChatbot = () => setOpen(prev => !prev);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!input.trim()) return;

    const newMessages = [...messages, { type: 'user', text: input }];
    setMessages(newMessages);
    setInput('');

    try {
      const response = await fetch('/chatbot/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ message: input })
      });

      const data = await response.json();
      setMessages([...newMessages, { type: 'bot', text: data.reply || "Sorry, I didn't understand that." }]);
    } catch {
      setMessages([...newMessages, { type: 'bot', text: "Error getting response." }]);
    }
  };

  return (
    <>
      <button id="chatbot-toggle" onClick={toggleChatbot}>💬</button>
      {open && (
        <div id="chatbot-box">
          <div id="chatbot-header">💬 Ask Me Anything</div>
          <div id="chatbot-messages">
            {messages.map((msg, idx) => (
              <div key={idx} className={`chatbot-message chatbot-${msg.type}`}>
                {msg.text}
              </div>
            ))}
          </div>
          <form id="chatbot-form" onSubmit={handleSubmit}>
            <input
              type="text"
              id="chatbot-input"
              value={input}
              onChange={e => setInput(e.target.value)}
              placeholder="Type a message..."
              required
            />
            <button type="submit" id="chatbot-send">➤</button>
          </form>
        </div>
      )}
    </>
  );
};

export default ChatbotWidget;
