// src/pages/ReturnsRefunds.js
import React from 'react';
import './css/ReturnsRefunds.css';

const ReturnsRefunds = () => {
  return (
    <div className="container returns-refunds py-5">
      <h2 className="text-center mb-4">Returns & Refunds</h2>
      <h4>Return Policy</h4>
      <p>If you're not fully satisfied with your purchase, you may return unused, unopened items within 14 days of receipt for a full refund.</p>

      <h4>Return Conditions</h4>
      <ul>
        <li>Items must be returned in original packaging.</li>
        <li>Returns must include proof of purchase.</li>
        <li>Opened or used products are not eligible unless faulty.</li>
      </ul>

      <h4>Refund Process</h4>
      <p>Once your return is received and inspected, we’ll notify you via email and process the refund to your original payment method within 5–7 business days.</p>

      <h4>Exchanges</h4>
      <p>We currently do not offer direct exchanges. Please return the product and place a new order if needed.</p>

      <h4>Contact for Returns</h4>
      <p>Email us at <a href="mailto:returns@wildpawpantry.com">returns@wildpawpantry.com</a> for a return authorization and instructions.</p>
    </div>
  );
};

export default ReturnsRefunds;
