import 'dart:convert';

import 'package:cradle/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsApi{
  final String baseUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=912d7d8cba994441897b912669c9b3fd";


  Future <NewsModel> getNewsData(String news) async{
    String apiUrl = "$baseUrl&q$news";
    print("API url = $apiUrl");

    try{
      final response = await http.get(Uri.parse(apiUrl));
      print('status : ${response.statusCode}');
      print('body : ${response.body}');

      if(response.statusCode == 200){
        return NewsModel.fromJson(jsonDecode(response.body));
      }else{
        throw Exception("Failure occurred");
      }
    } catch (error){
      print("Error : $error");
      throw Exception(error.toString());
    }

  }

}