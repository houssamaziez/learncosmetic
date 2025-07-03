String convertToReadableDuration(String time) {
  List<String> parts = time.split(':');
  if (parts.length != 3) return "Invalid time";

  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);
  int seconds = int.parse(parts[2]);

  // Round total minutes
  int totalMinutes = (hours * 60) + minutes + (seconds >= 30 ? 1 : 0);

  int resultHours = totalMinutes ~/ 60;
  int resultMinutes = totalMinutes % 60;

  String hourPart = resultHours > 0 ? '${resultHours}h' : '';
  String minutePart = resultMinutes > 0 ? '${resultMinutes}m' : '';

  return '$hourPart ${minutePart}'.trim();
}
