import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:to_do_app/utils/function_utils.dart';

void main() async {
  await initializeDateFormatting('es', null);
  test('Formatear hora de un datetime', () {
    expect(getFormattedTime(DateTime(2025, 01, 30, 20, 40)), "08:40 p. m.");
  });
}
