import 'package:flutter/material.dart';
import 'package:shopy/cart/cartScreen.dart';
import 'package:shopy/home.dart';

class BottomMenu extends StatefulWidget {

  int _selectedIndex;
  
  BottomMenu(this._selectedIndex, {super.key});

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
 

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0xFFE0CDA9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconButton(Icons.home, 0),
          _buildIconButton(Icons.search, 1),
          _buildIconButton(Icons.shopping_cart, 2),
          _buildIconButton(Icons.category, 3),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, int index) {
    bool isSelected = widget. _selectedIndex == index;
    return GestureDetector(
      onTap: () {
         switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
            break;
          case 1:
           
           /* Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchProducts(),
              ),
            );*/
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(),
              ),
            );
            break;
          case 3:
          /*  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(),
              ),
            );*/
            break;
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white : Color(0xFFE0CDA9),
        ),
        padding: EdgeInsets.all(10),
        child: Icon(
          icon,
          color: isSelected ? Color(0xFFE0CDA9) : Colors.white,
        ),
      ),
    );
  }
}