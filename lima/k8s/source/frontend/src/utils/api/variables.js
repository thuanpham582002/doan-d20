export const variables = {
    BASE_URL: process.env.REACT_APP_API_URL || "https://api.noroom113.com/api/",
    USER_API: `${process.env.REACT_APP_API_URL || "https://api.noroom113.com/api/"}user`,
    PRODUCT_API: `${process.env.REACT_APP_API_URL || "https://api.noroom113.com/api/"}product`, 
    ORDER_API: `${process.env.REACT_APP_API_URL || "https://api.noroom113.com/api/"}order`,
    PRODUCTSIZE_API: `${process.env.REACT_APP_API_URL || "https://api.noroom113.com/api/"}productsize`,
    ORDERITEM_API: `${process.env.REACT_APP_API_URL || "https://api.noroom113.com/api/"}orderitem`,
}