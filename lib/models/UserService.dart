import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "user information";
  late CollectionReference _ref;
  String? firstName;
  String? lastName;
  String? address;
  String? phoneNumber;
  String? userId;
  List<String> cart = [];

  User? _cachedUser;

  UserService() {
    _ref = _fireStore.collection(_collectionName);
  }

  Future<void> getUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        _cachedUser = user;
        userId = _cachedUser!.uid;

        var document = _ref.doc(userId);
        var value = await document.get();
        var data = value.data() as Map<String, dynamic>?;

        if (data != null) {
          firstName = data["first name"] as String?;
          lastName = data["last name"] as String?;
          address = data["address"] as String?;
          phoneNumber = data["phone number"] as String?;
          cart = List<String>.from(data["cart"] ?? []);
        }
      }
    } catch (e) {
      print("Error in getUser: $e");
    }
  }
}
