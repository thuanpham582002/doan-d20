import { render, screen, waitFor } from '@testing-library/react';
import App from './App';

// Mock axios
jest.mock('axios', () => {
  const mockAxios = {
    create: jest.fn(() => mockAxios),
    get: jest.fn(() => Promise.resolve({ data: [] })),
    post: jest.fn(),
    put: jest.fn(),
    delete: jest.fn(),
    interceptors: {
      request: { use: jest.fn() },
      response: { use: jest.fn() }
    }
  };
  return mockAxios;
});

// Mock the AuthContext
jest.mock('./context/AuthContext', () => ({
  useAuth: () => ({
    isAuthenticated: false,
    login: jest.fn(),
    logout: jest.fn()
  }),
  AuthProvider: ({ children }) => children
}));

describe('App Component', () => {
  test('renders without crashing', async () => {
    render(<App />);
    // Wait for the app to load and check for navigation elements
    await waitFor(() => {
      expect(screen.getByText('E-commerce')).toBeInTheDocument();
      expect(screen.getByText('Products')).toBeInTheDocument();
      expect(screen.getByText('Cart')).toBeInTheDocument();
    });
  });

  test('renders Products page by default', async () => {
    render(<App />);
    // Wait for the products page to load
    await waitFor(() => {
      expect(screen.getByText('E-commerce')).toBeInTheDocument();
    });
  });
}); 