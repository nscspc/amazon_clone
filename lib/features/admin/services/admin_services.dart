// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/error_handling.dart';
import 'package:flutter_amazon_clone/constants/global_variables.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:flutter_amazon_clone/models/product.dart';
import 'package:flutter_amazon_clone/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    // required List<File> images,
    // required List<dynamic> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      // final cloudinary = CloudinaryPublic("dgklzqfkh", "pz6ro6ck");
      // List<String> imageUrls = [];
      // List<int> bytes = image.readAsBytesSync();
      //   var base64Image = base64Encode(bytes);
      // List<dynamic> byteDataImages = [];
      // for (int i = 0; i < images.length; i++) {
      //   byteDataImages.add(images[i].bytes.buffer.asByteData());
      //   print(images[i].bytes.buffer.asByteData());
      // }
      // for (int i = 0; i < images.length; i++) {
      //   // var bytes = images[i].readAsBytesSync();
      //   // var base64Image = base64Encode(bytes);
      //   CloudinaryResponse res = await cloudinary.uploadFile(
      //     CloudinaryFile.fromFile(images[i].path, folder: name),
      //     // folder will be created in cloudinary ji by the name of the product.
      //     // CloudinaryResponse res = await cloudinary.uploadFile(
      //     //   CloudinaryFile.fromByteData(images[i].readAsBytesSync(),
      //     //       // images[i].bytes.buffer.asByteData(),
      //     //       folder: name),
      //   );
      // if(res.s) {
//         print('Get your image from with ${res.secureUrl}');
// // }
//         print(res.secureUrl);
//         imageUrls.add(res.secureUrl);
      // }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        // images: imageUrls,
        category: category,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully !');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all the products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body); i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  // we are decoding and then encoding the res.body because fromJson() method requires String.
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
