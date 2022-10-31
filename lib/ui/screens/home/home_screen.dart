import 'package:cook_recipe/core/providers/add_recipe_provider.dart';
import 'package:cook_recipe/core/providers/all_recipe_provider.dart';
import 'package:cook_recipe/ui/screens/add_recipe/add_recipe_screen.dart';
import 'package:cook_recipe/ui/screens/home/widgets/home_widget.dart';
import 'package:cook_recipe/ui/shared/widgets/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer<AllRecipeProvider>(builder: (context, AllRecipeProvider allRecipeProvider, _) {
        return Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  allRecipeProvider.setCurrentPageIndex(index);
                },
                children: const [
                  HomeWidget(),
                  Center(
                    child: Text(
                      'Nothing in Facourites!! \nPlease add to favourites',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: IconButtonWidget(
                      icon: Icons.home,
                      isSelected: allRecipeProvider.currentPageIndex == 0,
                      onTap: () {
                        _pageController.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.ease);

                        allRecipeProvider.setCurrentPageIndex(0);
                      },
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.orange,
                    onPressed: () {
                      Provider.of<AddRecipeProvider>(context, listen: false).reset();
                      Navigator.pushNamed(context, AddRecipeScreen.routeName);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: IconButtonWidget(
                      icon: Icons.favorite_outline,
                      isSelected: allRecipeProvider.currentPageIndex == 1,
                      onTap: () {
                        _pageController.animateToPage(1, duration: const Duration(milliseconds: 400), curve: Curves.ease);

                        allRecipeProvider.setCurrentPageIndex(1);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      })),
    );
  }
}
