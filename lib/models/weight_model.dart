import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class WeightModel {
  String weight;
  String id;
  Timestamp createdAt;
  WeightModel({
    required this.weight,
    required this.id,
    required this.createdAt,
  });

  String get formatDate =>
      DateFormat.yMd().format(createdAt.toDate().toLocal());
  String get formatTime => DateFormat.Hm().format(createdAt.toDate().toLocal());

  WeightModel copyWith({
    String? weight,
    String? id,
    Timestamp? createdAt,
  }) {
    return WeightModel(
      weight: weight ?? this.weight,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'id': id,
      'createdAt': createdAt,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      weight: map['weight'].toString(),
      id: map['id'].toString(),
      createdAt: map['createdAt'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightModel.fromJson(String source) =>
      WeightModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'WeightModel(weight: $weight, id: $id, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeightModel &&
        other.weight == weight &&
        other.id == id &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => weight.hashCode ^ id.hashCode ^ createdAt.hashCode;
}
