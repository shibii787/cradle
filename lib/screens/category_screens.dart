import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/category_news_api.dart';
import '../main.dart';
import '../model/news_model.dart';

class CategoryScreens extends StatefulWidget {
  final String name;
  const CategoryScreens({super.key, required this.name});

  @override
  State<CategoryScreens> createState() => _CategoryScreensState();
}

class _CategoryScreensState extends State<CategoryScreens> {
  NewsModel? categoryNews;
  bool isLoading = true;
  List<Article> articles = [];
  ScrollController scrollController = ScrollController();

  /// Function to get category data
  getCategoryNews(String category) async {
    try {
      NewsModel model = await CategoryNewsApi().getCategoryData(category);
      categoryNews = model;
      articles = model.articles;
      isLoading = false;
      setState(() {});
    } catch (error) {
      isLoading = false;
      setState(() {});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: ${error.toString()}")));
    }
  }

  @override
  void initState() {
    super.initState();
    getCategoryNews(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
            letterSpacing: 3,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (articles.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: h * 0.02),
                        CachedNetworkImage(
                          imageUrl: article.urlToImage ?? '',
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                        SizedBox(height: h * 0.02),
                        Text(
                          article.description ?? 'No description available',
                          style: const TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: h * 0.05),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
