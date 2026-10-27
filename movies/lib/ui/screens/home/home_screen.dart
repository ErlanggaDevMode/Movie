import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/ui/screens/home/home_screen_image.dart';
import 'package:movies/ui/screens/home/horiz_movies.dart';
import 'package:movies/ui/screens/home/search_screen.dart';
import 'package:movies/ui/screens/home/title_row.dart';
import 'package:movies/ui/theme/theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(movieImagesProvider);

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: screenBackground,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Now Playing',
                        style: largeTitle,
                      ),
                      IconButton(
                        icon: const Icon(Icons.search_rounded, color: Colors.white, size: 26),
                        tooltip: 'Search movies',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: searchBarBackground,
                        borderRadius: BorderRadius.circular(23),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded, color: Colors.white54, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            'Search movies, genres, actors...',
                            style: body2Regular.copyWith(color: Colors.white38),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const HomeScreenImage(),

                TitleRow(
                  text: 'Trending',
                  onMoreClicked: () {},
                ),

                HorizontalMovies(
                  movies: images,
                ),

                TitleRow(
                  text: 'Popular',
                  onMoreClicked: () {},
                ),

                HorizontalMovies(
                  movies: images,
                ),

                TitleRow(
                  text: 'Top Rated',
                  onMoreClicked: () {},
                ),

                HorizontalMovies(
                  movies: images,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}