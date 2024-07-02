import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  final List categories;

  CategoriesList({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width*0.25, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length > 10 ? 11 : categories.length,
        itemBuilder: (context, index) {
          if (index == 10 && categories.length > 10) {
            return SeeAllButton();
          } else {
            return CategoryCard(category: categories[index]);
          }
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.25, // Adjust width as needed
     

      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
       
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 250, 250),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network( 
              'http://192.168.1.98:8000/categories/${category['image']}',
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.width*0.15,
              //width: 120,
            ),
          ),
          //SizedBox(height: 8),
          Text(
            category['name'],
            style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SeeAllButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to a new page or show all categories
      },
      child: Container(
        width: 120, // Adjust width as needed
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'See All',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
