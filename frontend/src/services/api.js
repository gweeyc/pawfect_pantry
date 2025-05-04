// api.js - API configuration file

// Base URLs configuration
const API_BASES = {
  development: {
    django: 'http://localhost:8000',
    fastapi: 'http://localhost:8001'
  },
  production: {
    django: '/django',  // Django API prefix in production
    fastapi: '/api'     // FastAPI API prefix in production
  }
};

// Get the appropriate base URL based on environment and API type
const getBaseUrl = (apiType = 'fastapi') => {
  const environment = process.env.NODE_ENV === 'development' ? 'development' : 'production';
  return API_BASES[environment][apiType];
};

// API Endpoints configuration
export const API_ENDPOINTS = {
  auth: {
    login: `${getBaseUrl('django')}/auth/login/`,  // Using Django for auth
    register: `${getBaseUrl('django')}/auth/register/`
  },
  data: {
    items: `${getBaseUrl('fastapi')}/items/`,      // Using FastAPI for data
    users: `${getBaseUrl('fastapi')}/users/`
  }
};

// Generic API request helper
export const apiRequest = async (url, method = 'GET', body = null, headers = {}) => {
  try {
    const config = {
      method,
      headers: {
        'Content-Type': 'application/json',
        ...headers
      }
    };

    if (body) {
      config.body = JSON.stringify(body);
    }

    const response = await fetch(url, config);
    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.message || 'Request failed');
    }

    return { ok: true, data };
  } catch (error) {
    console.error('API request failed:', error);
    return { 
      ok: false, 
      data: { 
        message: error.message || 'Server error' 
      } 
    };
  }
};

// Specific API functions
export const loginUser = async (username, password) => {
  return apiRequest(API_ENDPOINTS.auth.login, 'POST', { username, password });
};

export const fetchItems = async () => {
  return apiRequest(API_ENDPOINTS.data.items);
};

export const createItem = async (itemData) => {
  return apiRequest(API_ENDPOINTS.data.items, 'POST', itemData);
};