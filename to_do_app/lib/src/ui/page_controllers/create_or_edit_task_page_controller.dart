//Flutter imports:
import 'package:flutter/material.dart';

//Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';

//Project imports:
import '../../../utils/function_utils.dart';
import '../../../utils/k_texts.dart';
import '../../../utils/page_args.dart';
import '../../enums/task_priority_enum.dart';
import '../../interfaces/i_page_controller.dart';
import '../../managers/data_manager.dart';
import '../../managers/page_manager.dart';
import '../../models/task_model.dart';
import '../popups/alert_popup.dart';
import '../popups/loading_popup.dart';

class CreateOrEditTaskPageController extends ControllerMVC
    implements IPageController {
  static late CreateOrEditTaskPageController _this;

  factory CreateOrEditTaskPageController() {
    _this = CreateOrEditTaskPageController._();
    return _this;
  }

  static CreateOrEditTaskPageController get con => _this;
  CreateOrEditTaskPageController._();

  PageArgs? args;

  TaskModel? initialTask;

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;
  late TextEditingController timeController;

  late FocusNode titleFocus;
  late FocusNode descriptionFocus;

  DateTime? expirationDate;
  late TaskPriorityEnum prioritySelected;

  bool titleError = false;
  bool expirationDateError = false;

  @override
  void initPage() {
    args = PageManager().currentRoute?.settings.arguments as PageArgs?;
    initialTask = args?.task;

    titleFocus = FocusNode();
    descriptionFocus = FocusNode();

    titleController = TextEditingController(text: initialTask?.title ?? '')
      ..addListener(() {
        if (titleError) {
          setState(() {
            titleError = false;
          });
        }
      });

    descriptionController = TextEditingController(
      text: initialTask?.description ?? '',
    );

    dateController = TextEditingController(
      text: initialTask?.expirationDateFormat() ?? '',
    )..addListener(() {
      if (expirationDateError) {
        setState(() {
          expirationDateError = false;
        });
      }
    });

    timeController = TextEditingController(
      text: initialTask?.expirtaionTimeFormat() ?? '',
    );

    expirationDate = initialTask?.expirationDate?.copyWith();

    prioritySelected = initialTask?.taskPriority ?? TaskPriorityEnum.low;
  }

  @override
  disposePage() {}

  @override
  onReceiveNotification(PageArgs? args) {}

  void onPopInvoked(didPop, result) {
    if (didPop) return;
    onBack();
  }

  void onBack() {
    PageManager().goBack();
  }

  void onTapButton() {
    _validateTitle();
    _validateExpirationError();

    if (titleError || expirationDateError) {
      setState(() {});
      return;
    }

    if (initialTask != null) {
      _updateTask();
      return;
    }

    _createTask();
  }

  void _validateTitle() {
    titleError = titleController.text.isEmpty;
  }

  void _validateExpirationError() {
    expirationDateError = expirationDate == null;
  }

  void _updateTask() async {
    await LoadingPopup(
      context: PageManager().currentContext,
      onLoading: DataManager().updateTask(
        TaskModel(
          uid: initialTask?.uid,
          title: titleController.text,
          description: descriptionController.text,
          expirationDate: expirationDate,
          taskPriorityId: prioritySelected.id,
        ),
      ),
      onError: (error) {
        AlertPopup(
          context: PageManager().currentContext,
          title: kTextErrorTitle,
          description: error.toString(),
        ).show();
      },
      onResult: (bool result) {
        if (result) {
          PageManager().goBack();
        }
      },
    ).show();
  }

  void _createTask() async {
    await LoadingPopup(
      context: PageManager().currentContext,
      onLoading: DataManager().createTask(
        TaskModel(
          title: titleController.text,
          description: descriptionController.text,
          expirationDate: expirationDate,
          taskPriorityId: prioritySelected.id,
        ),
      ),
      onError: (error) {
        AlertPopup(
          context: PageManager().currentContext,
          title: kTextErrorTitle,
          description: error.toString(),
        ).show();
      },
      onResult: (bool result) {
        if (result) {
          PageManager().goBack();
        }
      },
    ).show();
  }

  void onSelectHour() async {
    TimeOfDay? result = await showTimePicker(
      context: PageManager().currentContext,
      initialTime: TimeOfDay.now(),
    );

    if (result != null) {
      expirationDate = expirationDate?.copyWith(
        hour: result.hour,
        minute: result.minute,
      );
      dateController.text = getFormattedDate(expirationDate);
      timeController.text = getFormattedTime(expirationDate);
      setState(() {});
    }
  }

  void onSelectDay() async {
    DateTime? result = await showDatePicker(
      context: PageManager().currentContext,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 1000)),
      locale: const Locale("es"),
    );

    if (result != null) {
      expirationDate = result.copyWith(hour: 0, minute: 0);
      dateController.text = getFormattedDate(expirationDate);
      timeController.text = getFormattedTime(expirationDate);
      setState(() {});
    }
  }

  void onSelectPriority(TaskPriorityEnum newValue) {
    setState(() {
      prioritySelected = newValue;
    });
  }
}
