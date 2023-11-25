import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class BankRequestItem extends StatelessWidget {
  final String status;
  final String createdAt;
  final String updatedAt;
  final Float creditAmount;
  final int creditPeriod;
  final Float paymentPerMonth;
  final Float pureAmount;
  final Float course;
  final String pureCurrencyName;


  const BankRequestItem({
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.course,
    required this.creditAmount,
    required this.creditPeriod,
    required this.paymentPerMonth,
    required this.pureAmount,
    required this.pureCurrencyName,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
