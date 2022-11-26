// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adventCase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdventCase _$AdventCaseFromJson(Map<String, dynamic> json) => AdventCase(
      text: json['text'] as String,
      day: json['day'] as int,
      isOpeneded: json['isOpeneded'] as bool? ?? false,
    );

Map<String, dynamic> _$AdventCaseToJson(AdventCase instance) =>
    <String, dynamic>{
      'text': instance.text,
      'day': instance.day,
      'isOpeneded': instance.isOpeneded,
    };
