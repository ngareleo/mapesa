import 'package:isar/isar.dart';
part 'money.g.dart';

@embedded
class Money {
  // change representation to cents
  final int amount;
  final bool isNegative;

  Money({this.amount = 0, this.isNegative = false});

  factory Money.fromString({required String message, isNegative = false}) {
    var msg = message.trim().replaceAll(",", "").replaceAll(".", "");
    var amount = int.parse(msg);
    return isNegative ? Money(amount: -amount) : Money(amount: amount);
  }

  @override
  String toString() {
    return amount.toString();
  }
}
