import 'package:flutter/material.dart';
import 'package:culinaryevolutionapp/services/auth_service.dart';

import 'calendar/calendar.dart';
import 'chat/chat.dart';
import 'principale/principale.dart';
import 'reservation/reservation.dart';
import 'formulaire_overlay.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;
  bool showFormulaireOverlay = true;

  final List<Widget> _pages = [
     Principale(),
     Reservation(),
     Calendar(),
     Chat(),
  ];

  final List<String> _titles = [
    'Accueil',
    'Réservation',
    'Calendrier',
    'Chat',
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.book,
    Icons.calendar_today,
    Icons.chat,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              await AuthService().signout(context: context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          AbsorbPointer(
            absorbing: showFormulaireOverlay,
            child: _pages[_currentIndex],
          ),
          if (showFormulaireOverlay)
            FormulaireOverlay(onValider: () {
              setState(() {
                showFormulaireOverlay = false;
              });
            }),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_icons.length, (index) {
            final isSelected = index == _currentIndex;
            return GestureDetector(
              onTap: () => setState(() => _currentIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.orange : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _icons[index],
                  color: isSelected ? Colors.white : Colors.grey,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
