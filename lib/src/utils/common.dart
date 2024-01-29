import 'package:mapesa/src/types.dart';

ListOfObjects mapListOfObjects(List<dynamic> list) {
  var result = <Map<String, String>>[];
  for (var item in list) {
    if (item is Map<String, String>) {
      result.add(item);
    }
  }
  return result;
}
