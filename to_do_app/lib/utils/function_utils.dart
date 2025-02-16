//Package imports:
import 'package:intl/intl.dart';

//Project imports:
import 'extensions.dart';

String getFormattedDateAndTime12H(DateTime? dateTime) {
  if (dateTime != null) {
    final DateFormat formatter = DateFormat("dd/MMM/yyyy, hh:mm a", "es");
    return formatter.format(dateTime);
  }
  return "--/---/---- --:-- -";
}

DateTime? dateTimeTryParse(String? dateTimeString) {
  if (!dateTimeString.isNullOrEmpty()) {
    return DateTime.tryParse(dateTimeString!);
  }

  return null;
}
