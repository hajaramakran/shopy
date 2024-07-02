import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class ProductCard extends StatelessWidget {
  final Map product;

  const ProductCard({required this.product});

    addProductToCart(context, product) async{

    List cartProducts = await SessionManager().get('cartProducts') ?? [];
    print(cartProducts);
    bool isProductAlreadyInCart = cartProducts.any((cartProduct) {
    return cartProduct['id'] == product['id'];
    });   

    if (isProductAlreadyInCart){

      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          duration: Duration(seconds: 1),
        
        content: Text('This product is already in cart !'),
      ),
    );

    }else{ 
      product['cart_qte'] = 1;
      cartProducts.add(product);

      await SessionManager().set('cartProducts', jsonEncode(cartProducts));
     
      ScaffoldMessenger.of(context).showSnackBar(
        
         const SnackBar(
          duration: Duration(seconds: 1),

          content: Text('Product added successfuly to cart !'),
        ),

      );
    }    
  

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                'http://192.168.1.98:8000/products/${product['principal_image']}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '${product['price'].toStringAsFixed(2)} DH',
                      style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => {
                    addProductToCart(context, product)
                  },
                  child: const Icon(Icons.add_shopping_cart_outlined, color: Colors.grey)
                )
              ]
          )
          ),
        ],
      ),
    );
  }
}