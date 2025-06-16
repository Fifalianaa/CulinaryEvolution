import 'package:culinaryevolutionapp/pages/login/login.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/images/back.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Masque sombre
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.8),
            ),
          ),

          // Contenu principal
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Logo
                  Image.asset(
                    'assets/images/culinary.png',
                    width: 200,
                  ),

                  const SizedBox(height: 100),

                  // Slogan
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "L'APP PRÉFÉRÉE DES RESTAURATEURS",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Description
                  const Text(
                    "Culinary App est une application conçue par des restaurateurs avec pour un objectif clair : Vous permettre de vous concentrer sur votre passion.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),

                  // Bouton "Se connecter"
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.85,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(25),
                                ),
                                child: Container(
                                  color: Colors.white,
                                  child: const Login(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text(
                        "Se connecter",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
