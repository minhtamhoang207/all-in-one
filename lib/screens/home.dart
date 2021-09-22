import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:search_cubit/screens/covid_tracker.dart';
import 'package:search_cubit/screens/search_screen.dart';

import 'extended_image/slide_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  int selectedIndex = 2;
  List<Widget> listWidgets = [Search(),Search(),CovidTracker(),Search(),SlidePageDemo()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: listWidgets[selectedIndex],
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.map, title: 'Discovery'),
            TabItem(icon: Icons.search, title: 'Covid'),
            TabItem(icon: Icons.track_changes, title: 'Words'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: 2,
          backgroundColor: Colors.white,
          color: Colors.grey,
          activeColor: Colors.black.withOpacity(0.75),
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
