// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Advent _$AdventFromJson(Map<String, dynamic> json) => Advent(
      adventCases: (json['adventCases'] as List<dynamic>)
          .map((e) => AdventCase.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String,
      fromWho: json['fromWho'] as String,
    );

Map<String, dynamic> _$AdventToJson(Advent instance) => <String, dynamic>{
      'title': instance.title,
      'fromWho': instance.fromWho,
      'adventCases': instance.adventCases,
    };
