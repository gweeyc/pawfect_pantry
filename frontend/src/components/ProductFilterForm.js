import React, { useState } from 'react';
import './css/ProductFilterForm.css';

const ProductFilterForm = ({ onFilter }) => {
  const [search, setSearch] = useState('');
  const [sort, setSort] = useState('');
  const [category, setCategory] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    onFilter({ search, sort, category });
  };

  return (
    <form className="product-filter-form" onSubmit={handleSubmit}>
      <input
        type="text"
        name="search"
        placeholder="Search products..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />

      <select name="sort" value={sort} onChange={(e) => setSort(e.target.value)}>
        <option value="">Sort By</option>
        <option value="price_asc">Price: Low to High</option>
        <option value="price_desc">Price: High to Low</option>
        <option value="az">A–Z</option>
        <option value="za">Z–A</option>
      </select>

      <select name="category" value={category} onChange={(e) => setCategory(e.target.value)}>
        <option value="">All Categories</option>
        <option value="farmed_fish">Farmed Fish</option>
        <option value="crustaceans">Crustaceans</option>
        <option value="mollusc">Mollusc and Shellfish</option> {/* ✅ corrected spelling */}
        <option value="salmon_and_tuna">Salmon & Tuna</option> {/* ✅ match backend */}
        <option value="wild_caught_fish">Wild-Caught Fish</option>
      </select>


      <button type="submit">Apply</button>
    </form>
  );
};

export default ProductFilterForm;
