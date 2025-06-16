import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'profile_card.dart';
import 'week_calendar.dart';
import 'reservation_card.dart';
import 'service_card.dart';
import 'info_card.dart';

class Principale extends StatefulWidget {
  const Principale({super.key});

  @override
  State<Principale> createState() => _PrincipaleState();
}

class _PrincipaleState extends State<Principale> {
  int selectedDayIndex = DateTime.now().weekday - 1;

  final List<String> weekDays = ['Lun', 'Mar', 'Mer', 'Je', 'Ven', 'Sam', 'Dim'];
  final List<DateTime> thisWeekDates = List.generate(7, (index) {
    final now = DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1 - index));
  });

  Future<Map<String, dynamic>?> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return doc.data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Aucune donnée utilisateur trouvée"));
          }

          final data = snapshot.data!;
          final userEmail = data['email'] ?? '';
          final nomRestaurant = data['nomRestaurant'] ?? 'Nom non défini';
          final pseudo = data['pseudo'] ?? 'Pseudo non défini';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ProfileCard(
                  userEmail: userEmail,
                  nomRestaurant: nomRestaurant,
                  pseudo: pseudo,
                ),
                const SizedBox(height: 32),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "CALENDRIER DE LA SEMAINE",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                WeekCalendar(
                  selectedDayIndex: selectedDayIndex,
                  thisWeekDates: thisWeekDates,
                  weekDays: weekDays,
                  onDaySelected: (index) {
                    setState(() {
                      selectedDayIndex = index;
                    });
                  },
                ),
                const SizedBox(height: 32),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "TYPES DE RESERVATION",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const ReservationCard(
                    name: "RESERVATION DU MIDI",
                    detail: "2 Reservations",
                    time: "MIDI"),
                const SizedBox(height: 8),
                const ReservationCard(
                    name: "RESERVATION DU SOIR",
                    detail: "5 Reservations",
                    time: "SOIR"),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "NOMBRE DE RESERVATION PAR JOUR ET PAR SERVICE",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const ServiceCard(name: "Mr John", time: "12.00 - 16.00"),
                const SizedBox(height: 8),
                const ServiceCard(name: "Mdm Jeanne", time: "12.00 - 16.00"),
              ],
            ),
          );
        },
      ),
    );
  }
}
