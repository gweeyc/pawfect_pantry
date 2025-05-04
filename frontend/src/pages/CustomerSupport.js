// src/pages/CustomerSupport.js
import React from 'react';
import './css/CustomerSupport.css';

const CustomerSupport = () => {
  return (
    <div className="container customer-support py-5">
      <h2 className="text-center mb-4">Customer Support</h2>
      <p>We’re here to help! If you need assistance with your order, product inquiries, or general feedback, our support team is available to assist you.</p>

      <h4>How to Reach Us</h4>
      <ul>
        <li>Email: <a href="mailto:support@wildpawpantry.com">support@wildpawpantry.com</a></li>
        <li>Phone: +1 (800) 123-4567 (Mon–Fri, 9am–6pm EST)</li>
        <li>Live Chat: Available on our website during business hours</li>
      </ul>

      <h4>Common Issues</h4>
      <ul>
        <li>Missing or delayed orders</li>
        <li>Returns and refunds</li>
        <li>Feeding guidance for exotic pets</li>
        <li>Product substitution or availability</li>
      </ul>

      <h4>Feedback & Complaints</h4>
      <p>Your feedback matters. If you’re not satisfied with your experience, please reach out directly so we can resolve the issue promptly.</p>
    </div>
  );
};

export default CustomerSupport;