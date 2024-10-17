import 'package:flutter/widgets.dart';
import 'package:isar/isar.dart';
part 'money.g.dart';

@embedded
class Money {
  final int amount; // representation in cents

  Money({
    this.amount = 0,
  });

  factory Money.fromString({required String message}) {
    final msg = message.trim().replaceAll(",", "").replaceAll(".", "");
    final amount = int.parse(msg);
    return Money(amount: amount);
  }

  @override
  String toString() {
    return amount.toString();
  }

  Widget toCash() {
    final cents = amount.abs() % 100;
    final amountStr = (amount ~/ 100).abs().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < amountStr.length; i++) {
      if (i > 0 && (amountStr.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(amountStr[i]);
    }
    return Text("Ksh ${buffer.toString()}.${cents.toString().padLeft(2, '0')}");
  }
}
