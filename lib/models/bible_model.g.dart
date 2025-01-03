// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BibleModel _$BibleModelFromJson(Map<String, dynamic> json) => BibleModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      bible: json['bible'] as String?,
      original: json['original'] as String?,
      thought: json['thought'] as String?,
      pray: json['pray'] as String?,
      end: json['end'] as String?,
      audio: json['audio'] as String?,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$BibleModelToJson(BibleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'bible': instance.bible,
      'original': instance.original,
      'thought': instance.thought,
      'pray': instance.pray,
      'end': instance.end,
      'audio': instance.audio,
      'dateTime': instance.dateTime?.toIso8601String(),
    };
