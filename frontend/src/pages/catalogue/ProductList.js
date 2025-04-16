import React, { useState, useEffect, useCallback } from 'react';
import './css/ProductList.css';
import ProductFilterForm from '../../components/ProductFilterForm';
import { Link } from 'react-router-dom';
import axios from '../../axiosSetup';

const ProductList = ({ products: initialProducts }) => {
  const [products, setProducts] = useState(initialProducts || []);
  const [filters, setFilters] = useState({ search: '', sort: '', category: '' });
  const [loading, setLoading] = useState(!initialProducts);
  const [error, setError] = useState(null);
  const [pageInfo, setPageInfo] = useState({
    page: 1,
    hasNext: false,
    hasPrev: false,
    totalPages: 1
  });
  const [categoryData, setCategoryData] = useState(null);

  // Utility to slugify category name (e.g. "Farmed Fish" -> "farmed-fish")
  const slugify = (str) => {
    return str.toLowerCase().replace(/\s+/g, '');
  };
  

  // 🔄 Fetch products
  const fetchProducts = useCallback((page = 1, currentFilters = filters) => {
    setLoading(true);

    const queryParams = new URLSearchParams({
      page,
      search: currentFilters.search || '',
      sort: currentFilters.sort || '',
      category: currentFilters.category ? slugify(currentFilters.category) : ''
    });

    axios.get(`/api/catalogue/?${queryParams.toString()}`)
      .then(res => {
        const productArray = res.data.products;
        if (Array.isArray(productArray)) {
          setProducts(productArray);
          setPageInfo({
            page: res.data.page,
            hasNext: res.data.has_next,
            hasPrev: res.data.has_previous,
            totalPages: res.data.total_pages
          });
        } else {
          setProducts([]);
          console.warn('Expected "products" array, got:', res.data);
        }
      })
      .catch(err => {
        console.error('Product fetch error:', err);
        setError('Failed to load products.');
      })
      .finally(() => setLoading(false));
  }, [filters]);

  // 📸 Fetch category banner image
  const fetchCategoryBanner = useCallback(async (slug) => {
    if (!slug) return setCategoryData(null);
    try {
      const res = await axios.get(`/api/category-meta/${slugify(slug)}/`);
      setCategoryData(res.data);
    } catch (err) {
      console.warn('No banner image found for category:', slug);
      setCategoryData(null);
    }
  }, []);

  useEffect(() => {
    if (!initialProducts) {
      fetchProducts(1, filters);
    }
  }, [initialProducts, fetchProducts, filters]);

  useEffect(() => {
    fetchProducts(1, filters);
    fetchCategoryBanner(filters.category ? slugify(filters.category) : '');
  }, [filters, fetchProducts, fetchCategoryBanner]);

  // 🛒 Add to cart
  const handleAddToCart = async (productId) => {
    try {
      const response = await axios.post(`http://localhost:8000/api/cart/add/${productId}/`, {}, {
        withCredentials: true
      });
      alert(response.data.message || 'Item added to cart!');
    } catch (error) {
      console.error('Error adding to cart:', error);
      alert('Failed to add item. Please log in first.');
    }
  };

  const handlePageChange = (newPage) => {
    fetchProducts(newPage, filters);
  };

  return (
    <div className="product-list-container">
      {categoryData?.banner_image && (
        <div className="banner">
          <img
            src={categoryData.banner_image}
            alt={`${categoryData.name} Banner`}
            className="banner-img"
          />
        </div>
      )}

      <ProductFilterForm onFilter={setFilters} />

      {loading && <p className="text-center">Loading products...</p>}
      {error && <p className="text-danger text-center">{error}</p>}

      <div className="product-grid">
        {products.length > 0 ? (
          products.map(product => (
            <div key={product.id} className="product-card">
              <img
                src={product.image || '/static/images/placeholder.jpg'}
                alt={product.name}
                className="product-img"
              />
              <h3>{product.name}</h3>
              <p>{product.description?.slice(0, 100)}...</p>
              <div className="price">${product.price}</div>
              <div className="category">{product.category}</div>
              <p className="views">{product.views} views</p>
              <Link to={`/catalogue/${product.id}`} className="view-link">View Details</Link>
              <button className="add-btn" onClick={() => handleAddToCart(product.id)}>
                Add to Cart
              </button>
            </div>
          ))
        ) : !loading ? (
          <p className="text-center">No products match your criteria.</p>
        ) : null}
      </div>

      <div className="pagination-controls">
        {pageInfo.hasPrev && (
          <button onClick={() => handlePageChange(pageInfo.page - 1)} className="btn btn-outline-primary me-2">
            &laquo; Previous
          </button>
        )}
        <span>Page {pageInfo.page} of {pageInfo.totalPages}</span>
        {pageInfo.hasNext && (
          <button onClick={() => handlePageChange(pageInfo.page + 1)} className="btn btn-outline-primary ms-2">
            Next &raquo;
          </button>
        )}
      </div>
    </div>
  );
};

export default ProductList;
