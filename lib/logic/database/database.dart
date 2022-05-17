import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:news_app/logic/auth/authentication.dart';
import 'package:news_app/models/article.dart';

class Database {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final Logger log = Logger();
  static Future<List<Article>> getBookmarkedArticles() async {
    List<Article> bookmarkedArticles = [];
    try {
      var response = await _db
          .collection('Bookmarked Articles')
          .doc(Authentication.user!.uid)
          .get();
      for (var snapshot in response.data()!['bookMarkedArticles']) {
        bookmarkedArticles.add(Article.fromJson(snapshot));
      }
      return bookmarkedArticles;
    } catch (e) {
      log.d(e);
    }
    return bookmarkedArticles;
  }

  static Future<void> bookmarkArticle(Article article) async {
    try {
      var doc = await _db
          .collection("Bookmarked Articles")
          .doc(Authentication.user!.uid)
          .get();
      if(doc.exists){
        await _db
          .collection("Bookmarked Articles")
          .doc(Authentication.user!.uid)
            .update({
          "bookMarkedArticles": FieldValue.arrayUnion([article.toJson()])
        });
      }else{
        await _db
            .collection("Bookmarked Articles")
            .doc(Authentication.user!.uid)
            .set({
          "bookMarkedArticles": FieldValue.arrayUnion([article.toJson()])
        });
      }
    } catch (e) {
      log.d(e);
    }
  }
}
