import 'dart:convert';

import 'package:http/http.dart';
import '../models/index.dart';

class ApiCall {
  ApiCall(this._client, this._apiKey);

  final Client _client;
  final String _apiKey;

  Future<List<Photo>> apiCall({required String search, required int page}) async {
    final Uri uri = Uri.parse('https://api.unsplash.com/search/photos?query=$search&per_page=30&page=$page');
    final Response response = await _client.get(
      uri,
      headers: <String, String>{'Authorization': 'Client-ID $_apiKey'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> mapResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> result = mapResponse['results'] as List<dynamic>;

      return result.cast<Map<dynamic, dynamic>>().map((Map<dynamic, dynamic> json) => Photo.fromJson(json)).toList();
    }

    throw StateError(response.body);
  }
}
