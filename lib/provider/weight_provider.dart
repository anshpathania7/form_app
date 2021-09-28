import 'package:flutter/foundation.dart';
import 'package:form_app/models/weight_model.dart';
import 'package:form_app/repository/weights_repository.dart';

class WeightProvider extends ChangeNotifier {
  //
  bool isLoading;
  bool loadedSuccessfully;
  List<WeightModel> allWeightEntries;
  final WeightRepository _weightRepository = WeightRepository();

  WeightProvider()
      : isLoading = true,
        loadedSuccessfully = false,
        allWeightEntries = List.empty(growable: true);

  set _updateLoadingStatus(bool v) {
    isLoading = v;
    notifyListeners();
  }

  set _updateSuccessState(bool v) {
    loadedSuccessfully = v;
    notifyListeners();
  }

  void loadAllWeightEntries() async {
    _updateLoadingStatus = true;
    try {
      allWeightEntries = await _weightRepository.getAllWeightEntries();
      _updateSuccessState = true;
    } catch (e) {
      _updateSuccessState = false;
    } finally {
      _updateLoadingStatus = false;
      notifyListeners();
    }
  }

//
  Future<void> updateWeight(
      {required String weight, required String id}) async {
    if (weight.isEmpty) return;
    await _weightRepository.updateWeightEntry(weightId: id, weight: weight);
    allWeightEntries = await _weightRepository.getAllWeightEntries();
    notifyListeners();
  }

  Future<void> addWeight({required String weight}) async {
    if (weight.isEmpty) return;
    await _weightRepository.addWeightEntry(weight: weight);
    allWeightEntries = await _weightRepository.getAllWeightEntries();
    notifyListeners();
  }

  Future<void> deleteWeight({required String id}) async {
    await _weightRepository.deleteWeightEntry(weightId: id);
    allWeightEntries = await _weightRepository.getAllWeightEntries();
    notifyListeners();
  }
//
}
