import React from 'react';
import { Link, Outlet } from 'react-router-dom';
import './css/BaseLayout.css';
import Navbar from './NavigationBar'; // Import Navbar
import Footer from './Footer'; // ✅ Import Footer

const BaseLayout = ({ user, setUser }) => {
  return (
    <>
      {/* Logo + Brand */}
      <div className="header-top">
        <div className="brand-area">
          <Link to="/">
            <img src="/media/images/logo.png" alt="Logo" className="site-logo" />
          </Link>
          <span className="brand-name">Sustainably Caught and Farmed</span>
        </div>
      </div>

      {/* Navigation */}
      <Navbar user={user} setUser={setUser} /> {/* ✅ Pass setUser properly */}

      <hr className="m-0" />

      {/* Main Content */}
      <main className="container py-4">
        <Outlet />
      </main>

      {/* Footer */}
      <Footer />

      {/* Optional Chatbot */}
      {/* <ChatbotWidget /> */}

      {/* Bootstrap JS */}
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </>
  );
};

export default BaseLayout;
