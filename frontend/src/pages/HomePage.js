import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import { motion } from 'framer-motion';
import './css/HomePage.css';
import ProductFilterForm from '../components/ProductFilterForm';

const HomePage = () => {
  const [recommended, setRecommended] = useState([]);
  const navigate = useNavigate();

  useEffect(() => {
    axios.get(`${process.env.REACT_APP_API_URL}/api/ai/recommend/`, { withCredentials: true })
      .then(res => {
        setRecommended(res.data.recommended || []);
      })
      .catch(err => {
        console.error('Failed to fetch AI recommendations:', err);
      });
  }, []);

  const handleFilter = (filters) => {
    const queryParams = new URLSearchParams();
    if (filters.search) queryParams.append('search', filters.search);
    if (filters.sort) queryParams.append('sort', filters.sort);
    if (filters.species) queryParams.append('species', filters.species);
    if (filters.food_type) queryParams.append('food_type', filters.food_type);
    navigate(`/catalogue?${queryParams.toString()}`);
  };

  return (
    <>
      <motion.div className="container-fluid p-0" initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 1 }}>
        <div className="row">
          <div className="col-12 text-center mt-3">
            <h1 className="homepage-title">Welcome to Our Pet Food & Merchandise Store <img src="/media/images/cute-cat.png" alt="Cute Cat" className="cute-cat" /></h1>
          </div>
        </div>
      </motion.div>

      <div className="container my-3">
        <ProductFilterForm onFilter={handleFilter} />
      </div>

      <hr className="solid my-4" />

      <motion.div className="container-fluid p-0" initial={{ y: 50, opacity: 0 }} animate={{ y: 0, opacity: 1 }} transition={{ duration: 1 }}>
        <div className="row">
          <div className="col-12">
            <img src="/media/images/home_banner.png" alt="Banner" className="img-fluid w-100 banner" />
          </div>
        </div>
      </motion.div>

      <hr className="solid my-4" />

      <motion.div className="container home-container" initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 1 }}>
        <div className="row align-items-stretch">
          <div className="col-md-6 d-flex">
            <div className="welcome-card w-100">
              <h2 className="homepage-subtitle">
                <img src="/media/images/corgi_butt.png" alt="Corgi Butt" className="corgi-butt" /> “Tail-Wagging Goodness in Every Treat!”</h2>
              <hr className="solid divider-line" />
              <div className="about-text">
                <p>We provide the freshest, highest-quality pet food and thoughtfully curated merchandise to meet your companions' daily needs. From nutrition to playtime, enrichment to grooming, your pets deserve nothing less than excellence — and we deliver it with care, precision, and love.</p>
                <p>All our products are sustainably sourced from trusted suppliers across the globe. We work only with partners who share our commitment to quality, safety, and ethical practices, ensuring every bite and toy meets rigorous standards without compromise.</p>
                <p>Whether you're looking for grain-free kibble, freeze-dried treats, interactive toys, or eco-friendly accessories — we've got it all. Whatever your furry, scaly, or feathered friend needs, PawFect Pantry is here to keep tails wagging, feathers fluffed, and whiskers happy!</p>
              </div>
            </div>
          </div>
          <div className="col-md-6">
            <img src="/media/images/home_images.png" alt="Cats and Dogs" className="img-fluid rounded shadow h-100 w-100 object-fit-cover" />
          </div>
        </div>
      </motion.div>

      <hr className="solid my-4" />

      <motion.div className="container home-container" initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 1.2 }}>
        <div className="row align-items-stretch">
          <div className="col-md-6">
            <img src="/media/images/exotic_images.png" alt="Exotic Pets" className="img-fluid rounded shadow h-100 w-100 object-fit-cover" />
          </div>
          <div className="col-md-6 d-flex">
            <div className="welcome-card w-100">
              <h2 className="homepage-subtitle"><img src="/media/images/hedgehog.png" alt="Hedgehog" className="hedgehog" /> “We have food for exotic pets too !” <img src="/media/images/ferret.png" alt="Ferret" className="ferret" /></h2>
              <hr className="solid divider-line" />
              <div className="about-text">
                <p>We cater to all breeds of cats and dogs, as well as unique companions such as rabbits, rodents, mustelids, hedgehogs, birds, meerkats, marmoset monkeys, teacup pigs, and fennec foxes. At PawFect Pantry, we believe every animal — no matter how big, small, furry, or feathery — deserves love, care, and high-quality nutrition.</p>
                <p>Our team is passionate about pet well-being and works closely with nutritionists and suppliers to ensure that every product we offer meets high standards of quality, safety, and sustainability. Whether your pet thrives on grain-free formulas, raw alternatives, or specialized diets, we’ve got something to keep their tails wagging and whiskers twitching.</p>
                <p>We understand the needs of today’s pet parents. That’s why our platform offers curated selections, smart recommendations, and convenient doorstep delivery — all backed by friendly support and secure shopping.</p>
                <p>Your pet’s health and happiness is our mission. Thank you for choosing PawFect Pantry, where love is delivered in every bite! 🐾</p>
              </div>
            </div>
          </div>
        </div>
      </motion.div>

      <hr className="solid my-4" />

      <motion.div className="container my-5" initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ duration: 1.4 }}>
        <h2 className="mb-4 text-center">Our Recommendations<img src="/media/images/corgi-over-navbar.png" alt="Cargi" className="corgi-over-navbar" /></h2>
        <div className="row">
          {recommended.length > 0 ? (
            recommended.map(product => (
              <div key={product.id} className="col-md-4 mb-4">
                <motion.div className="card shadow-sm h-100" whileHover={{ scale: 1.03 }}>
                  <img
                    src={product.image || "/media/images/placeholder.jpg"}
                    className="card-img-top"
                    alt={product.name}
                    style={{ height: '200px', objectFit: 'cover' }}
                    onError={(e) => { e.target.onerror = null; e.target.src = "/media/images/placeholder.jpg"; }}
                  />
                  <div className="card-body d-flex flex-column">
                    <h5 className="card-title">{product.name}</h5>
                    <p className="card-text text-success"><strong>${product.price}</strong></p>
                    <p className="card-text"><strong>Views:</strong> {product.views}</p>
                    <a href={`/catalogue/${product.id}`} className="btn btn-primary mt-auto">View Details</a>
                  </div>
                </motion.div>
              </div>
            ))
          ) : (
            <div className="text-center">
              <p>Loading recommendations or none found.</p>
            </div>
          )}
        </div>
      </motion.div>
    </>
  );
};

export default HomePage;
