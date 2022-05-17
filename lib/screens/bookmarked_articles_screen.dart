import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/logic/auth/authentication.dart';
import 'package:news_app/logic/database/database.dart';
import 'package:news_app/logic/networking/article_networking.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/login_screen.dart';

class BookMarkedArticlesScreen extends StatefulWidget {
  const BookMarkedArticlesScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkedArticlesScreen> createState() => _BookMarkedArticlesScreenState();
}

class _BookMarkedArticlesScreenState extends State<BookMarkedArticlesScreen> {
  List<Article> articles = [];
  bool _isLoading = true;
  getNews() async {
    var articleList = await Database.getBookmarkedArticles();
    setState(() {
      articles.addAll(articleList);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Newsly'),
      ),
      body: _isLoading
          ? const Center(
              child: SpinKitDualRing(
                color: Colors.blue,
              ),
            )
          : Container(
              height: h,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return BlogTile(
                      index: index,
                      article: articles[index],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
