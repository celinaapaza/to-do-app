//Flutter imports:
import 'package:flutter/material.dart';

//Project imports:
import '../../enums/task_priority_enum.dart';
import '../../enums/task_status_enum.dart';
import '../../../utils/k_texts.dart';
import '../../../utils/k_colors.dart';
import '../../models/filter_task_model.dart';
import '../../providers/theme_data_provider.dart';

class FilterTaskBottomSheet {
  final BuildContext context;
  final FilterTaskModel filterTask;

  const FilterTaskBottomSheet({
    required this.context,
    required this.filterTask,
  });

  Future<void> show() {
    return showModalBottomSheet<void>(
      isDismissible: true,
      enableDrag: true,
      useSafeArea: true,
      context: context,
      backgroundColor:
          ThemeDataProvider().darkMode
              ? kColorBackgroundDark
              : kColorBackgroundLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder:
          (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: _FilterTaskBottomSheetBody(filterTask: filterTask),
          ),
    );
  }
}

class _FilterTaskBottomSheetBody extends StatefulWidget {
  final FilterTaskModel filterTask;

  const _FilterTaskBottomSheetBody({required this.filterTask});

  @override
  State<_FilterTaskBottomSheetBody> createState() =>
      _FilterTaskBottomSheetBodyState();
}

class _FilterTaskBottomSheetBodyState
    extends State<_FilterTaskBottomSheetBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(kTextStatus, style: Theme.of(context).textTheme.titleSmall),
        ..._listStatusFilter(),
        const SizedBox(height: 10),
        Text(kTextPriority, style: Theme.of(context).textTheme.titleSmall),
        ..._listPrioritiesFilter(),
      ],
    );
  }

  List<Widget> _listStatusFilter() {
    return List.generate(
      TaskStatusEnum.values.length,
      (index) => _item(
        widget.filterTask.taskStatusSelected.contains(
          TaskStatusEnum.values[index],
        ),
        TaskStatusEnum.values[index].label,
        (bool newValue) {
          setState(() {
            widget.filterTask.taskStatusSelected.remove(
              TaskStatusEnum.values[index],
            );

            if (newValue) {
              widget.filterTask.taskStatusSelected.add(
                TaskStatusEnum.values[index],
              );
            }
          });
        },
      ),
    );
  }

  List<Widget> _listPrioritiesFilter() {
    return List.generate(
      TaskPriorityEnum.values.length,
      (index) => _item(
        widget.filterTask.taskPrioritiesSelected.contains(
          TaskPriorityEnum.values[index],
        ),
        TaskPriorityEnum.values[index].label,
        (bool newValue) {
          setState(() {
            widget.filterTask.taskPrioritiesSelected.remove(
              TaskPriorityEnum.values[index],
            );

            if (newValue) {
              widget.filterTask.taskPrioritiesSelected.add(
                TaskPriorityEnum.values[index],
              );
            }
          });
        },
      ),
    );
  }

  Widget _item(bool isSelected, String label, Function(bool) onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: isSelected,
          onChanged: (newValue) {
            onTap(newValue ?? false);
          },
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
