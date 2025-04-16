import React from 'react';
import { Routes, Route } from 'react-router-dom';

import BaseLayout from './components/BaseLayout';
import AppInit from './components/AppInit'; // ✅ new

import LoginPage from './pages/auth/LoginPage';
import RegisterPage from './pages/auth/RegisterPage';
import ForgotPasswordPage from './pages/auth/ForgotPasswordPage';
import Dashboard from './pages/auth/Dashboard';

import Home from './pages/HomePage';
import About from './pages/About';
import Contact from './pages/Contact';
import ProductList from './pages/catalogue/ProductList';
import ProductDetail from './pages/catalogue/ProductDetail';
import Cart from './pages/cart/Cart';
import Checkout from './pages/cart/Checkout';
import OrderHistory from './pages/cart/OrderHistory';
import OrderDetail from './pages/cart/OrderDetail';
import '@fortawesome/fontawesome-free/css/all.min.css';

function App() {
  return (
    <>
      <AppInit /> {/* ✅ this ensures CSRF is initialized before any API call */}
      <Routes>
        <Route path="/" element={<BaseLayout />}>
          <Route index element={<Home />} />
          <Route path="about" element={<About />} />
          <Route path="contact" element={<Contact />} />
          <Route path="catalogue" element={<ProductList />} />
          <Route path="catalogue/:id" element={<ProductDetail />} />
          <Route path="cart" element={<Cart />} />
          <Route path="checkout" element={<Checkout />} />
          <Route path="/orders/history" element={<OrderHistory />} />
          <Route path="/orders/detail/:id" element={<OrderDetail />} />

          {/* Auth Pages */}
          <Route path="login" element={<LoginPage />} />
          <Route path="register" element={<RegisterPage />} />
          <Route path="dashboard" element={<Dashboard />} />
          <Route path="forgot-password" element={<ForgotPasswordPage />} />
        </Route>
      </Routes>
    </>
  );
}

export default App;
