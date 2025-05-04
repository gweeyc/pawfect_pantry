// src/pages/Sitemap.js
import React from 'react';
import './css/Sitemap.css';

const Sitemap = () => {
  return (
    <div className="container sitemap py-5">
      <h2 className="text-center mb-4">Sitemap</h2>
      <div className="row">
        <div className="col-md-6">
          <h4>Company</h4>
          <ul>
            <li><a href="/about">About Us</a></li>
            <li><a href="/contact">Contact</a></li>
            <li><a href="/privacy-policy">Privacy Policy</a></li>
            <li><a href="/faq">FAQs</a></li>
            <li><a href="/sitemap">Sitemap</a></li>
          </ul>

          <h4>Customer Service</h4>
          <ul>
            <li><a href="/shipping">Shipping & Delivery</a></li>
            <li><a href="/returns">Returns & Refunds</a></li>
            <li><a href="/support">Customer Support</a></li>
            <li><a href="/track-order">Track Your Order</a></li>
            <li><a href="/account">My Account</a></li>
          </ul>
        </div>

        <div className="col-md-6">
          <h4>Shop by Category</h4>
          <ul>
            <li><a href="/shop/dogs">Dog Products</a></li>
            <li><a href="/shop/cats">Cat Products</a></li>
            <li><a href="/shop/omnivore">Omnivore Food</a></li>
            <li><a href="/shop/herbivore">Herbivore Forage</a></li>
            <li><a href="/shop/exotics">Exotic Pet Food</a></li>
          </ul>

          <h4>Account & Legal</h4>
          <ul>
            <li><a href="/login">Login</a></li>
            <li><a href="/register">Register</a></li>
            <li><a href="/terms">Terms of Service</a></li>
            <li><a href="/newsletter">Newsletter Signup</a></li>
            <li><a href="/careers">Careers</a></li>
          </ul>
        </div>
      </div>
    </div>
  );
};

export default Sitemap;
