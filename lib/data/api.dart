import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/misc/auth_manager.dart';
import 'package:flutter_app/misc/keys.dart';
import 'package:flutter_app/model/user.dart';

class Api {
  final AuthManager _authManager;

  Api(this._authManager);

  Future<List<User>> getFollowers(
      int pageNumber, int pageSize, String userName) async {
    userName = 'dutn158';
    String url =
        "$BASE_URL/users/$userName/followers?page=$pageNumber&per_page=$pageSize";

    print(url);
    var client = _authManager.oauthClient;

    try {
     var response = await client.get(url).whenComplete(client.close);

      if (response.statusCode == 200) {
        List<User> future = User.usersFromJson(response.body);
        return future;
      }
    } catch (exception) {
      print(exception.toString());
    }
    return null;
  }

  Future<List<User>> getFollowing(
      int pageNumber, int pageSize, String userName) async {
    userName = 'dutn158';
    String url =
        "$BASE_URL/users/$userName/following?page=$pageNumber&per_page=$pageSize";

    print(url);

    var client = _authManager.oauthClient;

    try {
      var response = await client.get(url).whenComplete(client.close);

      if (response.statusCode == 200) {
        List<User> future = User.usersFromJson(response.body);
        return future;
      }
    } catch (exception) {
      print(exception.toString());
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getFollowing2(
      int pageNumber, int pageSize, String userName) async {
    userName = 'dutn158';
    String url =
        "$BASE_URL/users/$userName/following?page=$pageNumber&per_page=$pageSize";

    print(url);

    var client = _authManager.oauthClient;

    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
//        List<User> future = User.usersFromJson(response.body);
//        return future;
      return JSON.decode(response.body).cast<Map<String, dynamic>>().toList();
//      return json.decode(response.body).toList();
      }
    } catch (exception) {
      print(exception.toString());
    }
    return null;
  }

}
