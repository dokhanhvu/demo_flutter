import 'dart:convert';

class User {
  final String login;
  final int id;
  final String avatar;
  final String name;
  final int publicRepos;
  final int followers;
  final int following;

  User(this.id,
      this.name,
      this.login,
      this.avatar,
      this.publicRepos,
      this.followers,
      this.following);

  factory User.fromJson(Map map) {
    return new User(
        map['id'],
        map['name'],
        map['login'],
        map['avatar_url'],
        map['public_repos'],
        map['followers'],
        map['following']);
  }

  static List<User> usersFromJson(String response) {
    var data = json.decode(response);
    return data
        .cast<Map<String, dynamic>>()
        .map((obj) => User.fromJson(obj))
        .toList()
        .cast<User>();
  }
}
