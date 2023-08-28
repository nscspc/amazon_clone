const express = require('express')
const productRouter = express.Router();
const authMiddleware = require('../middleware/authMiddleware');
const Product = require('../models/product');

// /api/products?category=Essentials
// /api/amazon?theme=dark

// /api/products:category=Essentials
productRouter.get("/api/products" , authMiddleware , async ( req , res ) => {
    try {
        console.log(req.query.category); // to access parameters from url ( /api/products?category=Essentials ).
        console.log(req.params.category); // to access parameters from url ( /api/products:category=Essentials ).
        // console.log(req.query.theme);

        const products = await Product.find({category : req.query.category});

        res.json(products);

    } catch (e) {
        res.status(500).json({error:e.message});
    }
});

module.exports = productRouter;