import 'dart:async';
import 'dart:collection';
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
      {this.pageSize: 50,
      this.pageThreshold: 20,
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
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  bool isLoadMore = true;
  final pagesCompleted = Set<int>();

  @override
  Widget build(BuildContext context) {
    ListView listView = new ListView.builder(
      itemBuilder: (context, i) {
        return itemBuilder(getItem(i));
      },
      itemCount: objects.length + (isLoadMore ? 1 : 0),
      reverse: widget.reverse,
      controller: _scrollController,
    );

    return new RefreshIndicator(
      onRefresh: onRefresh,
      child: listView,
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
    List<T> fetched = await widget.pageRequest(1, widget.pageSize);
    isLoadMore = true;

    setState(() {
      this.objects.clear();
      this.index.clear();
//        this.addObjects(fetched);
      objects.addAll(fetched);
      pagesCompleted.clear();
    });

    return null;
  }

  Future<T> getItem(int index) {
    final pageIndex = pageIndexFromProductIndex(index);
    if (index == objects.length) return null;
    if (pagesCompleted.contains(pageIndex)) {
      if (index + widget.pageThreshold > objects.length) {
        lockedLoadNext();
      }
    }
    return Future.value(objects[index]);
  }

  Widget itemBuilder(Future<T> future) {
//    if (index + widget.pageThreshold > objects.length) {
//      lockedLoadNext();
//    }
//
//    if (index == objects.length) return _buildProgressIndicator();
//
//    return widget.widgetAdapter != null
//        ? widget.widgetAdapter(objects[index])
//        : new Container();

    if (future == null) {
      return _buildProgressIndicator();
    } else {
      return new FutureBuilder<T>(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.hasData)
            return widget.widgetAdapter(snapshot.data);
          else
            return new Container();
        },
      );
    }
  }

  Future loadNext() async {
    if (!isPerformingRequest && isLoadMore) {
      setState(() => isPerformingRequest = true);

      int page = (objects.length / widget.pageSize).ceil() + 1;
      List<T> fetched = await widget.pageRequest(page, widget.pageSize);

      if (fetched == null ||
          fetched.length == 0 ||
          fetched.length < widget.pageSize) {
        this.setState(() {
          isLoadMore = false;
          //isPerformingRequest = false;
        });
      }

      if (mounted) {
        pagesCompleted.add(page - 1);
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
      if (widget.indexer != null) {
        this.index[widget.indexer(object)] = index;
      }
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

  int pageIndexFromProductIndex(int productIndex) {
    return productIndex ~/ widget.pageSize;
  }
}

class Cache<T> {
  final map = HashMap<int, T>();

  Future<T> get(int index) {
    return Future.value(map[index]);
  }

  put(int index, object) {
    map[index] = object;
  }
}
