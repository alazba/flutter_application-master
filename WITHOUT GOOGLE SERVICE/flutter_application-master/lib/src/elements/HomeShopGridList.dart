
import 'package:flutter/material.dart';
import '../elements/HomeShopItem.dart';
import '../elements/HomeShopGridList.dart';

import '../elements/CircularLoadingWidget.dart';
import '../models/market.dart';

// ignore: must_be_immutable
class HomeShopGridList extends StatelessWidget {
  List<Market> marketsList;

  HomeShopGridList({Key key, this.marketsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return marketsList.isEmpty
        ? CircularLoadingWidget(height: 200)
        : GridView.builder(
      gridDelegate:
      new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return HomeShopItem(market: marketsList.elementAt(index));
      },
      itemCount: marketsList.length,
      primary: false,
      shrinkWrap: true,
    );
  }
}
