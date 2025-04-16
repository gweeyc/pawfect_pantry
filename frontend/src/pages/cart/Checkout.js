import React, { useState } from 'react';
import './css/Checkout.css';
import axios from '../../axiosSetup';
import { useNavigate } from 'react-router-dom';

const Checkout = () => {
  const [formData, setFormData] = useState({
    full_name: '',
    phone: '',
    address: '',
    note: '',
  });

  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleChange = (e) => {
    setFormData((prev) => ({
      ...prev,
      [e.target.name]: e.target.value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      const response = await axios.post('http://localhost:8000/api/cart/checkout/', formData);
      console.log(response.data);
      alert('Order placed!');
      navigate('/orders/history');
    } catch (err) {
      console.error('Checkout error:', err);
      alert('Failed to place order');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="checkout-container">
      <h2>Checkout</h2>
      <form onSubmit={handleSubmit}>
        <label htmlFor="full_name">Full Name</label>
        <input
          type="text"
          name="full_name"
          value={formData.full_name}
          onChange={handleChange}
          required
        />

        <label htmlFor="phone">Phone</label>
        <input
          type="text"
          name="phone"
          value={formData.phone}
          onChange={handleChange}
          required
        />

        <label htmlFor="address">Shipping Address</label>
        <textarea
          name="address"
          rows="4"
          value={formData.address}
          onChange={handleChange}
          required
        ></textarea>

        <label htmlFor="note">Additional Notes (Optional)</label>
        <textarea
          name="note"
          rows="3"
          value={formData.note}
          onChange={handleChange}
        ></textarea>

        <button type="submit" disabled={loading}>
          {loading ? 'Placing Order...' : 'Confirm Order'}
        </button>
      </form>
    </div>
  );
};

export default Checkout;
