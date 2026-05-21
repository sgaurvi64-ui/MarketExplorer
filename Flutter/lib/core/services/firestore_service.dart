import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserProfile(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).set(data, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).get();
    return snapshot.data();
  }

  Future<bool> isUserIdAvailable(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .where('user_id', isEqualTo: userId)
        .limit(1)
        .get();
    return snapshot.docs.isEmpty;
  }
}
