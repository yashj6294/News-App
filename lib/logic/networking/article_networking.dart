import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:news_app/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/utils/constants.dart';

class ArticleNetworking {
  static final Logger log = Logger();
  static Future<List<Article>> getArticles() async {
    List<Article> articles = [];
    try {
      var response = await http.get(Uri.parse(BASE_URL));
      if (response.statusCode != 200) {
        return articles;
      }
      var body = jsonDecode(response.body);
      log.d(body);
      for (var item in body['articles']) {
        articles.add(Article.fromJson(item));
      }
    } catch (e) {
      log.d(e.toString());
    }
    return articles;
  }
}
