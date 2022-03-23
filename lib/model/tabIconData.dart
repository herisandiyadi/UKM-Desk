import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.label = '',
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;
  String label;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/tab/tab_1.png',
      selectedImagePath: 'assets/tab/tab_1s.png',
      index: 0,
      isSelected: true,
      animationController: null,
      label: 'Home',
    ),
    TabIconData(
      imagePath: 'assets/tab/tab_4.png',
      selectedImagePath: 'assets/tab/tab_4s.png',
      index: 3,
      isSelected: false,
      animationController: null,
      label: 'Profile',
    ),
    TabIconData(
      imagePath: 'assets/tab/tab_2.png',
      selectedImagePath: 'assets/tab/tab_2s.png',
      index: 1,
      isSelected: false,
      animationController: null,
      label: 'Dashboard',
    ),
    TabIconData(
      imagePath: 'assets/tab/tab_3.png',
      selectedImagePath: 'assets/tab/tab_3s.png',
      index: 2,
      isSelected: false,
      animationController: null,
      label: 'Notification',
    ),
    TabIconData(
      imagePath: 'assets/tab/tab_4.png',
      selectedImagePath: 'assets/tab/tab_4s.png',
      index: 4,
      isSelected: false,
      animationController: null,
    ),
  ];

  static List<TabIconData> tabIconsNotLogin = <TabIconData>[
    TabIconData(
      // imagePath: 'assets/tab/signup.png',
      // selectedImagePath: 'assets/tab/signup.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      index: -1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      index: -1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      index: -2,
      isSelected: false,
      animationController: null,
    ),
  ];
}
