import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cradle/common/globals.dart';
import 'package:cradle/common/widgets.dart';
import 'package:cradle/core/news_api.dart';
import 'package:cradle/model/news_model.dart';
import 'package:cradle/screens/full_view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../common/pictures.dart';
import '../main.dart';
import 'category_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsModel? newsModel;
  bool isLoading = false;
  int currentIndex = 0;
  String? errorMessage;
  List<Article> articles = [];
  ScrollController scrollController = ScrollController();

  /// For category selection
  final List<dynamic> categories = [
    {'name': 'Business', 'image': Pictures.business},
    {'name': 'Health', 'image': Pictures.health},
    {'name': 'General', 'image': Pictures.general},
    {'name': 'Sports', 'image': Pictures.sports},
    {'name': 'Entertainment', 'image': Pictures.entertainment},
  ];

  final String profileImageUrl = "https://example.com/profile-image.jpg";
  final String email = "user@example.com";

  /// Function to get News data
  getNewsData(String news) async {
    try {
      NewsModel model = await NewsApi().getNewsData(news);
      newsModel = model;
      articles = model.articles;
      isLoading = false;
      setState(() {});
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: ${error.toString()}")));
      isLoading = false;
      throw Exception(error.toString());
    }
  }

  @override
  void initState() {
    isLoading = true;
    getNewsData("");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? getLateLoading() :
    Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "NEWS",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
            letterSpacing: 3,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              SizedBox(height: w * 0.05),
              Text(
                email,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: w * 0.05),
              ListTile(
                title: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: w * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(w * 0.02),
                  ),
                  child: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text(
                          "Are You Sure\nYou Want to Log Out?",
                          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () {

                            },
                            child: const Text(
                              "Confirm",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          CupertinoDialogAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(top: w * 0.03),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: w * 0.02, right: w * 0.02),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          getGreeting(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text(DateFormat('E, MMMM  d, yyy').format(today),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: w * 0.05),
              Container(
                height: 200,
                color: CupertinoColors.black,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CategoryScreens(
                                    name: categories[index]['name']),
                              ));
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                categories[index]['image'],
                                height: 200,
                                width: 300,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: SizedBox(
                                      height: 200,
                                      width: 300,
                                      child: Text(
                                        "Image Unavailable...",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  categories[index]['name'].toString(),
                                  style: const TextStyle(
                                    color: CupertinoColors.lightBackgroundGray,
                                    fontSize: 20,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 5);
                  },
                ),
              ),
              SizedBox(height: w * 0.05),
              Padding(
                padding: EdgeInsets.only(left: w * 0.02, top: w * 0.02),
                child: const Row(
                  children: [
                    Text(
                      "Top Headlines",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: w * 0.03),
              CarouselSlider.builder(
                itemCount: articles.take(7).length,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    currentIndex = index;
                    setState(() {
                    });
                  },
                  autoPlay: true,
                  aspectRatio: 1.5,
                  viewportFraction: 1,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                ),
                itemBuilder: (context, index, realIndex) {
                  final article = articles[index];
                  return Container(
                    margin: EdgeInsets.all(w*0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w*0.03),
                      image: DecorationImage(
                        image: NetworkImage(article.urlToImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.black54,
                        padding: EdgeInsets.all(w*0.03),
                        child: Text(
                          article.title,
                          style: const TextStyle(color: Colors.white, fontSize: 15),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: w * 0.01),
              AnimatedSmoothIndicator(
                activeIndex: currentIndex,
                count: articles.take(7).length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 2,
                  spacing: 5,
                ),
              ),
              SizedBox(height: w * 0.05),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(w * 0.05),
                        topRight: Radius.circular(w * 0.05)),
                    color: Colors.white),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.02, top: w * 0.02),
                      child: const Row(
                        children: [
                          Text(
                            "Trending News",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: w * 0.03),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => FullViewScreen(
                                    article: article,
                                  ),
                                ));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: EdgeInsets.all(w * 0.03),
                            margin: EdgeInsets.all(w * 0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[400],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(0, 4),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (article.urlToImage != null &&
                                    article.urlToImage!.isNotEmpty)
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(w * 0.03),
                                    child: CachedNetworkImage(
                                      imageUrl: article.urlToImage!,
                                      placeholder: (context, url) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            height: 100,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey
                                                    .withOpacity(0.4)),
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return const Text(
                                          "Error loading image...!",
                                          style: TextStyle(color: Colors.black),
                                        );
                                      },
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                SizedBox(height: h * 0.02),
                                Text(
                                  article.title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: h * 0.02),
                                Text(
                                  "By ${article.author ?? 'Unknown'}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic),
                                ),
                                SizedBox(height: h * 0.02),
                                Text(
                                  article.description ??
                                      "No description available",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: w * 0.01);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}