import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://192.168.106.3:30001';

const api = axios.create({
    baseURL: API_URL,
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    }
});

// Add token to requests if it exists
api.interceptors.request.use((config) => {
    const token = localStorage.getItem('token');
    if (token) {
        config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
});

export const auth = {
    login: (credentials) => api.post('/api/auth/login', credentials),
    register: (userData) => api.post('/api/auth/register', userData),
};

export const products = {
    getAll: () => api.get('/api/products/'),
    getById: (id) => api.get(`/api/products/${id}`),
};

export const cart = {
    get: () => api.get('/api/cart/'),
    addItem: (productId, quantity = 1) => api.post('/api/cart/add', { product_id: productId, quantity }),
    removeItem: (productId) => api.delete(`/api/cart/remove/${productId}`),
    updateQuantity: (productId, quantity) => api.put(`/api/cart/update/${productId}`, { quantity }),
};

export default api; 