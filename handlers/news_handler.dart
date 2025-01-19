import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:sapienza_driver/models/news.dart';

class NewsHandler {
  final String websiteUrl = "https://www.uniroma1.it";

  Future<List<News>> getNews({
    String locale = 'it',
    bool withDescription = false,
    int? limit,
    int? page,
    int? maxPage,
    String? query,
  }) async {
    final List<News> newsList = [];
    final int startPage = page ?? 0;
    final int endPage = maxPage ?? (startPage + 1);

    for (int i = startPage; i < endPage; i++) {
      final url = Uri.parse("$websiteUrl/$locale/tutte-le-notizie");
      final response = await http.get(
  url.replace(queryParameters: {
    if (query != null) 'search_api_views_fulltext': query,
    'page': i.toString(),
  }),
  headers: {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
  },
);
      if (response.statusCode != 200) {
        throw Exception("Errore nella richiesta: ${response.statusCode}");
      }

      final document = html.parse(response.body);
      final boxes = document.getElementsByClassName("box-news");

      for (var box in boxes) {
        final title = box.querySelector("img")?.attributes['title'] ?? "";
        if (title.isEmpty) continue;

        final urlPath = box.querySelector("a")?.attributes['href']?.trim() ?? "";
        final smallImageUrl = box.querySelector("img")?.attributes['src'];

        final news = News(
          title: title,
          url: "$websiteUrl$urlPath",
          smallImageUrl: smallImageUrl,
        );

        newsList.add(news);

        if (limit != null && newsList.length >= limit) {
          return newsList;
        }
      }
    }

    if (withDescription) {
      await Future.forEach(newsList, (News news) async {
        final detailResponse = await http.get(Uri.parse(news.url));
        if (detailResponse.statusCode == 200) {
          final detailDoc = html.parse(detailResponse.body);
          news.description =
              detailDoc.querySelector(".testosommario .field-item")?.text.trim();
          news.imageUrl =
              detailDoc.querySelector(".img-responsive")?.attributes['src'];

          final dateText =
              detailDoc.querySelector(".date-display-single")?.text;
          if (dateText != null) {
            try { 
            
              news.date = DateTime.parse(
                  dateText.substring(dateText.indexOf(",") + 1).trim());
            } catch (_) {
              // Ignora errori di parsing della data
            }
          }
        }
      });
    }

    return newsList;
  }
}
