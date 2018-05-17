import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static const String KEY_OWNER_NAME = 'KEY_OWNER_NAME';
  static const String KEY_OAUTH_TOKEN = 'KEY_AUTH_TOKEN';

  bool get initialized => _initialized;

  bool get loggedIn => _loggedIn;

  String get ownerName => _ownerName;

  OauthClient get oauthClient => _oauthClient;

  final Client _client = new Client();

  final String _clientId = CLIENT_ID;
  final String _clientSecret = CLIENT_SECRET;
  bool _initialized;
  bool _loggedIn;
  String _ownerName;
  OauthClient _oauthClient;

  Future init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ownerName = prefs.getString(KEY_OWNER_NAME);
    String oauthToken = prefs.getString(KEY_OAUTH_TOKEN);

    if (ownerName == null || oauthToken == null) {
      _loggedIn = false;
      await logout();
    } else {
      _loggedIn = true;
      _ownerName = ownerName;
      _oauthClient = new OauthClient(_client, oauthToken);
    }

    _initialized = true;
  }

  Future logout() async {
    await _saveTokens(null, null);
    _loggedIn = false;
  }

  Future _saveTokens(String ownerName, String oauthToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_OWNER_NAME, ownerName);
    prefs.setString(KEY_OAUTH_TOKEN, oauthToken);
    //await prefs.commit();
    _ownerName = ownerName;
    _oauthClient = new OauthClient(_client, oauthToken);
  }

  Future<bool> login(String username, String password) async {
    var basicToken = _getEncodedAuthorization(username, password);
    final requestHeader = {'Authorization': 'Basic $basicToken'};
    final requestBody = json.encode({
      'client_id': _clientId,
      'client_secret': _clientSecret,
      'scopes': ['user', 'repo', 'gist', 'notifications']
    });

    final loginResponse = await _client
        .post('$BASE_URL/authorizations',
        headers: requestHeader, body: requestBody);
        //.whenComplete(_client.close);

    if (loginResponse.statusCode == 201) {
      final bodyJson = json.decode(loginResponse.body);
      _saveTokens(username, bodyJson['token']);
      _loggedIn = true;
    } else {
      _loggedIn = false;
    }

    return _loggedIn;
  }

  String _getEncodedAuthorization(String username, String password) {
    final authorizationBytes = UTF8.encode('$username:$password');
    return BASE64.encode(authorizationBytes);
  }

}

class OauthClient extends _AuthClient {
  OauthClient(Client client, String token) : super(client, 'token $token');
}

abstract class _AuthClient extends BaseClient {
  final Client _client;
  final String _authorization;

  _AuthClient(this._client, this._authorization);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['Authorization'] = _authorization;
    return _client.send(request);
  }
}
