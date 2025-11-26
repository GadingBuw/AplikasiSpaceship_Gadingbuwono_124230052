import 'dart:convert';
import 'package:http/http.dart' as http;
// Import ketiga model
import '../models/news.dart';
import '../models/blog.dart';
import '../models/report.dart';

class ApiService {
  final String baseUrl = "https://api.spaceflightnewsapi.net/v4";

  Future<List<dynamic>> fetchList(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint/'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> results = jsonResponse['results'];

      if (endpoint == 'articles') {
        return results.map((data) => News.fromJson(data)).toList();
      } else if (endpoint == 'blogs') {
        return results.map((data) => Blog.fromJson(data)).toList();
      } else if (endpoint == 'reports') {
        return results.map((data) => Report.fromJson(data)).toList();
      }
      return [];
    } else {
      throw Exception('Gagal load data');
    }
  }

  Future<dynamic> fetchDetail(String endpoint, int id) async {
    final url = '$baseUrl/$endpoint/$id/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      if (endpoint == 'articles') return News.fromJson(jsonData);
      if (endpoint == 'blogs') return Blog.fromJson(jsonData);
      if (endpoint == 'reports') return Report.fromJson(jsonData);
    } else {
      throw Exception('Gagal load detail');
    }
  }
}