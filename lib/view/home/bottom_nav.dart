import 'package:carmarket/view/constants/styles/colors.dart';
import 'package:carmarket/view/chat/screen_chats.dart';
import 'package:carmarket/view/home/screen_home.dart';
import 'package:carmarket/view/settings/screen_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../bookings/screen_bookings.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentSelectedIndex = 0;
  bool fab = false;

  final _pages = [
    const ScreenHome(),
    const Bookings(),
    Inbox(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentSelectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentSelectedIndex,
        onTap: (newIndex) => setState(() => _currentSelectedIndex = newIndex),
        selectedItemColor: kWhite,
        unselectedItemColor: kGrey,
        items: [
          //<<<Home>>>//
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.house),
            activeIcon: const Icon(CupertinoIcons.house_alt_fill),
            title: Text("Home", style: GoogleFonts.philosopher()),
          ),

          //<<<Orders>>>//
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.checkmark_seal),
            activeIcon: const Icon(CupertinoIcons.checkmark_seal_fill),
            title: Text("Bookings", style: GoogleFonts.philosopher()),
          ),

          //<<<Inbox>>>//
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.chat_bubble_text),
            activeIcon: const Icon(CupertinoIcons.chat_bubble_text_fill),
            title: Text("Inbox", style: GoogleFonts.philosopher()),
          ),

          //<<<Profile>>>//
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.gear_alt),
            activeIcon: const Icon(CupertinoIcons.gear_alt_fill),
            title: Text("Settings", style: GoogleFonts.philosopher()),
          ),
        ],
      ),
    );
  }
}
