import 'dart:convert';
import 'package:cradle/model/news_model.dart';
import 'package:http/http.dart' as http;

class CategoryNewsApi {
  Future<NewsModel> getCategoryData(String category) async {
    final String newUrl = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=912d7d8cba994441897b912669c9b3fd";
    print("Category Url : $newUrl");
    var response = await http.get(Uri.parse(newUrl));

    try {
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        print('category');
        return NewsModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Error Occurred");
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
