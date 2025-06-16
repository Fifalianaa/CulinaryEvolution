import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:culinaryevolutionapp/pages/principale/profile_card.dart';  // Import du widget ProfileCard

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  List<Map<String, String>> _generateReservations(DateTime date) {
    String formattedDate = DateFormat('d MMMM', 'fr_FR').format(date);
    return List.generate(5, (index) {
      return {
        'date': formattedDate,
        'time': '12.00 - 16.00',
      };
    });
  }

  List<Widget> _buildCalendarDays() {
    final firstDayOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final startWeekday = firstDayOfMonth.weekday;
    final totalSlots = daysInMonth + startWeekday - 1;

    return List.generate(totalSlots, (index) {
      if (index < startWeekday - 1) {
        return Container(); // Emplacement vide
      } else {
        int day = index - startWeekday + 2;
        DateTime dayDate = DateTime(_focusedMonth.year, _focusedMonth.month, day);
        bool isSelected = _selectedDate != null &&
            _selectedDate!.day == day &&
            _selectedDate!.month == _focusedMonth.month &&
            _selectedDate!.year == _focusedMonth.year;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = dayDate;
            });
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$day',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> reservations = _generateReservations(_selectedDate!);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carte Profil avec ProfileCard (sans mini-cartes)
            ProfileCard(
              userEmail: 'africalounge@email.com',
              nomRestaurant: 'AfricaLounge',
              pseudo: 'africalounge',
              photo: null,
              showInfoCards: false, // désactive l’affichage des mini-cartes
              // voir plus bas la proposition d'ajout d'un bool pour ça
            ),

            const SizedBox(height: 24),

            // Titre
            const Text(
              "CALENDRIER",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Mois + navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
                    });
                  },
                ),
                Text(
                  DateFormat('MMMM yyyy', 'fr_FR').format(_focusedMonth).capitalize(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Jours de la semaine
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lu'),
                Text('Ma'),
                Text('Me'),
                Text('Je'),
                Text('Ve'),
                Text('Sa'),
                Text('Di'),
              ],
            ),
            const SizedBox(height: 8),

            // Grille du calendrier
            GridView.count(
              crossAxisCount: 7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: _buildCalendarDays(),
            ),
            const SizedBox(height: 24),

            // Réservations
            ...reservations.map((res) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          res['date']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          res['time']!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    return isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
  }
}
