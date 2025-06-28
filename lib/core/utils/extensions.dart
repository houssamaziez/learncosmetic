/// Extension on String for validations and formatting
extension StringExtensions on String {
  /// Capitalizes the first letter of the string
  String capitalize() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Returns true if the string is a valid email
  bool isValidEmail() {
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return regex.hasMatch(this);
  }

  /// Returns true if the string is a valid phone number (basic check)
  bool isValidPhone() {
    final regex = RegExp(r'^\+?\d{8,15}$');
    return regex.hasMatch(this);
  }

  /// Removes all spaces from the string
  String removeSpaces() {
    return replaceAll(' ', '');
  }
}

/// Extension on DateTime for formatting
// extension DateTimeExtensions on DateTime {
//   /// Formats the date as 'dd/MM/yyyy'
//   String toShortDate() {
//     return DateFormat('dd/MM/yyyy').format(this);
//   }

//   /// Formats the time as 'HH:mm'
//   String toShortTime() {
//     return DateFormat('HH:mm').format(this);
//   }

//   /// Formats the date and time as 'yyyy-MM-dd – HH:mm'
//   String toFullDateTime() {
//     return DateFormat('yyyy-MM-dd – HH:mm').format(this);
//   }
// }

/// Extension on List for safe access
extension ListExtensions<T> on List<T> {
  /// Returns the first item or null if the list is empty
  T? firstOrNull() {
    if (isEmpty) return null;
    return first;
  }

  /// Returns the last item or null if the list is empty
  T? lastOrNull() {
    if (isEmpty) return null;
    return last;
  }
}
