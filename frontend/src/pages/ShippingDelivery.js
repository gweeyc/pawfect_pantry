// src/pages/ShippingDelivery.js
import React from 'react';
import './css/ShippingDelivery.css';

const ShippingDelivery = () => {
  return (
    <div className="container shipping-delivery py-5">
      <h2 className="text-center mb-4">Shipping & Delivery</h2>
      <h4>Shipping Times</h4>
      <p>Orders are processed within 1–2 business days. Shipping typically takes 3–7 business days within the continental U.S.</p>

      <h4>Shipping Methods</h4>
      <ul>
        <li>Standard Ground (3–7 business days)</li>
        <li>Expedited (1–3 business days)</li>
        <li>Local Pickup available in select areas</li>
      </ul>

      <h4>Tracking Your Order</h4>
      <p>Once shipped, you will receive a tracking number via email. You can track your shipment directly from your account dashboard or the courier's website.</p>

      <h4>Delivery Notes</h4>
      <p>Please ensure someone is available to receive the delivery if required. We are not responsible for lost packages once marked as delivered.</p>

      <h4>Shipping Restrictions</h4>
      <p>We currently ship within the United States. We do not ship to P.O. Boxes, military addresses, or international destinations at this time.</p>
    </div>
  );
};

export default ShippingDelivery;