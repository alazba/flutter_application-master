import 'package:flutter/material.dart';
import '../elements/HomeShopItem.dart';
import '../elements/HomeShopGridList.dart';
import '../elements/HomeShopGridItem.dart';

import '../elements/CircularLoadingWidget.dart';
import '../models/market.dart';

// ignore: must_be_immutable
class HomeShopGridList extends StatelessWidget {
  List<Market> marketsList;

  HomeShopGridList({Key key, this.marketsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return marketsList.isEmpty
        ? CircularLoadingWidget(height: 130)
        : GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            /*childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height )*/
            ),
            //padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return HomeShopGridItem(market: marketsList.elementAt(index));
            },
            itemCount: marketsList.length,
            primary: false,
            shrinkWrap: true,
          );
  }
}
