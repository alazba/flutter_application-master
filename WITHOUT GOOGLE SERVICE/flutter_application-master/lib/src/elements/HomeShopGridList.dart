import 'package:flutter/material.dart';
import '../elements/HomeShopItem.dart';
import '../elements/HomeShopGridList.dart';
import '../elements/HomeShopGridItem.dart';

import '../elements/CircularLoadingWidget.dart';
import '../models/market.dart';
import '../models/route_argument.dart';

// ignore: must_be_immutable
class HomeShopGridList extends StatelessWidget {
  List<Market> marketsList;
  String heroTag;

  HomeShopGridList({Key key, this.marketsList, String heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return marketsList.isEmpty
        ? CircularLoadingWidget(height: 130)
        : GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              //modify the list to be one market in each row.
                crossAxisCount: 1,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 3),
            ),
            //padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              onTap: () async {
                await Navigator.of(context).pushNamed('/Details',
                    arguments: RouteArgument(
                    id: marketsList.elementAt(index).id,
                heroTag: heroTag,));
              };
              return HomeShopItem(market: marketsList.elementAt(index));
            },
            itemCount: marketsList.length,
            primary: false,
            shrinkWrap: true,
          );
  }
}
