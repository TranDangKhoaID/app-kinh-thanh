import 'package:json_annotation/json_annotation.dart';

part 'bible_model.g.dart';

@JsonSerializable()
class BibleModel {
  int? id;
  String? title;
  String? bible;
  String? original;
  String? thought;
  String? pray;
  String? end;
  String? audio;
  DateTime? dateTime;

  BibleModel({
    this.id,
    this.title,
    this.bible,
    this.original,
    this.thought,
    this.pray,
    this.end,
    this.audio,
    this.dateTime,
  });

  BibleModel copyWith({
    int? id,
    String? title,
    String? bible,
    String? original,
    String? thought,
    String? pray,
    String? end,
    String? audio,
    DateTime? dateTime,
  }) =>
      BibleModel(
        id: id ?? this.id,
        title: title ?? this.title,
        bible: bible ?? this.bible,
        original: original ?? this.original,
        thought: thought ?? this.thought,
        pray: pray ?? this.pray,
        end: end ?? this.end,
        audio: audio ?? this.audio,
        dateTime: dateTime ?? this.dateTime,
      );

  factory BibleModel.fromJson(Map<String, dynamic> json) =>
      _$BibleModelFromJson(json);
  Map<String, dynamic> toJson() => _$BibleModelToJson(this);
}
