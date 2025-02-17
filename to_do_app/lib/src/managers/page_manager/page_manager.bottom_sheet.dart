part of 'page_manager.dart';

mixin PageManagerBottomSheet {
  Future openSortTaskBottomSheet({
    required TaskSortTypeEnum taskSortInit,
    Function(TaskSortTypeEnum)? onSelectedTaskSort,
  }) async {
    Widget itemTaskSort(
      TaskSortTypeEnum ascending,
      TaskSortTypeEnum descending,
      String label,
    ) {
      return GestureDetector(
        onTap: () {
          onSelectedTaskSort?.call(
            taskSortInit == descending ? ascending : descending,
          );
        },
        child: Row(
          children: [
            Visibility(
              visible: taskSortInit == ascending || taskSortInit == descending,
              replacement: const SizedBox(width: 24),
              child: Icon(
                taskSortInit == ascending
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                color: kColorPrimary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                color: kColorPrimary,
                fontSize: 14,
                fontWeight:
                    taskSortInit == ascending || taskSortInit == descending
                        ? FontWeight.w600
                        : FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    }

    return showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      useSafeArea: true,
      context: PageManager().currentContext,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                itemTaskSort(
                  TaskSortTypeEnum.oldestExpirationDate,
                  TaskSortTypeEnum.latestExpirationDate,
                  kTextExpirationDateLarge,
                ),
                const SizedBox(height: 16),
                itemTaskSort(
                  TaskSortTypeEnum.ascendingPriority,
                  TaskSortTypeEnum.descendingPriority,
                  kTextPriority,
                ),
              ],
            ),
          ),
    );
  }

  Future openFilterTaskBottomSheet({
    required FilterTaskModel filterTask,
  }) async {
    return await FilterTaskBottomSheet(
      context: PageManager().currentContext,
      filterTask: filterTask,
    ).show();
  }
}
