import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import {
  AppBar,
  Toolbar,
  Typography,
  Button,
  Box,
} from '@mui/material';
import { useAuth } from '../context/AuthContext';

const Navbar = () => {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();

  // Don't show navbar on login page
  if (location.pathname === '/login') {
    return null;
  }

  return (
    <AppBar position="static">
      <Toolbar>
        <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
          E-commerce
        </Typography>
        <Box>
          <Button 
            color="inherit" 
            onClick={() => navigate('/products')}
            sx={{ mx: 1 }}
          >
            Products
          </Button>
          {user ? (
            <>
              <Button 
                color="inherit" 
                onClick={() => navigate('/cart')}
                sx={{ mx: 1 }}
              >
                Cart
              </Button>
              <Button 
                color="inherit"
                onClick={logout}
                sx={{ mx: 1 }}
              >
                Logout
              </Button>
            </>
          ) : (
            <Button 
              color="inherit"
              onClick={() => navigate('/login')}
              sx={{ mx: 1 }}
            >
              Login
            </Button>
          )}
        </Box>
      </Toolbar>
    </AppBar>
  );
};

export default Navbar; 