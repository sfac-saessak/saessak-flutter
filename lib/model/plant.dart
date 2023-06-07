
import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  String? plantId;            // 식물 식별자
  String name;                // 애칭
  String species;             // 종
  Timestamp plantingDate;     // 심은 날짜
  String optimalTemperature;  // 최적 온도
  int wateringCycle;          // 급수 주기
  String lightRequirement;    // 빛 요구도
  String? memo;               // 메모
  String? imageUrl;           // 이미지

  Plant({
    this.plantId,
    required this.name,
    required this.species,
    required this.plantingDate,
    required this.optimalTemperature,
    required this.wateringCycle,
    required this.lightRequirement,
    this.memo,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'plantId': this.plantId,
      'name': this.name,
      'species': this.species,
      'plantingDate': this.plantingDate,
      'optimalTemperature': this.optimalTemperature,
      'wateringCycle': this.wateringCycle,
      'lightRequirement': this.lightRequirement,
      'memo': this.memo,
      'imageUrl': this.imageUrl,
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      plantId: map['plantId'] as String?,
      name: map['name'] as String,
      species: map['species'] as String,
      plantingDate: map['plantingDate'] as Timestamp,
      optimalTemperature: map['optimalTemperature'] as String,
      wateringCycle: map['wateringCycle'] as int,
      lightRequirement: map['lightRequirement'] as String,
      memo: map['memo'] as String?,
      imageUrl: map['imageUrl'] as String?,
    );
  }
}
