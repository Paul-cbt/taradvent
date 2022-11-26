import 'package:taradvent/models/adventCase.dart';
import 'package:json_annotation/json_annotation.dart';

part 'advent.g.dart';

@JsonSerializable()
class Advent {
  String title;
  String fromWho;
  List<AdventCase> adventCases;
  Advent(
      {required this.adventCases, required this.title, required this.fromWho});

  factory Advent.fromJson(Map<String, dynamic> json) => _$AdventFromJson(json);

  Map<String, dynamic> toJson() => _$AdventToJson(this);
}
