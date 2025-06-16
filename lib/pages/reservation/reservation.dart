import 'package:flutter/material.dart';
import 'package:culinaryevolutionapp/pages/principale/profile_card.dart';  // Import du widget ProfileCard

class Reservation extends StatefulWidget {
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  int selectedDayIndex = DateTime.now().weekday - 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Utilisation de ProfileCard à la place du Card profil + info
          ProfileCard(
            userEmail: 'africalounge@email.com',
            nomRestaurant: 'AfricaLounge',
            pseudo: 'africalounge',
            photo: null, // Tu peux passer un File si tu as une image locale
          ),

          const SizedBox(height: 24),

          // Titre
          const Text(
            "RESERVATION",
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),

          const SizedBox(height: 12),
          _buildServiceCard("Mr John", "12.00 - 16.00"),
          const SizedBox(height: 12),
          _buildServiceCard("Mdm Jeanne", "12.00 - 16.00"),
          const SizedBox(height: 12),
          _buildServiceCard("Mr John", "12.00 - 16.00"),
          const SizedBox(height: 12),
          _buildServiceCard("Mdm Jeanne", "12.00 - 16.00"),
          const SizedBox(height: 12),
          _buildServiceCard("Mr John", "12.00 - 16.00"),
          const SizedBox(height: 12),
          _buildServiceCard("Mdm Jeanne", "12.00 - 16.00"),
          const SizedBox(height: 12),
          _buildServiceCard("Mr John", "12.00 - 16.00"),
          const SizedBox(height: 12),
          _buildServiceCard("Mdm Jeanne", "12.00 - 16.00"),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String name, String time) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.calendar_month, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
