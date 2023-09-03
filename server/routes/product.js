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

// create a get request to search products and get them
// /api/products/search/i
productRouter.get("/api/products/search/:name" , authMiddleware , async ( req , res ) => {
    try {

        const products = await Product.find({
            name:{$regex: req.params.name , $options: "i"}, // to get the product with similar letters or name we have to use regex.
        });

        res.json(products);

    } catch (e) {
        res.status(500).json({error:e.message});
    }
});

// create a post request route to rate the product
productRouter.post('/api/rate-product',authMiddleware, async (req , res ) => {
    try {
        const {id,rating} = req.body;
        let product = await Product.findById(id);
        
        for(let i=0; i<product.ratings.length; i++)
        {
            if(product.ratings[i].userId == req.user) // here we get access to the id of user by req.user because of the auth middleware.
            {
                product.ratings.splice(i,1); // splice(startIndex , deleteCount) => to delete the ratings of the user that is accessing the product.
                break;
            }

        }

        const ratingSchema = {
            userId: req.user,
            rating,
        }

        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);

        // {
        //     userId: 'aaaa',
        //     rating: 2.5,
        // },
        // {
        //     userId: 'fjsdljflksdf',
        //     rating: 4,
        // }

    } catch (e) {
        res.status(500).json({error:e.message});
    }
})

module.exports = productRouter;