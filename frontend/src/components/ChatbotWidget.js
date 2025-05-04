import React, { useState } from 'react';
import './css/ChatbotWidget.css';
import axios from 'axios';


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
      const response = await axios.post(
        `${process.env.REACT_APP_API_URL}/api/ai/chatbot/`,
        { message: input },
        { withCredentials: true } // ensures session/cookie is included
      );
  
      const botReply = response.data.reply || "❓ Sorry, I didn't understand that.";
      setMessages([...newMessages, { type: 'bot', text: botReply }]);
  
    } catch (err) {
      if (err.response && err.response.status === 401) {
        setMessages([...newMessages, {
          type: 'bot',
          text: "🔒 Please log in to use the chatbot. You can log in from the top-right menu."
        }]);
      } else {
        setMessages([...newMessages, {
          type: 'bot',
          text: "❓ I do not understand your message, please try typing again."
        }]);
      }
    }
  };
  return (
    <>
      <button id="chatbot-toggle" onClick={toggleChatbot}>
        <div className="chatbot-icon">
        💬
        </div>
      </button>

      {open && (
        <div id="chatbot-box">
          <div id="chatbot-header">🤖 Ask Me Anything</div>
          <div id="chatbot-messages">
            {messages.map((msg, idx) => (
              <div
                className={`chatbot-message chatbot-${msg.type}`}
                dangerouslySetInnerHTML={{ __html: msg.text }}
              ></div>
            ))}
          </div>
          <form id="chatbot-form" onSubmit={handleSubmit}>
            <input
              type="text"
              id="chatbot-input"
              value={input}
              onChange={(e) => setInput(e.target.value)}
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
