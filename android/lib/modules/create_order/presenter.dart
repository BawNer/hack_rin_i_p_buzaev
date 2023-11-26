import 'dart:core';
import 'dart:math';

import 'package:centr_invest_app/modules/create_order/contract.dart';

class CreateOrderPresenter {
  late CreateOrderContract _view;

  CreateOrderPresenter(CreateOrderContract view) {
    _view = view;
  }

  int _period = 5;
  double _pureAmount = 50000.0;

  int get period => _period;
  double get pureAmount => _pureAmount;

  double _amountPerMonth = 0.0;
  double get amountPerMonth => _amountPerMonth;

  void setPeriod(double newValue) {
    _period = newValue.round();
    calculateAmountPerMonth();
  }

  void setPureAmount(String v) {
    _pureAmount = double.parse(v);
    calculateAmountPerMonth();
  }

  void calculateAmountPerMonth() {
    const double percent = (15 / 12) / 1000;
    _amountPerMonth = _pureAmount * (
        percent * pow((1 + percent), _period.toInt()) /
            (pow(1+percent, _period.toInt()) - 1)
    );
    _view.render();
  }
}