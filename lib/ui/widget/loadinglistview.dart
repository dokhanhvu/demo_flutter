import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/misc/function.dart';
import 'package:meta/meta.dart';

class LoadingListView<T> extends StatefulWidget {
  final PageRequest<T> pageRequest;

  final WidgetAdapter<T> widgetAdapter;

  final int pageSize;

  final int pageThreshold;

  final bool reverse;

  final Indexer<T> indexer;

//  static final Map<Key, LoadingListView> _cache =
//  <Key, LoadingListView>{};

  LoadingListView(this.pageRequest,
      {this.pageSize: 50,
      this.pageThreshold: 20,
      @required this.widgetAdapter,
      this.reverse: false,
      this.indexer,
      Key key}) : super(key: key);

//  factory LoadingListView(PageRequest<T> pageRequest,
//      {int pageSize,
//        int pageThreshold,
//        @required WidgetAdapter<T> widgetAdapter,
//        bool reverse: false,
//        Indexer<T> indexer,
//        Key key}){
//
//    if (_cache.containsKey(key)) {
//      return _cache[key];
//    } else {
//      final logger = new LoadingListView._internal(pageRequest,
//      pageSize: pageSize,
//      indexer: indexer,
//      key: key,
//      widgetAdapter: widgetAdapter,
//      pageThreshold: pageThreshold,
//      reverse: reverse,);
//      _cache[key] = logger;
//      return logger;
//    }
//  }

//    LoadingListView._internal(this.pageRequest,
//      {this.pageSize: 50,
//      this.pageThreshold: 20,
//      @required this.widgetAdapter,
//      this.reverse: false,
//      this.indexer,
//      Key key}) : super(key: key);

  @override
  createState() => new LoadingListViewState<T>();
}

class LoadingListViewState<T> extends State<LoadingListView<T>>{
  List<T> objects = [];
  Map<int, int> index = {};
  Future request;
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  bool isLoadMore = true;

  @override
  Widget build(BuildContext context) {
    ListView listView = new ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: objects.length + (isLoadMore ? 1 : 0),
      reverse: widget.reverse,
      controller: _scrollController,
    );

    return new RefreshIndicator(
      onRefresh: onRefresh,
      child: listView,
      //displacement: 2.0,
    );
  }

  @override
  void initState() {
    super.initState();
    this.lockedLoadNext();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<Null> onRefresh() async {
    this.request?.timeout(const Duration());

    Future<List<T>> fetched = widget.pageRequest(0, widget.pageSize);
    isLoadMore = true;

    fetched.then((onValue) {

      setState((){

    });

    });

//    setState(() {
//      this.objects.clear();
//      this.index.clear();
////        this.addObjects(fetched);
//      objects.addAll(fetched);
//    });

    return null;
  }

  Widget itemBuilder(BuildContext context, int index) {
    if (index + widget.pageThreshold > objects.length) {
      lockedLoadNext();
    }

    if (index == objects.length) return _buildProgressIndicator();

    return widget.widgetAdapter != null
        ? widget.widgetAdapter(objects[index])
        : new Container();
  }

  Future loadNext() async {
    if (!isPerformingRequest && isLoadMore) {
      setState(() => isPerformingRequest = true);

      int page = (objects.length / widget.pageSize).ceil() + 1;
      List<T> fetched = await widget.pageRequest(page, widget.pageSize);

      if (fetched == null ||
          fetched.length == 0 ||
          fetched.length < widget.pageSize) {
//        double edge = 50.0;
//        double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
//        if (offsetFromBottom < edge) {
//          _scrollController.animateTo(
//              _scrollController.offset - (edge -offsetFromBottom),
//              duration: new Duration(milliseconds: 500),
//              curve: Curves.easeOut);
//        }
        this.setState(() {
          isLoadMore = false;
          //isPerformingRequest = false;
        });
      }

      if (mounted) {
        this.setState(() {
          //this.addObjects(fetched);
          objects.addAll(fetched);
          isPerformingRequest = false;
        });
      }
    }
  }

  void lockedLoadNext() {
    if (this.request == null) {
      this.request = loadNext().then((x) {
        this.request = null;
      });
    }
  }

  void addObjects(Iterable<T> objects) {
    objects.forEach((T object) {
      int index = this.objects.length;
      this.objects.add(object);
//      if (widget.indexer != null) {
//        this.index[widget.indexer(object)] = index;
//      }
    });
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
