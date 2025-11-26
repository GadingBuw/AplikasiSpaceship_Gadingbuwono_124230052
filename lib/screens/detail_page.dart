import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/models/article_model.dart';
import '/services/api_service.dart';

class DetailPage extends StatefulWidget {
  final String endpoint;
  final int articleId;

  const DetailPage({
    super.key, 
    required this.endpoint, 
    required this.articleId
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Article> _futureDetail;

  @override
  void initState() {
    super.initState();
    _futureDetail = ApiService().fetchArticleById(widget.endpoint, widget.articleId);
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail")),
      body: FutureBuilder<Article>(
        future: _futureDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Detail not found"));
          }

          final article = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  article.imageUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(height: 250, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(article.newsSite, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                          Text(article.publishedAt.substring(0, 10), style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Divider(height: 30),
                      Text(
                        article.summary,
                        style: const TextStyle(fontSize: 16, height: 1.6),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FutureBuilder<Article>(
        future: _futureDetail,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox();
          return Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 10),
            child: FloatingActionButton.extended(
              onPressed: () => _launchURL(snapshot.data!.url),
              backgroundColor: Colors.black, 
              icon: const Icon(Icons.web, color: Colors.white),
              label: const Text(
                "See more...", 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
              ),
            ),
          );
        },
      ),
    );
  }
}