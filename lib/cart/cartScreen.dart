import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shopy/menus/bottomMenu.dart';

class Cart extends StatefulWidget {
  Cart({super.key});

  @override
  CartState createState() => CartState();
}

class CartState extends State<Cart> {
  List cartProducts = [];

  @override
  void initState() {
    super.initState();
    getProductsFromSession();
  }

  void getProductsFromSession() async {
    List cartProd = await SessionManager().get('cartProducts') ?? [];
    setState(() {
      cartProducts = cartProd;
    });
  }

  void _updateQuantity(int index, int change) {
    setState(() {
      cartProducts[index]['cart_qte'] += change;
      if (cartProducts[index]['cart_qte'] < 1) {
        cartProducts[index]['cart_qte'] = 1; // Minimum quantity is 1
      }
    });
    // Save updated cart to session
    SessionManager().set('cartProducts', jsonEncode(cartProducts));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0CDA9),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Cart'),
        backgroundColor: const Color(0xFFE0CDA9),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: cartProducts.isEmpty
              ? Center(child: Text('No products in the cart'))
              : ListView.builder(
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      
                      margin: EdgeInsets.symmetric(vertical: 5),
                      
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            // Product Image
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child:  Image.network(
                                'http://192.168.1.98:8000/products/${cartProducts[index]['principal_image']}',
                                fit: BoxFit.cover,
                              ),
                            ),
          
                            
                            SizedBox(width: 10),
                            // Product Name and Price
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartProducts[index]['name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${cartProducts[index]['price']} DH',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            // Quantity Controls
                            Container(
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFFE0CDA9),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
                              ),
                              
                              child:
                            Column(
                              
                              children: [
                                IconButton(
                                  icon: Icon(Icons.add, size: 16,),
                                  onPressed: () {
                                    _updateQuantity(index, 1);
                                  },
                                ),
                                Text(
                                  '${cartProducts[index]['cart_qte']}',
                                  style: TextStyle(fontSize: 14),
                                ),
                                IconButton(
                                  icon: Icon(Icons.remove, size: 16),
                                  onPressed: () {
                                    _updateQuantity(index, -1);
                                  },
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
        ),
      ),
      bottomNavigationBar: BottomMenu(2),
    );
  }
}
