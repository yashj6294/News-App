import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/logic/auth/authentication.dart';
import 'package:news_app/logic/networking/article_networking.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/screens/article_details_screen.dart';
import 'package:news_app/screens/bookmarked_articles_screen.dart';
import 'package:news_app/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> articles = [];
  bool _isLoading = true;
  getNews() async {
    var articleList = await ArticleNetworking.getArticles();
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
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BookMarkedArticlesScreen()),
              );
            },
            icon: const Icon(Icons.bookmarks_outlined),
          ),
          IconButton(
            onPressed: () async {
              await Authentication.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
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

class BlogTile extends StatelessWidget {
  final Article article;
  final int index;
  const BlogTile({required this.article,required this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleDetailsScreen(index:index,article: article),
          ),
        );
      },
      child: Card(
        elevation: 8.0,
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                height: 8,
              ),
              Text(
                article.title ?? "Title not available",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                article.description ?? 'Description not available',
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
