import 'package:flutter/material.dart';
import 'package:shopy/menus/bottomMenu.dart';

class allCategories extends StatefulWidget {
  final List categories;

  allCategories(this.categories, {super.key});

  @override
  AllCategoriesState createState() => AllCategoriesState();
}

class AllCategoriesState extends State<allCategories> { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0CDA9),
      appBar: AppBar(
        elevation: 0,
        title: Text('Categories'),
        backgroundColor: Color(0xFFE0CDA9),
      ),
      body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                //crossAxisSpacing: 8.0,
                //mainAxisSpacing: 8.0,
                //childAspectRatio: 0.75,
              ),
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(category: widget.categories[index]);
              },
            ),
          ),
        ),
      
    );
  }
}

class CategoryCard extends StatelessWidget {
  final category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 249, 242, 230),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'http://192.168.1.98:8000/categories/${category['image']}',
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.width * 0.15,
            ),
          ),
        ),
        SizedBox(height: 4), // Add spacing between the container and the text
        Text(
          category['name'],
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
