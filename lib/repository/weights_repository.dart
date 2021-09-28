//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_app/models/weight_model.dart';

class WeightRepository {
  WeightRepository._privateConstructor();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentuser = FirebaseAuth.instance.currentUser;

  static final WeightRepository _instance =
      WeightRepository._privateConstructor();

  factory WeightRepository() {
    return _instance;
  }

  Future<void> updateWeightEntry(
      {required String weightId, required String weight}) async {
    await _firestore
        .collection('users')
        .doc(currentuser?.uid)
        .collection('weightEntries')
        .doc(weightId)
        .update({
      'weight': weight,
    });
  }

  Future<void> deleteWeightEntry({required String weightId}) async {
    await _firestore
        .collection('users')
        .doc(currentuser?.uid)
        .collection('weightEntries')
        .doc(weightId)
        .delete();
  }

  //
  Future<void> addWeightEntry({required String weight}) async {
    await _firestore
        .collection('users')
        .doc(currentuser?.uid)
        .collection('weightEntries')
        .add({
      'weight': weight,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<WeightModel>> getAllWeightEntries() async {
    final snapshots = await _firestore
        .collection('users')
        .doc(currentuser?.uid)
        .collection('weightEntries')
        .orderBy('createdAt', descending: true)
        .get(
          const GetOptions(source: Source.server),
        );
    final allWeightList = List<WeightModel>.from(
      snapshots.docs.map(
        (e) => WeightModel.fromMap(
          e.data()
            ..addAll(
              {
                'id': e.id,
              },
            ),
        ),
      ),
    );
    return allWeightList;
  }
}
