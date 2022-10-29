import 'package:cook_recipe/ui/shared/widgets/icon_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   selectedItemColor: Colors.orange,
      //   backgroundColor: Colors.orange.withOpacity(0.3),
      //   items: const [
      //     BottomNavigationBarItem(
      //       label: 'Home',
      //       icon: Icon(
      //         Icons.home,
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       label: "Favourites",
      //       icon: Icon(
      //         Icons.favorite,
      //       ),
      //     ),
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.orange,
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('recipe'),
            ),
          ),
          Container(
            height: 100,
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: IconButtonWidget(
                    icon: Icons.home,
                    isSelected: _currentIndex == 0,
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.orange,
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
                Expanded(
                  child: IconButtonWidget(
                    icon: Icons.favorite_outline,
                    isSelected: _currentIndex == 1,
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
