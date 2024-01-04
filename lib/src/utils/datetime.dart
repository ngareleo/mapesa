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
