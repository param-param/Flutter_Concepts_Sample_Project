import 'package:flutter/material.dart';
import 'package:flutter_concepts/extensions/color_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_concepts/screens/categories.dart';
import 'package:flutter_concepts/screens/filters.dart';
import 'package:flutter_concepts/screens/meals.dart';
import 'package:flutter_concepts/widgets/main_drawer.dart';
import 'package:flutter_concepts/providers/favorites_provider.dart';
import 'package:flutter_concepts/providers/filters_provider.dart';

import '../extensions/font_extension.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          activePageTitle,
          /*

           This way you can change customize the already defined theme according to your
           requirement without changing the actual theme.

          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FW.extraBold
          ),

          */
          style: Theme.of(context).textTheme.displayLarge,
        ),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                /*

                 The following code line accesses the text color specifically designated for the primary color in the color scheme

                 Theme.of(context).colorScheme.onPrimary

                 ---------------------------------------------->

                 The following code line accesses the text color recommended for use on top of the primary color in the overall theme,
                 which may or may not align with the color scheme's primary color

                 Theme.of(context).onPrimary

          */

                Theme.of(context).colorScheme.primary.withOpacity(1.0),
                Theme.of(context).colorScheme.primary.withOpacity(0.7)
              ], // Define your gradient colors
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        // Customize selected item color
        unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
        // Customize unselected item color
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
