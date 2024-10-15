DateTime getDateTimeFromMessage(
    {required String date, required String time, required bool isAM}) {
  var dateParts = date.split("/");
  var day = int.parse(dateParts.elementAt(0));
  var month = int.parse(dateParts.elementAt(1));
  var year = int.parse(dateParts.elementAt(2)) + 2000;
  var timeParts = time.split(":");
  var hour = int.parse(timeParts.elementAt(0));
  var minutes = int.parse(timeParts.elementAt(1));
  return isAM
      ? DateTime(year, month, day, hour == 12 ? 0 : hour, minutes)
      : DateTime(year, month, day, hour == 12 ? 12 : hour + 12, minutes);
}

(String, String, bool) getMessageDetailsFromDateTime(DateTime dateTime) {
  String date =
      "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${(dateTime.year % 100).toString().padLeft(2, '0')}";
  bool isAM = dateTime.hour < 12;
  int hour = dateTime.hour % 12;
  if (hour == 0) {
    hour = 12;
  }
  final time =
      "${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

  return (date, time, isAM);
}

String prettifyTimeDifference(DateTime dateTime) {
  var difference = DateTime.now().difference(dateTime);
  if (difference.inMinutes < 5) {
    return "Just now";
  } else if (difference.inHours < 1) {
    return "${difference.inMinutes} minutes ago";
  } else if (difference.inDays < 1) {
    return "${difference.inHours} hours ago";
  } else if (difference.inDays < 7) {
    return "${difference.inDays} days ago";
  } else if (difference.inDays < 30) {
    return "This month";
  } else if (difference.inDays < 365) {
    return "${difference.inDays ~/ 30} months ago";
  } else {
    return "${difference.inDays ~/ 365} years ago";
  }
}
