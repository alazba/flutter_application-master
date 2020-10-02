import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import '../../generated/l10n.dart';
import '../controllers/market_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/GalleryCarouselWidget.dart';
import '../elements/ProductItemWidget.dart';
import '../elements/ReviewsListWidget.dart';
import '../elements/ShoppingCartFloatButtonWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

class DetailsWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  DetailsWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _DetailsWidgetState createState() {
    return _DetailsWidgetState();
  }
}

class _DetailsWidgetState extends StateMVC<DetailsWidget> {
  MarketController _con;

  _DetailsWidgetState() : super(MarketController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForMarket(id: widget.routeArgument.id);
    _con.listenForGalleries(widget.routeArgument.id);
    _con.listenForFeaturedProducts(widget.routeArgument.id);
    _con.listenForMarketReviews(id: widget.routeArgument.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,

        floatingActionButton:

        FloatingActionButton.extended(

          backgroundColor: Colors.transparent,

          onPressed: () {
            Navigator.of(context).pushNamed('/Menu',
                arguments: new RouteArgument(id: widget.routeArgument.id));
          },

          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

         icon:

         Transform.scale(
           alignment: Alignment.centerRight,

           scale: 2.7,
           child:

             IconButton(
                 onPressed: (){},
              icon:
              new Image.asset("assets/img/bag.png"),
           ),

         ),

          label:

                Text(
                  S.of(context).shopping,
             style: TextStyle(color: Colors.blueGrey, fontSize: 21),
                  textAlign: TextAlign.right,

                ),

        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: RefreshIndicator(
          onRefresh: _con.refreshMarket,
          child: _con.market == null
              ? CircularLoadingWidget(height: 500)
              : Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CustomScrollView(
                      primary: true,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        SliverAppBar(
                          backgroundColor:
                              Theme.of(context).accentColor.withOpacity(0.9),
                          expandedHeight:200,
                          elevation: 0,
                          iconTheme: IconThemeData(
                              color: Theme.of(context).primaryColor),
                          flexibleSpace: FlexibleSpaceBar(
                            title: Column(children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 0.0, top: 100.0, bottom: 0.0, right: 0.0),
                                child: new Stack(
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage('assets/img/bg.png'),
                                      width: 333.0,
                                      height: 43.0,
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                    Text(
                                      _con.market?.name ?? '',
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontFamily: "Amiri",
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 20, vertical: 12),
                                    //   child: Helper.applyHtml(
                                    //       context, _con.market.description),
                                    // ),
                                  ],

                                ),

                                /* child: Text( _con.market?.description ?? '',
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
*/
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                child: Helper.applyHtml(
                                    context, _con.market.description),
                              ),
                            ]),
                            collapseMode: CollapseMode.parallax,
                            background: Hero(
                              tag: (widget?.routeArgument?.heroTag ?? '') +
                                  _con.market.id,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: _con.market.image.url,
                                placeholder: (context, url) => Image.asset(
                                  'assets/img/loading.gif',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Wrap(
                            children: [
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 5),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 8.0,
                                        top: 8.0,
                                        bottom: 8.0,
                                        right: 8.0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: _con.market.closed
                                            ? Colors.amberAccent
                                            : Color(0xff3d619b),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: _con.market.closed
                                        ? Text(
                                            S.of(context).closed,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          )
                                        : Text(
                                            S.of(context).open,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ),
                                  ),
                                  SizedBox(width: 0),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: Helper.canDelivery(_con.market)
                                            ? Color(0xff3d619b)
                                            : Colors.orange,
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    child: Helper.canDelivery(_con.market)
                                        ? Text(
                                            S.of(context).delivery,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          )
                                        : Text(
                                            S.of(context).pickup,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ),
                                  ),
                                  Expanded(child: SizedBox(height: 0)),
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            '/Pages',
                                            arguments: new RouteArgument(
                                                id: '1', param: _con.market));
                                      },
                                      child: Image.asset(
                                          'assets/img/location-de.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 35,
                                    height: 35,
                                    child: FlatButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        launch("tel:${_con.market.mobile}");
                                      },
                                      child: Image.asset(
                                          'assets/img/whatsapp.png'),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                child: Helper.applyHtml(
                                    context, _con.market.description),
                              ),
                              ImageThumbCarouselWidget(
                                  galleriesList: _con.galleries),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                child: Helper.applyHtml(
                                    context, _con.market.information),
                              ),
                              _con.featuredProducts.isEmpty
                                  ? SizedBox(height: 0)
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: ListTile(
                                        dense: true,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        title: Text(
                                          S.of(context).featured_products,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                    ),
                              _con.featuredProducts.isEmpty
                                  ? SizedBox(height: 0)
                                  : ListView.separated(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: _con.featuredProducts.length,
                                      separatorBuilder: (context, index) {
                                        return SizedBox(height: 10);
                                      },
                                      itemBuilder: (context, index) {
                                        return ProductItemWidget(
                                          heroTag: 'details_featured_product',
                                          product: _con.featuredProducts
                                              .elementAt(index),
                                        );
                                      },
                                    ),
                              SizedBox(height: 100),
                              _con.reviews.isEmpty
                                  ? SizedBox(height: 5)
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: ListTile(
                                        dense: true,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        leading: Icon(
                                          Icons.recent_actors,
                                          color: Theme.of(context).hintColor,
                                        ),
                                        title: Text(
                                          S.of(context).what_they_say,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                    ),
                              _con.reviews.isEmpty
                                  ? SizedBox(height: 5)
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: ReviewsListWidget(
                                          reviewsList: _con.reviews),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 50,
                      right: 345,
                      child: ShoppingCartFloatButtonWidget(
                        iconColor: Theme.of(context).primaryColor,
                        labelColor: Theme.of(context).hintColor,
                        routeArgument: RouteArgument(
                            param: '/Details', id: widget.routeArgument.id),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
