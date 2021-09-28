import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_app/repository/weights_repository.dart';

class AuthRepository {
  AuthRepository._privateConstructor();

  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  static final AuthRepository _instance = AuthRepository._privateConstructor();

  factory AuthRepository() {
    return _instance;
  }

  bool isLoggedIn() => _firebaseAuth.currentUser != null;

  Future<void> registerWithEmail(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({'name': userCredential.user?.displayName});
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Some error occurred";
    }
  }

  Future<void> signinWithEmail(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      WeightRepository().currentuser = userCredential.user;
      await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .update({'name': userCredential.user?.displayName});
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Some error occurred";
    }
  }

  Future<void> logout() async {
    //

    await _firebaseAuth.signOut();
    WeightRepository().currentuser = null;
  }
}
