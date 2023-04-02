// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
class Genres  extends Equatable {
  final int id;
  final String name;
  bool isChecked ;

  Genres({required this.id, required this.name,this.isChecked =false});

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json['id'],
      name: json['name'],
    );
  }
  
  @override
  List<Object?> get props => [id,name];

}
