import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/logic/database/database.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/utils/dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Article article;
  final int index;
  const ArticleDetailsScreen(
      {Key? key, required this.article, required this.index})
      : super(key: key);
  void _launchUrl(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? 'No Title'),
        actions: [
          IconButton(
            onPressed: () {
              article.url != null
                  ? _launchUrl(Uri.parse(article.url!))
                  : Fluttertoast.showToast(msg: 'No url found');
            },
            icon: const Icon(Icons.web_outlined),
          ),
          IconButton(
            onPressed: () async {
              showLoaderDialog(context);
              await Database.bookmarkArticle(article);
              Fluttertoast.showToast(msg: 'Article bookmarked successfully');
              Navigator.pop(context);
            },
            icon: const Icon(Icons.bookmark_add_outlined),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        height: h,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                article.title ?? 'No Title',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Hero(
                tag: index.toString(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: article.urlToImage == null ||
                          article.urlToImage!.contains('//m')
                      ? Container(
                          height: 150.0,
                          alignment: Alignment.center,
                          child: const Text(
                            'Image not available',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                          color: Colors.grey,
                        )
                      : CachedNetworkImage(
                          imageUrl: article.urlToImage!,
                        ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                article.description ?? 'No Description',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                article.content ?? 'No Content',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
                maxLines: 1000,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
