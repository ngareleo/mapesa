import 'package:mapesa/src/utils/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Default constructor initializes with zero amount and isNegative false',
      () {
    final money = Money();
    expect(money.amount, 0);
  });

  test('fromString factory creates Money object and stores in cents', () {
    final money = Money.fromString(message: '12.34');
    expect(money.amount, 1234);
  });

  test(
      'fromString factory creates Money object and stores in cents from larger figures',
      () {
    final money = Money.fromString(message: '7,823,012.34');
    expect(money.amount, 782301234);
  });

  test('toString returns formatted string for little cents only', () {
    final money = Money(amount: 56);
    expect(money.toString(), '0.56');
  });

  test('toString returns formatted string for positive amount', () {
    final money = Money(amount: 123456);
    expect(money.toString(), '1,234.56');
  });
}
