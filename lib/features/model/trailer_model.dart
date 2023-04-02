import 'package:equatable/equatable.dart';

class Trailar extends Equatable {
  final String name;
  final String key;

  const Trailar({required this.name, required this.key});

  factory Trailar.fromJson(Map<String, dynamic> json) {
    return Trailar(
      name: json['name'],
      key: json['key'],
    );
  }
  @override
  List<Object?> get props => [name, key];
}
