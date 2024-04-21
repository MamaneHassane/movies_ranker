// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movies_ranker/pages/movies_list.dart';
import 'package:movies_ranker/pages/profile_page.dart';
import 'package:movies_ranker/pages/settings_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  // La liste des pages de l'application
  final List pages = [
    MoviesList(),
    SettingsPage(),
    ProfilePage()
  ];

  // L'index pour séléctionner une page
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    void changePage(int index) {
    setState(() {
      currentPageIndex = index;
    });
    }

    return Scaffold(
      body: pages[currentPageIndex],
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Icon(
          Icons.tv_rounded,
          color: Colors.white,
        ),
        title: Text(
          "MoviesRanker",
          style: TextStyle(
            color: Colors.white
          ),
        ), 
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.red),
            icon: Icon(Icons.home_outlined),
            label: 'Home'
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings, color: Colors.red),
            icon : Icon(Icons.settings_outlined), 
            label: 'Settings',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person, color: Colors.red),
            icon : Icon(Icons.person_outline), 
            label: 'Profile',
          )
        ],
        onDestinationSelected: (int index){
          changePage(index);
        },
        backgroundColor: Colors.white,
        indicatorColor: Colors.red.shade100,
        animationDuration: Duration(milliseconds: 2000),
        selectedIndex: currentPageIndex
      ),
    );
  }
  
  
}