import 'dart:convert';

class User{
  final String username;

  final int id;

  final String avatar;

  User({this.username, this.id, this.avatar});

  static User fromMap(Map  map) {
    return new User
      (
      username: map['login'],
      id: map['id'],
      avatar: map['avatar_url']
    );
  }

  static List<User> usersFromJson(String response) {
    var data = json.decode(response);
    return data
        .cast<Map<String, dynamic>>()
        .map((obj) => User.fromMap(obj))
        .toList()
        .cast<User>();
  }
}