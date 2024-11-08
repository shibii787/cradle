import 'package:cached_network_image/cached_network_image.dart';
import 'package:cradle/model/news_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../main.dart';

class FullViewScreen extends StatefulWidget {
  final Article article;
  const FullViewScreen({
    super.key,
    required this.article,
  });

  @override
  State<FullViewScreen> createState() => _FullViewScreenState();
}

class _FullViewScreenState extends State<FullViewScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(CupertinoIcons.back, color: Colors.white)),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Trending News",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 3,
            ),
          )),
      body: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.article.urlToImage != null &&
                    widget.article.urlToImage!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(w * 0.03),
                    child: CachedNetworkImage(
                      imageUrl: widget.article.urlToImage!,
                      placeholder: (context, url) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 100,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.4)),
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return const Text(
                          "Error loading image...!",
                          style: TextStyle(color: Colors.black),
                        );
                      },
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                SizedBox(height: h * 0.03),
                Text(
                  widget.article.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: h * 0.03),
                Text(
                  "By ${widget.article.author ?? 'Unknown'}",
                  style: const TextStyle(
                      fontSize: 14, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: h * 0.02),
                Text(
                  widget.article.description ?? "No description available",
                ),
                SizedBox(height: h * 0.01),
                Text(
                  widget.article.content,
                ),
              ],
            ),
          )),
    );
  }
}
