import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('d MMMM yyyy', 'ar').format(date);
}
