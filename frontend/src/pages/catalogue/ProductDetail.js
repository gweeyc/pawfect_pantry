import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import axios from '../../api/axiosInstance';
import './css/ProductDetail.css';
import FeedbackSection from '../../components/FeedbackSection';

const ProductDetail = () => {
  const { id } = useParams();
  const [product, setProduct] = useState(null);
  const [feedbackList, setFeedbackList] = useState([]);
  const [comment, setComment] = useState('');
  const [success, setSuccess] = useState(false);
  const [error, setError] = useState('');

  // Fetch product and feedback
  useEffect(() => {
    async function fetchData() {
      try {
        const res = await axios.get(`http://localhost:8000/api/catalogue/${id}/`);
        setProduct(res.data);
        setFeedbackList(res.data.feedback || []);
      } catch (err) {
        console.error(err);
        setError('Failed to load product data');
      }
    }
    fetchData();
  }, [id]);

  const handleSubmitFeedback = async (e) => {
    e.preventDefault();
    try {
      await axios.post(`http://localhost:8000/api/catalogue/${id}/feedback/submit/`, { comment }, {
        withCredentials: true
      });
      setComment('');
      setSuccess(true);
      setError('');

      // Refresh feedback
      const updated = await axios.get(`http://localhost:8000/api/catalogue/${id}/`);
      setFeedbackList(updated.data.feedback || []);

      setTimeout(() => setSuccess(false), 3000);
    } catch (err) {
      setError('Error submitting feedback');
      console.error(err);
    }
  };

  const handleAddToCart = async (productId) => {
    try {
      const response = await axios.post(`http://localhost:8000/api/catalogue/${id}/feedback/submit/`, { comment }, {
        withCredentials: true
      });
      alert(response.data.message || 'Item added to cart!');
    } catch (error) {
      console.error('Error adding to cart:', error);
      alert('Failed to add item. Please ensure you are logged in.');
    }
  };

  if (!product) return <div>Loading...</div>;

  return (
    <div className="product-detail">
      <img
        src={product.image || '/static/images/placeholder.jpg'}
        alt={product.name}
        className="product-img"
      />

      <h2>{product.name}</h2>
      <p><strong>Category:</strong> {product.category}</p>
      <p>{product.description}</p>
      <p><strong>Price:</strong> ${product.price}</p>
      <p>
        <strong>Stock:</strong>{' '}
        {product.stock > 0 ? product.stock : (
          <span style={{ color: 'red' }}>Out of Stock</span>
        )}
      </p>

      <button
        className="checkout-btn"
        onClick={() => handleAddToCart(product.id)}
        disabled={product.stock <= 0}
      >
        {product.stock > 0 ? 'Add to Cart' : 'Out of Stock'}
      </button>

      <FeedbackSection feedbackList={feedbackList} />

      <div className="feedback-form">
        <h3>Leave Feedback</h3>
        <form onSubmit={handleSubmitFeedback}>
          <textarea
            value={comment}
            onChange={(e) => setComment(e.target.value)}
            rows="4"
            placeholder="Write your comment"
            required
          />
          {success && <p className="text-success">Thank you for your feedback!</p>}
          {error && <p className="text-danger">{error}</p>}
          <button type="submit">Submit Feedback</button>
        </form>
      </div>
    </div>
  );
};

export default ProductDetail;
