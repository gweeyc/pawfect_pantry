import React, { useState } from 'react';
import './css/Contact.css';
import { motion } from 'framer-motion';

const Contact = () => {
  const [form, setForm] = useState({ name: '', email: '', subject: '', message: '' });

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const handleSubmit = (e) => {
    e.preventDefault();
    alert('Message sent successfully!');
  };

  return (
    <>
      {/* Banner Image */}
      <div className="container-fluid p-0">
        <div className="row">
          <div className="col-12">
            <motion.img
              src="/media/images/contact_banner.png"
              alt="Banner"
              className="img-fluid w-100 banner"
              initial={{ scale: 0.9, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ duration: 0.5 }}
            />
          </div>
        </div>
      </div>
      <hr className="solid my-4" />
      {/* Contact Info and Form */}
      <div className="container my-6">
        <div className="row">
          {/* LEFT: MAP */}
          <div className="col-md-6 mb-4 mb-md-0">
            <div className="h-100 rounded shadow overflow-hidden">
              <iframe
                title="Marina Bay MRT Map"
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15955.138792877843!2d103.85435608451789!3d1.280094706742749!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31da190fcc7a4a2d%3A0x4b35212982ea55b7!2sMarina%20Bay%20MRT%20Station!5e0!3m2!1sen!2ssg!4v1713700000000!5m2!1sen!2ssg"
                width="100%"
                height="100%"
                style={{ border: 0, minHeight: '500px' }}
                allowFullScreen=""
                loading="lazy"
                referrerPolicy="no-referrer-when-downgrade"
              ></iframe>
            </div>
          </div>

          {/* RIGHT: FORM + INFO */}
          <div className="col-md-6">
            <h2 className="text-center mb-4"><u>Our Contact and Location!</u></h2>

            <div className="ps-2 mb-4">
              <div className="row">
                <div className="col-md-6 mb-3">
                  <h5>📞 Phone</h5>
                  <p>+65 6123 4567</p>
                  <h5>📧 Email</h5>
                  <p><a href="mailto:support@pawfectpantry.com">support@pawfectpantry.com</a></p>
                </div>
                <div className="col-md-6 mb-3">
                  <h5>📍 Address</h5>
                  <p className="handwriting mb-0">
                    Marina Bay MRT<br />
                    10 Bayfront Ave<br />
                    Singapore 018956
                  </p>
                </div>
              </div>
            </div>
            <hr className="solid divider-line" />
            <form onSubmit={handleSubmit} className="p-3 shadow rounded bg-light">
              <div className="mb-3">
                <input
                  type="text"
                  name="name"
                  className="form-control"
                  placeholder="Your name"
                  required
                  value={form.name}
                  onChange={handleChange}
                />
              </div>
              <div className="mb-3">
                <input
                  type="email"
                  name="email"
                  className="form-control"
                  placeholder="Your email"
                  required
                  value={form.email}
                  onChange={handleChange}
                />
              </div>
              <div className="mb-3">
                <input
                  type="text"
                  name="subject"
                  className="form-control"
                  placeholder="Subject"
                  required
                  value={form.subject}
                  onChange={handleChange}
                />
              </div>
              <div className="mb-3">
                <textarea
                  name="message"
                  className="form-control"
                  rows="4"
                  placeholder="Your message"
                  required
                  value={form.message}
                  onChange={handleChange}
                ></textarea>
              </div>
              <button type="submit" className="btn btn-primary w-100">Send Message</button>
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default Contact;
