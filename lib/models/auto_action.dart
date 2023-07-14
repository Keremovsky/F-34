// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AutoAction {
  String id;
  String title;
  String description;
  String type;
  String subType;
  String day;
  String lastUpdate;
  double value;

  AutoAction({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.subType,
    required this.day,
    required this.lastUpdate,
    required this.value,
  });

  AutoAction copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    String? subType,
    String? day,
    String? lastUpdate,
    double? value,
  }) {
    return AutoAction(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      day: day ?? this.day,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'subType': subType,
      'day': day,
      'lastUpdate': lastUpdate,
      'value': value,
    };
  }

  factory AutoAction.fromMap(Map<String, dynamic> map) {
    return AutoAction(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      type: map['type'] as String,
      subType: map['subType'] as String,
      day: map['day'] as String,
      lastUpdate: map['lastUpdate'] as String,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AutoAction.fromJson(String source) =>
      AutoAction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AutoAction(id: $id, title: $title, description: $description, type: $type, subType: $subType, day: $day, lastUpdate: $lastUpdate, value: $value)';
  }

  @override
  bool operator ==(covariant AutoAction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.type == type &&
        other.subType == subType &&
        other.day == day &&
        other.lastUpdate == lastUpdate &&
        other.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        type.hashCode ^
        subType.hashCode ^
        day.hashCode ^
        lastUpdate.hashCode ^
        value.hashCode;
  }
}
