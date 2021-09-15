import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:search_cubit/screens/covid_tracker.dart';
import 'package:search_cubit/screens/search_screen.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  int selectedIndex = 0;
  List<Widget> listWidgets = [Search(),Search(),Search(),CovidTracker(),Search()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: listWidgets[selectedIndex],
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.map, title: 'Discovery'),
            TabItem(icon: Icons.search, title: 'Search'),
            TabItem(icon: Icons.track_changes, title: 'Covid'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: 2,
          backgroundColor: Colors.blue.withOpacity(0.8),
          onTap: (index) => onItemTapped(index),
        )
    );
  }
  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }
}
