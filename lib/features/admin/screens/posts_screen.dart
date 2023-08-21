import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/screens/add_product_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  // List<Product>?
  //     products; // we have used ? , so that we can check that if products list == null , means that the user has not added any product to be shown, and if products is empty(products.isEmpty()) , which means that the fetched products list will be equal to [].
  // final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    // initState() function can never be async.
    super.initState();
    // fetchAllProducts();
  }

  // fetchAllProducts() async {
  //   products = await adminServices.fetchAllProducts(context);
  //   setState(() {});
  // }

  // void deleteProduct(Product product, int index) {
  //   adminServices.deleteProduct(
  //     context: context,
  //     product: product,
  //     onSuccess: () {
  //       products!.removeAt(index);
  //       setState(() {});
  //     },
  //   );
  // }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return
        // products == null
        //     ? const Loader()
        // :
        Scaffold(
      body: Text(""),
      //  GridView.builder(
      //   itemCount: 4, //products!.length,
      //   gridDelegate:
      //       const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      //   itemBuilder: (context, index) {
      //     // final productData = products![index];
      //     return Column(
      //       children: [
      //         SizedBox(
      //           height: 140,
      //           child: SingleProduct(
      //             image: productData.images[0],
      //           ),
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             Expanded(
      //               child: Text(
      //                 productData.name,
      //                 overflow: TextOverflow.ellipsis,
      //                 maxLines: 2,
      //               ),
      //             ),
      //             IconButton(
      //               onPressed: () {}, //deleteProduct(productData, index),
      //               icon: const Icon(
      //                 Icons.delete_outline,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip:
            'Add a Product', // it will appear when user is going to hover or long press on the floatingActionButton.
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
