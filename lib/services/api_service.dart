import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/article_model.dart';

class ApiService {
  final String baseUrl = "https://api.spaceflightnewsapi.net/v4";

  Future<List<Article>> fetchArticles(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint/'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> results = jsonResponse['results'];
      return results.map((data) => Article.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}