import 'package:flutter_test/flutter_test.dart';
import 'package:mapesa/src/utils/datetime.dart';

void main() {
  test("getDateTimeFromMessage returns the correct DateTime for AM time", () {
    var dateTime = getDateTimeFromMessage(
      date: "01/01/22",
      time: "10:30",
      isAM: true,
    );
    expect(dateTime, DateTime(2022, 1, 1, 10, 30));
  });

  test("getDateTimeFromMessage returns the correct DateTime for PM time", () {
    var dateTime = getDateTimeFromMessage(
      date: "01/01/22",
      time: "10:30",
      isAM: false,
    );
    expect(dateTime, DateTime(2022, 1, 1, 22, 30));
  });

  test("getDateTimeFromMessage handles hour 12 correctly for AM time", () {
    var dateTime = getDateTimeFromMessage(
      date: "01/01/22",
      time: "12:30",
      isAM: true,
    );
    expect(dateTime, DateTime(2022, 1, 1, 0, 30));
  });

  test("getDateTimeFromMessage handles hour 12 correctly for PM time", () {
    var dateTime = getDateTimeFromMessage(
      date: "01/01/22",
      time: "12:30",
      isAM: false,
    );
    expect(dateTime, DateTime(2022, 1, 1, 12, 30));
  });
}
