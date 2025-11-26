import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/models/article_model.dart';

class DetailPage extends StatelessWidget {
  final Article article;

  const DetailPage({super.key, required this.article});

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(article.url);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Detail")),
      body: SingleChildScrollView(
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
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article.newsSite,
                        style: const TextStyle(
                          color: Colors.grey, 
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        article.publishedAt.substring(0, 10),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Divider(height: 30, thickness: 1),
                  

                  Text(
                    article.summary,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  
                  const SizedBox(height: 80), 
                ],
              ),
            ),
          ],
        ),
      ),
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton.extended(
          onPressed: _launchURL,
          backgroundColor: Colors.black, 
          icon: const Icon(Icons.web, color: Colors.white),
          label: const Text(
            "See more...", 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
          ),
        ),
      ),
    );
  }
}