import 'package:json_annotation/json_annotation.dart';

part 'adventCase.g.dart';

@JsonSerializable()
class AdventCase {
  //class for an advent day incase in the future I want to be able to add pictures etc more easily
  String text;
  int day;
  bool isOpeneded;
  AdventCase({required this.text, required this.day, this.isOpeneded = false});

  factory AdventCase.fromJson(Map<String, dynamic> json) =>
      _$AdventCaseFromJson(json);

  Map<String, dynamic> toJson() => _$AdventCaseToJson(this);
}
