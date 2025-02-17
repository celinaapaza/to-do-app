//Flutter imports:
import 'package:flutter/material.dart';

//Package imports:
import 'package:mvc_pattern/mvc_pattern.dart';

//Project imports:
import '../../../utils/k_colors.dart';
import '../../../utils/k_texts.dart';
import '../../enums/task_priority_enum.dart';
import '../components/custom_button_component.dart';
import '../components/text_field_component.dart';
import '../page_controllers/create_or_edit_task_page_controller.dart';

class CreateOrEditTaskPage extends StatefulWidget {
  const CreateOrEditTaskPage({super.key});

  @override
  CreateOrEditTaskPageState createState() => CreateOrEditTaskPageState();
}

class CreateOrEditTaskPageState extends StateMVC<CreateOrEditTaskPage> {
  late CreateOrEditTaskPageController _con;

  CreateOrEditTaskPageState() : super(CreateOrEditTaskPageController()) {
    _con = CreateOrEditTaskPageController.con;
  }

  @override
  void initState() {
    _con.initPage();
    super.initState();
  }

  @override
  void dispose() {
    _con.disposePage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: _con.onPopInvoked,
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: _appBar(),
          body: _body(),
          bottomNavigationBar: _footer(),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        _con.initialTask != null ? kTextEdit : kTextCreate,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: true,
      leading: GestureDetector(
        onTap: _con.onBack,
        child: const Icon(Icons.arrow_back_ios),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            TextFieldComponent(
              controller: _con.titleController,
              focusNode: _con.titleFocus,
              hintText: kTextTitle,
              error: _con.titleError,
              labelError: kTextRequiredField,
              onTapOutside: (_) {
                if (_con.titleFocus.hasFocus) {
                  _con.titleFocus.unfocus();
                }
              },
            ),
            const SizedBox(height: 20),
            TextFieldComponent(
              controller: _con.descriptionController,
              focusNode: _con.descriptionFocus,
              hintText: kTextDescription,
              onTapOutside: (_) {
                if (_con.descriptionFocus.hasFocus) {
                  _con.descriptionFocus.unfocus();
                }
              },
              minLines: 3,
              maxLines: 8,
              textAlignVertical: TextAlignVertical.top,
              alignLabelWithHint: true,
              textType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFieldComponent(
                    controller: _con.dateController,
                    hintText: kTextDate,
                    readOnly: true,
                    error: _con.expirationDateError,
                    labelError: kTextRequiredField,
                    onTap: _con.onSelectDay,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFieldComponent(
                    controller: _con.timeController,
                    hintText: kTextTime,
                    readOnly: true,
                    enabled: _con.dateController.text.isNotEmpty,
                    error: _con.expirationDateError,
                    labelError: "",
                    onTap: _con.onSelectHour,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              kTextPriority,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.start,
            ),
            ..._listPrioritiesTypes(),
          ],
        ),
      ),
    );
  }

  List<Widget> _listPrioritiesTypes() {
    return List.generate(
      TaskPriorityEnum.values.length,
      (index) => Row(
        children: [
          Radio(
            value: TaskPriorityEnum.values[index],
            groupValue: _con.prioritySelected,
            fillColor: WidgetStatePropertyAll(
              TaskPriorityEnum.values[index].color,
            ),
            onChanged:
                (_) => _con.onSelectPriority(TaskPriorityEnum.values[index]),
          ),
          Text(
            TaskPriorityEnum.values[index].label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: customButtonComponent(
        context,
        _con.initialTask != null ? kTextSaveChanges : kTextCreateTask,
        Icons.save,
        kColorPrimary,
        _con.onTapButton,
      ),
    );
  }
}
