import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:movies/providers.dart'; 

const delayTime = 1000 * 10;
const animationTime = 1000;


class HomeScreenImage extends ConsumerWidget {
  const HomeScreenImage({super.key});

  @override
  
  Widget build(BuildContext context, WidgetRef ref) {
    
    final images = ref.watch(movieImagesProvider);
    final screenWidth = MediaQuery.of(context).size.width - 32;

    return SizedBox(
      height: 374,
      child: Swiper(
        autoplayDelay: delayTime,
        duration: animationTime,
        itemWidth: screenWidth,
        autoplay: true,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return CachedNetworkImage(
            imageUrl: images[index],
            alignment: Alignment.topCenter,
            fit: BoxFit.fitHeight,
            height: 374,
            width: screenWidth,
            placeholder: (context, url) => Container(
              height: 374,
              width: screenWidth,
              color: const Color(0xFF1E1E1E),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white24,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              height: 374,
              width: screenWidth,
              color: const Color(0xFF1E1E1E),
              child: const Icon(
                Icons.movie,
                color: Colors.white38,
                size: 48,
              ),
            ),
          );
        },
      ),
    );
  }
}