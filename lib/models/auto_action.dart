// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AutoAction {
  String day;
  String lastUpdate;
  double value;

  AutoAction({
    required this.day,
    required this.lastUpdate,
    required this.value,
  });

  AutoAction copyWith({
    String? day,
    String? lastUpdate,
    double? value,
  }) {
    return AutoAction(
      day: day ?? this.day,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'lastUpdate': lastUpdate,
      'value': value,
    };
  }

  factory AutoAction.fromMap(Map<String, dynamic> map) {
    return AutoAction(
      day: map['day'] as String,
      lastUpdate: map['lastUpdate'] as String,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AutoAction.fromJson(String source) =>
      AutoAction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AutoAction(day: $day, lastUpdate: $lastUpdate, value: $value)';

  @override
  bool operator ==(covariant AutoAction other) {
    if (identical(this, other)) return true;

    return other.day == day &&
        other.lastUpdate == lastUpdate &&
        other.value == value;
  }

  @override
  int get hashCode => day.hashCode ^ lastUpdate.hashCode ^ value.hashCode;
}
