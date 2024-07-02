import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopy/categories/catList.dart';
import 'package:shopy/categories/catScreen.dart';
import 'package:shopy/menus/bottomMenu.dart';
import 'package:shopy/products/productCard.dart';

import 'constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List categories = [];
  List products = [];

  @override
  void initState() {
    super.initState();
    getCategories();
    getProducts();
  }

  void getCategories() async {
    final response = await http.get(Uri.parse('$apiDomain/categories'));

    if (response.statusCode == 200) {
      List cats = jsonDecode(response.body);
      setState(() {
        categories = cats;
      });
      print(categories);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  void getProducts() async {
    final response = await http.get(Uri.parse('$apiDomain/products'));

    if (response.statusCode == 200) {
      List prods = jsonDecode(response.body);
      setState(() {
        products = prods;
      });
      print(products);
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: ListView(
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo on the right
                Image.asset(
                  'assets/shopy_logo.png',
                  height: 100,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the SearchPage
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );*/
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8),
                          const Text(
                            'Search...',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Categories', style: TextStyle(fontWeight: FontWeight.w800),),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => allCategories(categories)),
                        )
                      },
                      child: const Text('See all >'),
                    )
                  ],
                ),
            ),
            const SizedBox(height: 16),
            // Horizontal scroll list of categories
            if (categories.isNotEmpty) CategoriesList(categories: categories),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
                child: Text('Best Selling \nOutfits',
                  style: TextStyle(
                    fontSize: 24, // size of the text
                    fontWeight: FontWeight.bold, // makes the text bold
                    color: Color.fromARGB(255, 0, 0, 0), // sets the text color
                    letterSpacing: 1.5, // adds spacing between letters
                    wordSpacing: 2.0, // adds spacing between words
                  
                  ),
                )
            ),
            if (products.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //height: 400, // Set a fixed height for the GridView
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(0),
    );
  }
}
