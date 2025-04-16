import React, { useEffect, useState } from 'react';
import axios from '../../axiosSetup';
import './css/Cart.css';
import { Link } from 'react-router-dom';

const Cart = () => {
  const [cartItems, setCartItems] = useState([]);
  const [quantities, setQuantities] = useState({});
  const [total, setTotal] = useState(0);

  useEffect(() => {
    fetchCart();
  }, []);

  const fetchCart = async () => {
    try {
      const res = await axios.get('http://localhost:8000/api/cart/', { withCredentials: true });
      const items = res.data.cart;
      setCartItems(items);

      // Set initial quantities
      const initialQuantities = items.reduce((acc, item) => {
        acc[item.product_id] = item.quantity;
        return acc;
      }, {});
      setQuantities(initialQuantities);

      setTotal(res.data.total);
    } catch (err) {
      console.error('Error fetching cart:', err);
    }
  };

  const handleQuantityChange = (productId, value) => {
    setQuantities(prev => ({
      ...prev,
      [productId]: value,
    }));
  };

  const handleUpdateCart = async () => {
    try {
      const payload = {
        items: Object.entries(quantities).map(([product_id, quantity]) => ({
          product_id,
          quantity,
        }))
      };
      await axios.post('http://localhost:8000/api/cart/update/', payload, { withCredentials: true });
      alert('Cart updated!');
      fetchCart();
    } catch (err) {
      console.error('Failed to update cart:', err);
    }
  };

  const handleRemove = async (productId) => {
    try {
      await axios.post(`http://localhost:8000/api/cart/remove/${productId}/`, {}, { withCredentials: true });
      fetchCart();
    } catch (err) {
      console.error('Error removing item:', err);
    }
  };

  return (
    <div className="cart-container">
      <h2>Your Cart</h2>
      {cartItems.length > 0 ? (
        <>
          <table>
            <thead>
              <tr>
                <th>#</th>
                <th>Item</th>
                <th>Quantity</th>
                <th>Price ($)</th>
                <th>Subtotal ($)</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {cartItems.map((item, index) => (
                <tr key={item.id}>
                  <td>{index + 1}</td>
                  <td>{item.product_name}</td>
                  <td>
                    <input
                      type="number"
                      min="1"
                      value={quantities[item.product_id]}
                      onChange={(e) =>
                        handleQuantityChange(item.product_id, parseInt(e.target.value))
                      }
                    />
                  </td>
                  <td>{item.price.toFixed(2)}</td>
                  <td>{(item.price * quantities[item.product_id]).toFixed(2)}</td>
                  <td>
                    <button
                      className="btn btn-delete"
                      onClick={() => handleRemove(item.product_id)}
                    >
                      Delete
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          <div className="total">Total: ${total.toFixed(2)}</div>
          <button className="btn btn-update" onClick={handleUpdateCart}>
            Update Cart
          </button>
          <Link to="/checkout" className="checkout-btn">
            Proceed to Checkout
          </Link>
        </>
      ) : (
        <p>Your cart is empty.</p>
      )}
    </div>
  );
};

export default Cart;
