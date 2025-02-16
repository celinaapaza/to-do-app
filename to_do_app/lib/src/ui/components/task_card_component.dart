//Flutter imports:
import 'package:flutter/material.dart';

//Package imports:
import 'package:provider/provider.dart';

//Project imports:
import '../../../utils/function_utils.dart';
import '../../../utils/k_colors.dart';
import '../../../utils/k_texts.dart';
import '../../enums/task_priority_enum.dart';
import '../../providers/theme_data_provider.dart';

class TaskCardComponent extends StatefulWidget {
  final String? title;
  final String? description;
  final DateTime? expirationDate;
  final bool isCompleted;
  final TaskPriorityEnum? taskPriority;
  final Function(bool)? onTapCheckBox;

  const TaskCardComponent({
    this.title,
    this.description,
    this.expirationDate,
    this.isCompleted = false,
    this.taskPriority,
    this.onTapCheckBox,
    super.key,
  });

  @override
  State<TaskCardComponent> createState() => _TaskCardComponentState();
}

class _TaskCardComponentState extends State<TaskCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            context.watch<ThemeDataProvider>().darkMode
                ? kColorBackgroundDark
                : kColorBackgroundLight,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: widget.taskPriority?.color ?? kColorGreen,
          width: 5,
        ),
        boxShadow: [
          BoxShadow(
            color:
                context.watch<ThemeDataProvider>().darkMode
                    ? kColorShadowDark
                    : kColorBackgroundDarkWithOpacity,
            spreadRadius: 0,
            blurRadius: 10,
            blurStyle: BlurStyle.solid,
            offset: Offset(0, 0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getEmoji(),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "$kTextDescription: ",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: widget.description ?? '-',

                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "$kTextExpirationDateShort: ",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: getFormattedDateAndTime12H(widget.expirationDate),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Checkbox(
            value: widget.isCompleted,
            onChanged: (value) {
              widget.onTapCheckBox?.call(value ?? !widget.isCompleted);
            },
          ),
        ],
      ),
    );
  }

  Widget _getEmoji() {
    return Icon(_getEmojiIconData(), color: _getEmojiColor(), size: 30);
  }

  IconData _getEmojiIconData() {
    if (widget.isCompleted == true) {
      return Icons.sentiment_very_satisfied_outlined;
    }

    if (widget.expirationDate?.isBefore(DateTime.now()) ?? false) {
      return Icons.sentiment_very_dissatisfied_outlined;
    }

    return Icons.sentiment_neutral_outlined;
  }

  Color _getEmojiColor() {
    if (widget.isCompleted == true) {
      return kColorGreen;
    }

    if (widget.expirationDate?.isBefore(DateTime.now()) ?? false) {
      return kColorRed;
    }

    return kColorYellow;
  }
}
