import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/market.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

// ignore: must_be_immutable
class HomeShopGridItem extends StatelessWidget {
  Market market;
//  String heroTag;

  HomeShopGridItem({Key key, this.market}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
       // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Image of the card
          Stack(
            fit: StackFit.loose,
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              Hero(
                tag: market.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                  child: CachedNetworkImage(
                  height:140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: market.image.url,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                     // width: double.infinity,
                    //  height:50,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: market.closed ? Colors.grey : Color(0xff3d619b), borderRadius: BorderRadius.circular(5)),
                    child: market.closed
                        ? Text(
                      S.of(context).closed,
                      style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                    )
                        : Text(
                      S.of(context).open,
                      style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        market.name,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        Helper.skipHtml(market.description),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      // SizedBox(height: 5),
                      /* Row(
                        children: Helper.getStarsList(double.parse(market.rate)),
                      ),*/
                    ],
                  ),
                ),
                //SizedBox(width: 15),
              ],
            ),
          )
        ],
      ),
    );
  }
}
