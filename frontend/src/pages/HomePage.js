import React from 'react';
import './css/HomePage.css';

const HomePage = ({ products }) => {
  const safeProducts = Array.isArray(products) ? products : [];

  return (
    <>
      <div className="container-fluid p-0">
        <div className="row">
          <div className="col-12">
            <img
              src="/media/images/home_banner.png"
              alt="Banner"
              className="img-fluid w-100 banner"
            />
          </div>
        </div>
      </div>

      <div className="container home-container">
        <div className="row align-items-stretch">
          <div className="col-md-6 d-flex">
            <div className="welcome-card w-100">
              <h1>Welcome to Our Seafood Business</h1>
              <p>
                We provide the freshest and finest quality seafood sourced sustainably.
                From farm to table, our fish and prawns are grown with care and shipped with precision.
              </p>
              <p>
                Our seafood is sustainably sourced from around the world. We guarantee zero off-taste.
              </p>
            </div>
          </div>
          <div className="col-md-6">
            <img
              src="/media/images/home_images.png"
              alt="Seafood"
              className="img-fluid rounded shadow h-100 w-100 object-fit-cover"
            />
          </div>
        </div>
      </div>

      <div className="container my-5">
        <h2 className="mb-4 text-center">Our Recommendations</h2>
        <div className="row">
          {safeProducts.length > 0 ? (
            safeProducts.map(product => (
              <div key={product.id} className="col-md-4 mb-4">
                <div className="card shadow-sm h-100">
                  <img
                    src={product.image || "/media/images/placeholder.jpg"}
                    className="card-img-top"
                    alt={product.name}
                    style={{ height: '200px', objectFit: 'cover' }}
                  />
                  <div className="card-body d-flex flex-column">
                    <h5 className="card-title">{product.name}</h5>
                    <p className="card-text">{product.description?.slice(0, 100)}...</p>
                    <p className="card-text text-muted mb-1"><strong>Category:</strong> {product.category}</p>
                    <p className="card-text text-success"><strong>${product.price}</strong></p>
                    <a href={`/catalogue/${product.id}`} className="btn btn-primary mt-auto">View Details</a>
                  </div>
                </div>
              </div>
            ))
          ) : (
            <div className="text-center">
              <p>Loading products or no recommendations found.</p>
            </div>
          )}
        </div>
      </div>
    </>
  );
};

export default HomePage;
