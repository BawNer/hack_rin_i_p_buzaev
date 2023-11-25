import 'package:centr_invest_app/core/ui/card_story.dart';
import 'package:centr_invest_app/core/ui/padding.dart';
import 'package:centr_invest_app/modules/home/contract.dart';
import 'package:centr_invest_app/modules/home/items/bank_request/bank_request_item.dart';
import 'package:centr_invest_app/modules/home/presenter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../navigate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> implements HomeContract {
  late final HomePresenter _presenter = HomePresenter(this);

  @override
  void initState() {
    _presenter.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: insets(left: 25, right: 25, top: 20, bottom: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              _presenter.user?.name ?? 'no name provided',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: insets(all: 5),
                          child: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          tr("bank_info"),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                        const Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CardStory(
                          color: Colors.white24,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                  "Команда\nИ.П. Бузаев\nзаняла\nпервое место!\nРасскажем\nкак это было",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CardStory(
                          color: Colors.white24,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                  "Расскажем \nкак обмануть \nмошенника",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CardStory(
                          color: Colors.white24,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                  "Снизили\nставки!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        CardStory(
                          color: Colors.blueGrey.shade900,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FittedBox(
                                child: Text(
                                  "Black\nFriday!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  child: Container(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: insets(horizontal: 15, vertical: 25),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                tr("bank_last_request"),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30),
                                        ),
                                      ),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return buildBottomSheetFilters(context);
                                      });
                                },
                                child: const Icon(Icons.more_horiz),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigate.openCreateOrderScreen(context);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                foregroundColor: MaterialStateProperty.all(Colors.white),
                              ),
                              child: Text(tr("create_order"))
                          ),

                          // listview of last request

                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(child: buildBankRequestItems()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBankRequestItems() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return BankRequestItem(
          id: index + 1,
          status: 'ACCEPTED',
          createdAt: '12.12.12 12:12',
          updatedAt: '12.12.12 12:12',
          course: 96.52 + index,
          creditAmount: 5000.00,
          creditPeriod: 12 - index,
          paymentPerMonth: 120.12 * 96.52,
          pureAmount: 5000.00 * 96.52,
          pureCurrencyName: 'RUB',
        );
      },
    );
  }

  Widget buildBottomSheetFilters(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        child: Padding(
          padding: insets(vertical: 5, horizontal: 15),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      color: Colors.grey,
                      child: SizedBox(
                        height: 4,
                        width: 60,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('filters'),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: () {},
                  child: Text(tr("create_order")),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void render() {
    setState(() {});
  }
}
