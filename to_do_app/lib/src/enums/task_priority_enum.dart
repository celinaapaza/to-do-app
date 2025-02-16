//Flutter imports:
import 'package:flutter/material.dart';
import 'package:to_do_app/utils/k_colors.dart';

enum TaskPriorityEnum { high, medium, low }

extension Extensionname on TaskPriorityEnum {
  static Map<TaskPriorityEnum, Map<String, dynamic>> types = {
    TaskPriorityEnum.high: {"id": 1, "color": kColorRed},
    TaskPriorityEnum.medium: {"id": 2, "color": kColorYellow},
    TaskPriorityEnum.low: {"id": 3, "color": kColorGreen},
  };

  int get id => types[this]!["id"] as int;
  Color get color => types[this]!["color"] as Color;
}
