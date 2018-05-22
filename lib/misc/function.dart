import 'dart:async';

import 'package:flutter/material.dart';
typedef Future<List<T>> PageRequest<T> (int page, int pageSize);
typedef Widget WidgetAdapter<T>(T t);
typedef int Indexer<T>(T t);
typedef Future<bool> HandleSubmit(/*BuildContext context*/);