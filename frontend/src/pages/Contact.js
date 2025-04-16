import React, { useState } from 'react';
import './css/Contact.css';

const Contact = () => {
  const [form, setForm] = useState({ name: '', email: '', subject: '', message: '' });

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const handleSubmit = (e) => {
    e.preventDefault();
    alert('Message sent successfully!');
  };

  return (
    <div className="form-container">
      <h2>Contact Us</h2>
      <form onSubmit={handleSubmit}>
        <input type="text" name="name" placeholder="Your name" required value={form.name} onChange={handleChange} />
        <input type="email" name="email" placeholder="Your email" required value={form.email} onChange={handleChange} />
        <input type="text" name="subject" placeholder="Subject" required value={form.subject} onChange={handleChange} />
        <textarea name="message" placeholder="Your message" required value={form.message} onChange={handleChange}></textarea>
        <button type="submit">Send Message</button>
      </form>
    </div>
  );
};

export default Contact;
