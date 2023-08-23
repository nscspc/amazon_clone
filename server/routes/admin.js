const express = require('express');
const adminRouter = express.Router();
const adminMiddleware = require('../middleware/adminMiddleware');
const Product = require('../models/product');

// Add Product
adminRouter.post('/admin/add-product' , adminMiddleware , async (req , res) => {
    try {
        const { name , description , quantity , price , category } = req.body;
        // const { name , description , images , quantity , price , category } = req.body; // these names of the field should match with the name of the fields present in product.dart file.
        let product = new Product({
            name,
            description,
            // images,
            quantity,
            price,
            category,
        });
        product = await product.save();
        res.json(product);
    } catch (e) {
        res.status(500).json({error:e.message});
    }
});

module.exports = adminRouter;