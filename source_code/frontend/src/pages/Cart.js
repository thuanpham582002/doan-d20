import React, { useState, useEffect } from 'react';
import {
  Container,
  Typography,
  Paper,
  List,
  ListItem,
  ListItemText,
  ListItemSecondaryAction,
  IconButton,
  Button,
  Divider,
  Box,
  CircularProgress,
  Alert,
} from '@mui/material';
import DeleteIcon from '@mui/icons-material/Delete';
import AddIcon from '@mui/icons-material/Add';
import RemoveIcon from '@mui/icons-material/Remove';
import { cart, products } from '../services/api';

function Cart() {
  const [cartItems, setCartItems] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [productDetails, setProductDetails] = useState({});

  useEffect(() => {
    fetchCart();
  }, []);

  const fetchCart = async () => {
    try {
      const cartResponse = await cart.get();
      const items = cartResponse.data.items || [];
      
      // Fetch product details for each item
      const productIds = [...new Set(items.map(item => item.product_id))];
      const productPromises = productIds.map(id => products.getById(id));
      const productResponses = await Promise.all(productPromises);
      
      const productMap = {};
      productResponses.forEach(response => {
        const product = response.data;
        productMap[product.id] = product;
      });
      
      setProductDetails(productMap);
      setCartItems(items);
    } catch (err) {
      setError('Failed to load cart');
    } finally {
      setLoading(false);
    }
  };

  const handleUpdateQuantity = async (productId, newQuantity) => {
    try {
      if (newQuantity <= 0) {
        // Remove item if quantity is 0 or less
        await cart.removeItem(productId);
      } else {
        await cart.updateQuantity(productId, newQuantity);
      }
      await fetchCart(); // Refresh cart after update
    } catch (err) {
      setError('Failed to update quantity');
    }
  };

  const handleRemoveItem = async (productId) => {
    try {
      await cart.removeItem(productId);
      await fetchCart(); // Refresh cart after removal
    } catch (err) {
      setError('Failed to remove item');
    }
  };

  const calculateTotal = () => {
    return cartItems.reduce((sum, item) => {
      const product = productDetails[item.product_id];
      return sum + (product?.price || 0) * item.quantity;
    }, 0);
  };

  if (loading) return <CircularProgress />;
  if (error) return <Alert severity="error">{error}</Alert>;

  return (
    <Container maxWidth="md" sx={{ mt: 4 }}>
      <Typography variant="h4" gutterBottom>
        Shopping Cart
      </Typography>

      {cartItems.length === 0 ? (
        <Paper sx={{ p: 3, textAlign: 'center' }}>
          <Typography>Your cart is empty</Typography>
        </Paper>
      ) : (
        <>
          <Paper sx={{ mb: 4 }}>
            <List>
              {cartItems.map((item, index) => {
                const product = productDetails[item.product_id];
                if (!product) return null;
                
                return (
                  <React.Fragment key={item.product_id}>
                    <ListItem>
                      <ListItemText
                        primary={product.name}
                        secondary={`$${product.price} x ${item.quantity}`}
                      />
                      <Box sx={{ display: 'flex', alignItems: 'center', mr: 2 }}>
                        <IconButton 
                          size="small"
                          onClick={() => handleUpdateQuantity(item.product_id, item.quantity - 1)}
                        >
                          <RemoveIcon />
                        </IconButton>
                        <Typography sx={{ mx: 1 }}>{item.quantity}</Typography>
                        <IconButton 
                          size="small"
                          onClick={() => handleUpdateQuantity(item.product_id, item.quantity + 1)}
                          disabled={item.quantity >= product.stock}
                        >
                          <AddIcon />
                        </IconButton>
                      </Box>
                      <ListItemSecondaryAction>
                        <IconButton 
                          edge="end" 
                          aria-label="delete"
                          onClick={() => handleRemoveItem(item.product_id)}
                        >
                          <DeleteIcon />
                        </IconButton>
                      </ListItemSecondaryAction>
                    </ListItem>
                    {index < cartItems.length - 1 && <Divider />}
                  </React.Fragment>
                );
              })}
            </List>
          </Paper>

          <Paper sx={{ p: 3 }}>
            <Typography variant="h6" gutterBottom>
              Order Summary
            </Typography>
            <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 2 }}>
              <Typography>Subtotal:</Typography>
              <Typography>${calculateTotal().toFixed(2)}</Typography>
            </Box>
            <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 3 }}>
              <Typography>Shipping:</Typography>
              <Typography>Free</Typography>
            </Box>
            <Divider sx={{ mb: 2 }} />
            <Box sx={{ display: 'flex', justifyContent: 'space-between', mb: 3 }}>
              <Typography variant="h6">Total:</Typography>
              <Typography variant="h6">${calculateTotal().toFixed(2)}</Typography>
            </Box>
            <Button
              variant="contained"
              color="primary"
              size="large"
              fullWidth
            >
              Proceed to Checkout
            </Button>
          </Paper>
        </>
      )}
    </Container>
  );
}

export default Cart; 