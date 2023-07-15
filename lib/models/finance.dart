// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Finance {
  final String id;
  final String title;
  final String description;
  final String type;
  final String subType;
  final String date;
  final double value;

  Finance({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.subType,
    required this.date,
    required this.value,
  });

  Finance copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    String? subType,
    String? date,
    double? value,
  }) {
    return Finance(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      date: date ?? this.date,
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
      'date': date,
      'value': value,
    };
  }

  factory Finance.fromMap(Map<String, dynamic> map) {
    return Finance(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      type: map['type'] as String,
      subType: map['subType'] as String,
      date: map['date'] as String,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Finance.fromJson(String source) =>
      Finance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Finance(id: $id, title: $title, description: $description, type: $type, subType: $subType, date: $date, value: $value)';
  }

  @override
  bool operator ==(covariant Finance other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.type == type &&
        other.subType == subType &&
        other.date == date &&
        other.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        type.hashCode ^
        subType.hashCode ^
        date.hashCode ^
        value.hashCode;
  }
}
