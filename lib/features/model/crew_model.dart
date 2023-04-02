

import 'package:equatable/equatable.dart';

class CrewModel extends Equatable {
  final String department;
  final String name;
  final String profilePath;

  const CrewModel(
      {required this.department,
      required this.name,
      required this.profilePath});

  factory CrewModel.fromJson(Map<String, dynamic> json) {
    return CrewModel(
      department: json['known_for_department'],
      name: json['name'],
      profilePath: json['profile_path'] ?? '',
    );
  }
  
  @override

  List<Object?> get props => [department,name,profilePath];

}
