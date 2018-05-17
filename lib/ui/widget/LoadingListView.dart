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

  LoadingListView(this.pageRequest,
      {this.pageSize: 20,
      this.pageThreshold: 5,
      @required this.widgetAdapter,
      this.reverse: false,
      this.indexer});

  @override
  createState() => new LoadingListViewState<T>();
}

class LoadingListViewState<T> extends State<LoadingListView<T>> {
  List<T> objects = [];
  Map<int, int> index = {};
  Future request;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemBuilder: itemBuilder,
        itemCount: objects.length,
        reverse: widget.reverse);

    //return new RefreshIndicator(onRefresh: onRefresh, child: listView);
  }

  @override
  void initState() {
    super.initState();
    this.lockedLoadNext();
  }

  Future<Null> onRefresh() async{
    this.request?.timeout(const Duration());
    List<T> fetched = await widget.pageRequest(0, widget.pageSize);

      setState(() {
        this.objects.clear();
        this.index.clear();
        this.addObjects(fetched);
      });

    return null;
  }

  Widget itemBuilder(BuildContext context, int index) {
    if (index + widget.pageThreshold > objects.length) {
      lockedLoadNext();
    }

    return widget.widgetAdapter != null
        ? widget.widgetAdapter(objects[index])
        : new Container();
  }

  Future loadNext() async{
    int page = (objects.length / widget.pageSize).ceil() + 1;
    List<T> fetched = await widget.pageRequest(page, widget.pageSize);

    if (fetched == null || fetched.length == 0) return;

    if (mounted) {
      this.setState(() {
        this.addObjects(fetched);
      });
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
      if (widget.indexer != null) {
        this.index[widget.indexer(object)] = index;
      }
    });
  }
}