//Package imports:
import 'package:collection/collection.dart';

enum PageNames { init, home, taskDetail, creatOrEditTask }

extension PageNamesExtension on String? {
  PageNames? get pageNameEnum =>
      PageNames.values.firstWhereOrNull((page) => page.name == this);
}
