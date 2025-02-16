//Flutter imports:
import 'package:flutter/material.dart';
import 'package:to_do_app/utils/k_colors.dart';
import 'package:to_do_app/utils/k_texts.dart';

enum TaskPriorityEnum { high, medium, low }

extension Extensionname on TaskPriorityEnum {
  static Map<TaskPriorityEnum, Map<String, dynamic>> types = {
    TaskPriorityEnum.high: {
      "id": 1,
      "color": kColorRed,
      "label": kTextPriorityHigh,
    },
    TaskPriorityEnum.medium: {
      "id": 2,
      "color": kColorYellow,
      "label": kTextPriorityMedium,
    },
    TaskPriorityEnum.low: {
      "id": 3,
      "color": kColorGreen,
      "label": kTextPriorityLow,
    },
  };

  int get id => types[this]!["id"] as int;
  Color get color => types[this]!["color"] as Color;
  String get label => types[this]!["label"] as String;
}
