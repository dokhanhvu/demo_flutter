import 'package:flutter/material.dart';
import 'package:flutter_app/cart_app.dart';
import 'package:flutter_app/device_info_app.dart';
import 'package:flutter_app/my_app.dart';
import 'package:flutter_app/navigator_app.dart';
import 'package:flutter_app/ui/view/randomwords.dart';

void main() => runApp(new MyApp());

// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Each TabBarView contains a _Page and for each _Page there is a list
// of _CardData objects. Each _CardData object is displayed by a _CardItem.

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      home: new TabsDemo(),
    );
  }
}

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class _Page {
  _Page({this.label});

  final String label;

  String get id => label[0];

  @override
  String toString() => '$runtimeType("$label")';
}

class _CardData {
  const _CardData({this.title, this.imageAsset, this.imageAssetPackage});

  final String title;
  final String imageAsset;
  final String imageAssetPackage;
}

class _CardDataItem extends StatelessWidget {
  const _CardDataItem({this.page, this.data});

  static const double height = 272.0;
  final _Page page;
  final _CardData data;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Align(
              alignment:
                  page.id == 'L' ? Alignment.centerLeft : Alignment.centerRight,
              child: new CircleAvatar(child: new Text('${page.id}')),
            ),
            new SizedBox(
              width: 144.0,
              height: 144.0,
              child: new Image.asset(
                data.imageAsset,
                package: data.imageAssetPackage,
                fit: BoxFit.contain,
              ),
            ),
            new Center(
              child: new Text(
                data.title,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabsDemo extends StatelessWidget {
  //static const String routeName = '/material/tabs';
  Map<_Page, List<_CardData>> _allPages;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: _allPages.length,
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: new SliverAppBar(
                  title: const Text('Tabs and scrolling'),
                  actions: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.list),
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => new RandomWords()));
                        }),
                  ],
                  pinned: true,
                  expandedHeight: 150.0,
                  forceElevated: innerBoxIsScrolled,
                  bottom: new TabBar(
                    tabs: _allPages.keys
                        .map(
                          (_Page page) => new Tab(text: page.label),
                        )
                        .toList(),
                  ),
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: _allPages.keys.map((_Page page) {
              return new SafeArea(
                key: new PageStorageKey<_Page>(page),
                top: false,
                bottom: false,
                child: new Builder(
                  builder: (BuildContext context) {
                    return new ListView.builder(
                      itemCount: _allPages[page].length,
                      itemBuilder: (BuildContext context, int index) {
                        final _CardData data = _allPages[page][index];
                        return new Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: new _CardDataItem(
                            page: page,
                            data: data,
                          ),
                        );
                      },
                    );
//                    return new CustomScrollView(
//                      key: new PageStorageKey<_Page>(page),
//                      slivers: <Widget>[
//                        new SliverOverlapInjector(
//                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//                        ),
//                        new SliverPadding(
//                          padding: const EdgeInsets.symmetric(
//                            vertical: 8.0,
//                            horizontal: 16.0,
//                          ),
//                          sliver: new SliverFixedExtentList(
//                            itemExtent: _CardDataItem.height,
//                            delegate: new SliverChildBuilderDelegate(
//                                  (BuildContext context, int index) {
//                                final _CardData data = _allPages[page][index];
//                                return new Padding(
//                                  padding: const EdgeInsets.symmetric(
//                                    vertical: 8.0,
//                                  ),
//                                  child: new _CardDataItem(
//                                    page: page,
//                                    data: data,
//                                  ),
//                                );
//                              },
//                              childCount: _allPages[page].length,
//                            ),
//                          ),
//                        ),
//                      ],
//                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  TabsDemo(){
    _allPages = <_Page, List<_CardData>>{
      new _Page(label: 'LEFT'): <_CardData>[
        const _CardData(
          title: 'Vintage Bluetooth Radio',
          imageAsset: 'shrine/products/radio.png',
          imageAssetPackage: _kGalleryAssetsPackage,
        ),
        const _CardData(
          title: 'Sunglasses',
          imageAsset: 'shrine/products/sunnies.png',
          imageAssetPackage: _kGalleryAssetsPackage,
        ),
        const _CardData(
          title: 'Clock',
          imageAsset: 'shrine/products/clock.png',
          imageAssetPackage: _kGalleryAssetsPackage,
        ),
        const _CardData(
          title: 'Red popsicle',
          imageAsset: 'shrine/products/popsicle.png',
          imageAssetPackage: _kGalleryAssetsPackage,
        ),
        const _CardData(
          title: 'Folding Chair',
          imageAsset: 'shrine/products/lawn_chair.png',
          imageAssetPackage: _kGalleryAssetsPackage,
        ),
        const _CardData(
          title: 'Green comfort chair',
          imageAsset: 'shrine/products/chair.png',
          imageAssetPackage: _kGalleryAssetsPackage,
        ),
        const _CardData(
          title: 'Old Binoculars',
          imageAsset: 'shrine/products/binoculars.png',
          imageAssetPackage: _kGalleryAssetsPackage,
        ),
        const _CardData(
          title: 'Teapot',
          imageAsset: 'shrine/products/teapot.png',
          imageAssetPackage: _kGalleryAssetsPackage,
        ),
        const _CardData(
          title: 'Blue suede shoes',
          imageAsset: 'shrine/products/chucks.png',
          imageAssetPackage: _kGalleryAssetsPackage,
        ),
      ],
      new _Page(label: 'RIGHT'): <_CardData>[
        const _CardData(
          title: 'Beachball',
          imageAsset: 'shrine/products/beachball.png',
          imageAssetPackage: _kGalleryAssetsPackage,
        ),
        const _CardData(
          title: 'Dipped Brush',
          imageAsset: 'shrine/products/brush.png',
          imageAssetPackage: _kGalleryAssetsPackage,
        ),
        const _CardData(
          title: 'Perfect Goldfish Bowl',
          imageAsset: 'shrine/products/fish_bowl.png',
          imageAssetPackage: _kGalleryAssetsPackage,
        ),
      ],
    };
  }
}
