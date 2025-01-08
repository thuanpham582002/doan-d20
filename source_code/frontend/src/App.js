import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import { AppBar, Toolbar, Typography, Button, Box } from '@mui/material';
import ProductsV2 from './pages/ProductsV2';
import Products from './pages/Products';
import Cart from './pages/Cart';

function App() {
  return (
    <Router>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            E-commerce
          </Typography>
          <Button color="inherit" component={Link} to="/">Products</Button>
          <Button color="inherit" component={Link} to="/cart">Cart</Button>
        </Toolbar>
      </AppBar>

      <Box sx={{ py: 4 }}>
        <Routes>
          {/* <Route path="/" element={<Products />} /> */}
          <Route path="/" element={<ProductsV2 />} />
          <Route path="/cart" element={<Cart />} />
        </Routes>
      </Box>
    </Router>
  );
}

export default App;