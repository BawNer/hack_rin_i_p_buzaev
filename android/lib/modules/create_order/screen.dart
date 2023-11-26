import 'package:centr_invest_app/core/ui/input.dart';
import 'package:centr_invest_app/core/ui/padding.dart';
import 'package:centr_invest_app/modules/create_order/contract.dart';
import 'package:centr_invest_app/modules/create_order/presenter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen>
    implements CreateOrderContract {
  late final CreateOrderPresenter _presenter = CreateOrderPresenter(this);

  final _createOrderFormKey = GlobalKey<FormState>();
  final TextEditingController _amount = TextEditingController(text: '50000');

  @override
  void initState() {
    _presenter.calculateAmountPerMonth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          tr("create_order"),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: insets(all: 20),
          child: Form(
            key: _createOrderFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: InputFieldWidget(
                          controller: _amount,
                          label: tr('amount'),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          formatter: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9.]")),
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              final text = newValue.text;
                              return text.isEmpty
                                  ? newValue
                                  : double.tryParse(text) == null
                                      ? oldValue
                                      : newValue;
                            }),
                          ],
                          onChanged: (String v) {
                            _presenter.setPureAmount(v == '' ? '0.0' : v);
                          }),
                    ),
                  ],
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  value: "RUB",
                  items: [].fold<List<DropdownMenuItem<String>>>(
                      [],
                          (prev, element) => List.from(prev)
                        ..add(DropdownMenuItem(
                          value: element.currencyName,
                          child: Text(element.currencyName),
                        ))),
                  onChanged: (dynamic value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        '${tr("credit_period")} ${_presenter.period.toString()} ${tr("months")}'),
                    Slider(
                      value: _presenter.period.toDouble(),
                      min: 5.0,
                      max: 60.0,
                      divisions: 45,
                      activeColor: Theme.of(context).primaryColor,
                      label: '${tr("credit_period")} (${tr("months")})',
                      onChanged: (double newValue) {
                        _presenter.setPeriod(newValue);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    '${tr('payment_per_month')} ~ ${NumberFormat.simpleCurrency(name: 'RUB', decimalDigits: 2).format(_presenter.amountPerMonth)}'),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {},
                      child: Text(tr('next')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void render() {
    setState(() {});
  }
}
