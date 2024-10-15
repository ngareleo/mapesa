import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mapesa/src/utils/datetime.dart';
import 'package:mapesa/src/utils/money.dart';

import '../theme.dart';

List<TextSpan> commonRichDateTimeComponents(DateTime dateTime) {
  final (d, t, isAM) = getMessageDetailsFromDateTime(dateTime);
  return [
    const TextSpan(text: " on "),
    TextSpan(text: d, style: styledTransactionTextStyle),
    const TextSpan(text: " at "),
    TextSpan(
        text: "$t ${isAM ? "AM" : "PM"}", style: styledTransactionTextStyle)
  ];
}

List<TextSpan> commonRichBalanceComponent(Money balance) {
  return [
    const TextSpan(text: " New M-PESA balance is "),
    TextSpan(
        text: "Ksh ${balance.amount.toString()}",
        style: styledTransactionTextStyle)
  ];
}

List<TextSpan> commonTransactionCostComponent(Money cost) {
  return [
    const TextSpan(text: ". Transaction cost, "),
    TextSpan(
        text: "Ksh ${cost.amount.toString()}",
        style: styledTransactionTextStyle)
  ];
}
