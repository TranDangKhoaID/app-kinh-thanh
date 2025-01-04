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

  factory BibleModel.fromJson(Map<String, dynamic> json) =>
      _$BibleModelFromJson(json);
  Map<String, dynamic> toJson() => _$BibleModelToJson(this);
}
