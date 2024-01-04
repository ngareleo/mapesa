class Money {
  final double amount;
  final bool isNegative;

  const Money({required this.amount, this.isNegative = false});

  factory Money.fromString({required String message, isNegative = false}) {
    return isNegative
        ? Money(amount: -(double.parse(message.replaceAll(",", ""))))
        : Money(amount: double.parse(message.replaceAll(",", "")));
  }
  
  @override
  String toString() {
    return amount.toString();
  }
}
