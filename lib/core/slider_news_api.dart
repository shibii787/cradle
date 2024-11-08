import 'dart:convert';

import 'package:cradle/model/news_model.dart';
import 'package:http/http.dart' as http;

class SliderNewsApi{
final String url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=912d7d8cba994441897b912669c9b3fd";

Future<NewsModel> getSliderData(String data) async{
  String api = "$url&q$data";
  //print("Slider : $api");

  try{
    final response = await http.get(Uri.parse(api));
    //print('status : ${response.statusCode}');
    //print('body : ${response.body}');
    if(response.statusCode == 200){
      return NewsModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Failure occurred");
    }
  }catch (error){
    //print(error);
    throw Exception(error.toString());
  }
}
}