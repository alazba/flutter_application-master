
import 'package:flutter/material.dart';
import '../elements/HomeShopItem.dart';
import '../elements/HomeShopGridItem.dart';

import '../elements/CircularLoadingWidget.dart';
import '../models/market.dart';

// ignore: must_be_immutable
class HomeShopList extends StatelessWidget {
  List<Market> marketsList;

  HomeShopList({Key key, this.marketsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return marketsList.isEmpty
        ? CircularLoadingWidget(height: 200)
        : ListView.separated(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return HomeShopItem(market: marketsList.elementAt(index));
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
      itemCount: marketsList.length,
      primary: false,
      shrinkWrap: true,
    );
  }
}
