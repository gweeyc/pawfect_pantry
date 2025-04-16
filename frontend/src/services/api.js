const API_BASE_URL = 'http://localhost:8000/api'; // Django backend

// Login user
export const loginUser = async (username, password) => {
  try {
    const response = await fetch(`${API_BASE_URL}/auth/login/`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ username, password }),
    });

    const data = await response.json();
    return { ok: response.ok, data };
  } catch (error) {
    console.error('Login failed:', error);
    return { ok: false, data: { message: 'Server error' } };
  }
};
