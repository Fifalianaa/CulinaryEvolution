import 'dart:io';
import 'package:flutter/material.dart';
import 'info_card.dart';

class ProfileCard extends StatelessWidget {
  final String userEmail;
  final String nomRestaurant;
  final String pseudo;
  final File? photo;
  final bool showInfoCards;  // Nouvel attribut optionnel

  const ProfileCard({
    Key? key,
    required this.userEmail,
    required this.nomRestaurant,
    required this.pseudo,
    this.photo,
    this.showInfoCards = true, // Affiche par défaut les mini-cartes
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: photo != null
                      ? FileImage(photo!)
                      : const AssetImage('assets/images/users.jpeg') as ImageProvider,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nomRestaurant,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Pseudo: $pseudo', style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text(userEmail, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
            if (showInfoCards) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  InfoCard(title: "Réservation", count: "10"),
                  InfoCard(title: "Pré-auto", count: "15"),
                  InfoCard(title: "Places libres", count: "20"),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
