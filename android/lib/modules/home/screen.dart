import 'package:centr_invest_app/core/ui/padding.dart';
import 'package:centr_invest_app/modules/home/contract.dart';
import 'package:centr_invest_app/modules/home/items/emotion_face.dart';
import 'package:centr_invest_app/modules/home/presenter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
      body: SafeArea(
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
                      Column(
                        children: [
                          const EmoticonFace(emotion: '😃'),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            tr("excellent"),
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const EmoticonFace(emotion: '☺️'),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            tr("fine"),
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const EmoticonFace(emotion: '🗿'),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            tr("normal"),
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const EmoticonFace(emotion: '😭'),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            tr("awfully"),
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
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
                  color: Colors.white,
                  child: Padding(
                    padding: insets(all: 25),
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
                              onPressed: () {},
                              child: const Icon(Icons.more_horiz),
                            ),
                          ],
                        ),

                        // listview of last request

                        const SizedBox(
                          height: 15,
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void render() {
    setState(() {});
  }
}
