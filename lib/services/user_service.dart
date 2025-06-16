import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static Future<void> saveUserProfile({
    required String pseudo,
    required String nomRestaurant,
    required String token,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("Utilisateur non connecté");

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'email': user.email,
      'pseudo': pseudo.trim(),
      'nomRestaurant': nomRestaurant.trim(),
      'tokenInscription': token.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
