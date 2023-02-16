import 'package:cached_network_image/cached_network_image.dart';
import 'package:cyphercity/utilities/colors.dart';
import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

import '../models/news.dart';
import '../utilities/config.dart';

class DetailArticleScreen extends StatelessWidget {
  const DetailArticleScreen({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.redPurple,
        title: Text(news.judul),
        elevation: 0,
      ),
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: "$baseImageUrlNews/${news.gambar}",
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.35,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        news.deskripsi,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              height: 1.2,
                            ),
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
