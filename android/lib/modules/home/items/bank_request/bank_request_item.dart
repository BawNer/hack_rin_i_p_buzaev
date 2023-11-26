import 'package:centr_invest_app/core/ui/padding.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BankRequestItem extends StatelessWidget {
  final int id;
  final String status;
  final String createdAt;
  final String updatedAt;
  final double creditAmount;
  final int creditPeriod;
  final double paymentPerMonth;
  final double pureAmount;
  final double course;
  final String pureCurrencyName;

  static const Map<String, String> _statusDescription = {
    "ACCEPTED": "Одобрена",
    "DECLINE": "Отклонена",
    "PROCESS": "В процессе",
    "NEED_OPERATOR": "Ожидание оператора"
  };

  const BankRequestItem(
      {required this.id,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.course,
      required this.creditAmount,
      required this.creditPeriod,
      required this.paymentPerMonth,
      required this.pureAmount,
      required this.pureCurrencyName,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: insets(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 1)),
        ],
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${tr("order")}: $id',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${tr("last_update")}: $updatedAt',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Text(_statusDescription[status]!,
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 8,
            ),
            Text(
                '${tr("amount")}: ${NumberFormat.simpleCurrency(name: pureCurrencyName, decimalDigits: 2).format(pureAmount)}'),
            const SizedBox(
              height: 4,
            ),
            Text('${tr("period")}: $creditPeriod ${tr("months")}'),
            const SizedBox(
              height: 4,
            ),
            Text(
                '${tr("payment_per_month")}: ${NumberFormat.simpleCurrency(name: pureCurrencyName, decimalDigits: 2).format(paymentPerMonth)}'),
          ],
        ),
        trailing: status == 'ACCEPTED' || status == 'DECLINE'
            ? null
            : GestureDetector(
                onTap: () {},
                child: const Icon(Icons.refresh),
              ),
      ),
    );
  }
}
