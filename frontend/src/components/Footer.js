import React from 'react';
import './css/Footer.css';

const Footer = () => {
  return (
    <footer className="text-center text-lg-start bg-light text-muted mt-5">
      
      {/* Social Media Section */}
      <section className="footer-social d-flex justify-content-center justify-content-lg-between p-4 border-bottom">
        <div className="me-5 d-none d-lg-block">
          <span>Connect with us on social media:</span>
        </div>
        <div>
          <a href="https://facebook.com" className="me-4" target="_blank" rel="noopener noreferrer">
            <i className="fab fa-facebook-f"></i>
          </a>
          <a href="https://twitter.com" className="me-4" target="_blank" rel="noopener noreferrer">
            <i className="fab fa-twitter"></i>
          </a>
          <a href="https://instagram.com" className="me-4" target="_blank" rel="noopener noreferrer">
            <i className="fab fa-instagram"></i>
          </a>
          <a href="https://linkedin.com" className="me-4" target="_blank" rel="noopener noreferrer">
            <i className="fab fa-linkedin"></i>
          </a>
        </div>
      </section>

      {/* Footer Main Content */}
      <section>
        <div className="container text-center text-md-start mt-5">
          <div className="row mt-3">

            {/* Company Info */}
            <div className="col-md-4 col-lg-4 col-xl-4 mx-auto mb-4">
              <h6 className="text-uppercase fw-bold mb-4">
                <i className="fas fa-fish me-3"></i>BlueOcean Seafood Co.
              </h6>
              <p>
                Proudly sourcing and farming sustainable seafood. Fresh from our waters to your table.
              </p>
            </div>

            {/* Hidden Product Category */}
            <div className="d-none">
              <h6 className="text-uppercase fw-bold mb-4">Our Fish</h6>
              <p><a href="/catalogue" className="text-reset">Barramundi</a></p>
              <p><a href="/catalogue" className="text-reset">Coho Salmon</a></p>
              <p><a href="/catalogue" className="text-reset">Shrimp</a></p>
              <p><a href="/catalogue" className="text-reset">Steelhead Trout</a></p>
            </div>

            {/* Useful Links */}
            <div className="col-md-4 col-lg-4 col-xl-2 mx-auto mb-4">
              <h6 className="text-uppercase fw-bold mb-4">Quick Links</h6>
              <p><a href="/faq" className="text-reset">FAQ</a></p>
              <p><a href="/privacy-policy" className="text-reset">Privacy Policy</a></p>
              <p><a href="/sitemap" className="text-reset">Sitemap</a></p>
              <p><a href="/contact" className="text-reset">Contact Us</a></p>
            </div>

            {/* Contact Info */}
            <div className="col-md-4 col-lg-4 col-xl-3 mx-auto mb-md-0 mb-4">
              <h6 className="text-uppercase fw-bold mb-4">Contact</h6>
              <p><i className="fas fa-home me-3"></i> 123 Ocean Drive, Florida, USA</p>
              <p><i className="fas fa-envelope me-3"></i> info@blueoceanseafood.com</p>
              <p><i className="fas fa-phone me-3"></i> +1 800-SEAFOOD</p>
            </div>

          </div>
        </div>
      </section>

      {/* Footer Bottom */}
      <div className="text-center p-4 bg-primary text-white">
        © {new Date().getFullYear()} BlueOcean Seafood Co. All rights reserved.
      </div>
    </footer>
  );
};

export default Footer;
