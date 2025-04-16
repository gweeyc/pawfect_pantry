// src/components/AppInit.js
import { useEffect } from 'react';
import axios from '../axiosSetup';

const AppInit = () => {
  useEffect(() => {
    axios.get('/api/csrf/', {
      withCredentials: true,
    })
    .then(() => console.log('✅ CSRF token fetched'))
    .catch(() => console.warn('❌ CSRF fetch failed'));
  }, []);

  return null;
};

export default AppInit;
