import React from 'react';
import { motion } from 'framer-motion';
import './css/About.css';

const About = () => (
  <motion.div
    initial={{ opacity: 0, y: 30 }}
    animate={{ opacity: 1, y: 0 }}
    transition={{ duration: 0.6 }}
  >
    <div className="container-fluid p-0">
      <div className="row">
        <div className="col-12 text-center mt-3">
          <h1 className="homepage-title"><img src="/media/images/rabbit.png" alt="Rabbit" className="rabbit" />About PawFect Pantry</h1>
        </div>
      </div>
    </div>
    <hr className="solid my-4" />
    <div className="container-fluid p-0">
      <div className="row">
        <div className="col-12">
          <motion.img
            src="/media/images/about_banner.png"
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
    <div className="container">
      <div className="row">
        <motion.div
          className="col-md-3"
          initial={{ opacity: 0, x: -50 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5, delay: 0.3 }}
        >
          <img
            src="/media/images/logo2.png"
            alt="Logo 2"
            className="img-fluid rounded shadow h-100 w-100 object-fit-cover"
          />
        </motion.div>
        <motion.div
          className="col-md-9"
          initial={{ opacity: 0, x: 50 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5, delay: 0.3 }}
        >
        <div className="about-text">
        <p>
  PawFect Pantry is your trusted destination for premium pet food, accessories, and lifestyle products. Our mission is to deliver joy, nutrition, and long-term wellness to pets through a carefully curated selection of high-quality, delicious, and nourishing offerings — tailored to every breed, species, and dietary need.
</p>

<p>
  Whether you’re shopping for playful pups, curious cats, gentle rabbits, or exotic companions like ferrets, birds, or teacup pigs, our store is stocked with products we proudly stand behind. Every item is handpicked for safety, taste, and sustainability — because your pets deserve nothing but the best.
</p>

<p>
  At PawFect Pantry, we take pride in working with trusted suppliers and ethical producers around the world. From organic treats to eco-friendly toys and hypoallergenic meals, we are committed to promoting wellness without compromising on quality or values.
</p>

<p>
  Our e-commerce experience is built with pet parents in mind — fast loading, secure checkout, real-time inventory, and AI-powered recommendations to help you find the right products faster. Plus, with friendly customer support and speedy delivery, we’re always just a paw-click away.
</p>

<p>
  Beyond being a store, we’re a growing community of animal lovers. Whether you're a new pet owner or a seasoned caretaker of rare breeds, you'll find support, insights, and the joy of shopping with a brand that truly cares.
</p>

<p>
  Thank you for being part of the PawFect Pantry family. Together, let’s make every tail wag, every purr louder, and every home a happier place. 🐾
</p>

        </div> 
        </motion.div>
      </div>
    </div>
  </motion.div>
);

export default About;