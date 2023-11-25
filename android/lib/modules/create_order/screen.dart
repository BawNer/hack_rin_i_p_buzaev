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
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      child: InputFieldWidget(
                          controller: _amount,
                          label: 'Сумма кредита',
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true
                          ),
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
                          }
                      ),
                    ),
                    Text('RUB')
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Срок кредитования ${_presenter.period.toString()} месяцев'
                    ),
                    Slider(
                      value: _presenter.period.toDouble(),
                      min: 5.0,
                      max: 60.0,
                      divisions: 45,
                      activeColor: Theme.of(context).primaryColor,
                      label: 'Срок кредитования (мес)',
                      onChanged: (double newValue) {
                        _presenter.setPeriod(newValue);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('${tr('payment_per_month')} ~ ${NumberFormat.simpleCurrency(name: 'RUB', decimalDigits: 2).format(_presenter.amountPerMonth)} RUB')
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
