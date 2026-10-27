import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/providers.dart';
import 'package:movies/ui/theme/theme.dart';

/// Data model representing a movie item in the search catalog.
class MovieModel {
  final String title;
  final String imageUrl;
  final String genre;
  final double rating;
  final int year;
  final String duration;
  final String overview;

  const MovieModel({
    required this.title,
    required this.imageUrl,
    required this.genre,
    required this.rating,
    required this.year,
    required this.duration,
    required this.overview,
  });
}

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  String _searchQuery = '';
  String _selectedGenre = 'All';

  final List<String> _genres = const [
    'All',
    'Action',
    'Sci-Fi',
    'Animation',
    'Adventure',
    'Comedy',
    'Crime',
    'Biography',
    'Fantasy',
  ];

  final List<String> _recentSearches = [
    'Oppenheimer',
    'Spider-Man',
    'Dune',
    'The Batman',
    'Interstellar',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  /// Builds movie list dynamically based on images from [movieImagesProvider].
  List<MovieModel> _buildMovieList(List<String> images) {
    final titles = [
      'The Creator',
      'Oppenheimer',
      'Dune: Part Two',
      'Spider-Man: Across the Spider-Verse',
      'The Batman',
      'Barbie',
      'Interstellar',
      'Avatar: The Way of Water',
      'Guardians of the Galaxy Vol. 3',
      'John Wick: Chapter 4',
      'Top Gun: Maverick',
      'Inception',
      'Avengers: Endgame',
      'Poor Things',
      'Mission: Impossible - Dead Reckoning',
      'The Dark Knight',
      'Killers of the Flower Moon',
      'Blade Runner 2049',
      'Wonka',
      'Spider-Man: No Way Home',
    ];

    final genres = [
      'Sci-Fi',
      'Biography',
      'Sci-Fi',
      'Animation',
      'Action',
      'Comedy',
      'Sci-Fi',
      'Adventure',
      'Action',
      'Action',
      'Action',
      'Sci-Fi',
      'Action',
      'Comedy',
      'Action',
      'Action',
      'Crime',
      'Sci-Fi',
      'Fantasy',
      'Action',
    ];

    final ratings = [
      7.1, 8.9, 8.6, 8.7, 7.8, 6.9, 8.7, 7.6, 7.9, 7.7,
      8.3, 8.8, 8.4, 7.9, 7.7, 9.0, 7.6, 8.0, 7.0, 8.2,
    ];

    final years = [
      2023, 2023, 2024, 2023, 2022, 2023, 2014, 2022, 2023, 2023,
      2022, 2010, 2019, 2023, 2023, 2008, 2023, 2017, 2023, 2021,
    ];

    final durations = [
      '2h 13m', '3h 0m', '2h 46m', '2h 20m', '2h 56m',
      '1h 54m', '2h 49m', '3h 12m', '2h 30m', '2h 49m',
      '2h 10m', '2h 28m', '3h 1m', '2h 21m', '2h 43m',
      '2h 32m', '3h 26m', '2h 44m', '1h 56m', '2h 28m',
    ];

    final overviews = [
      'As a future war between the human race and artificial intelligence rages on, an ex-soldier finds a secret weapon.',
      'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.',
      'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
      'Miles Morales catapults across the Multiverse, where he encounters a team of Spider-People charged with protecting its existence.',
      'When a sadistic serial killer begins murdering key political figures in Gotham, Batman is forced to investigate.',
      'To live in Barbie Land is to be a perfect being in a perfect place. Unless you have a full-on existential crisis.',
      'When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot is tasked to pilot a spacecraft to find a new planet.',
      'Jake Sully lives with his newfound family formed on the extrasolar moon Pandora once a familiar threat returns.',
      'Still reeling from the loss of Gamora, Peter Quill rallies his team to defend the universe and one of their own.',
      'John Wick uncovers a path to defeating The High Table, but before he can earn his freedom, he must face a new enemy.',
      'After thirty years, Maverick is still pushing the envelope as a top naval aviator, training a detachment of graduates.',
      'A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea.',
      'After the devastating events of Infinity War, the universe is in ruins, and the Avengers assemble once more.',
      'The incredible tale about the fantastical evolution of Bella Baxter, a young woman brought back to life by a brilliant scientist.',
      'Ethan Hunt and his IMF team must track down a dangerous weapon before it falls into the wrong hands.',
      'When the menace known as the Joker wreaks havoc and chaos on Gotham, Batman must accept one of his greatest tests.',
      'Members of the Osage tribe in northeastern Oklahoma are murdered under mysterious circumstances in the 1920s.',
      'Young Blade Runner K unearths a long-buried secret that leads him to track down former Blade Runner Rick Deckard.',
      'Armed with nothing but a hatful of dreams, young Willy Wonka strives to become the greatest chocolatier in the world.',
      'With Spider-Man\'s identity revealed, Peter asks Doctor Strange for help, unraveling the multiverse.',
    ];

    return List.generate(images.length, (index) {
      return MovieModel(
        title: index < titles.length ? titles[index] : 'Movie ${index + 1}',
        imageUrl: images[index],
        genre: index < genres.length ? genres[index] : 'Action',
        rating: index < ratings.length ? ratings[index] : 8.0,
        year: index < years.length ? years[index] : 2023,
        duration: index < durations.length ? durations[index] : '2h 00m',
        overview: index < overviews.length
            ? overviews[index]
            : 'Experience the thrilling cinematic journey packed with drama, action, and suspense.',
      );
    });
  }

  void _onTagSelected(String tag) {
    _searchController.text = tag;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: tag.length),
    );
  }

  void _showMovieDetails(MovieModel movie) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 20,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: movie.imageUrl,
                      width: 100,
                      height: 140,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: searchBarBackground,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: searchBarBackground,
                        child: const Icon(Icons.broken_image, color: Colors.white54),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: heading2.copyWith(fontSize: 19),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              movie.rating.toString(),
                              style: body2Bold.copyWith(color: Colors.amber),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                movie.genre,
                                style: caption.copyWith(color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${movie.year} • ${movie.duration}',
                          style: caption.copyWith(color: Colors.white54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Storyline',
                style: body1Bold,
              ),
              const SizedBox(height: 6),
              Text(
                movie.overview,
                style: body2Regular.copyWith(color: Colors.white70, height: 1.4),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Watch Trailer', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton.filledTonal(
                    style: IconButton.styleFrom(
                      backgroundColor: searchBarBackground,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(14),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added "${movie.title}" to Favorites'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.favorite_border_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(movieImagesProvider);
    final allMovies = _buildMovieList(images);

    // Filter movies by search query and genre
    final filteredMovies = allMovies.where((movie) {
      final matchesQuery = _searchQuery.isEmpty ||
          movie.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          movie.genre.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          movie.year.toString().contains(_searchQuery);

      final matchesGenre = _selectedGenre == 'All' ||
          movie.genre.toLowerCase() == _selectedGenre.toLowerCase();

      return matchesQuery && matchesGenre;
    }).toList();

    return Scaffold(
      backgroundColor: screenBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Search Bar Section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              child: Row(
                children: [
                  if (Navigator.canPop(context)) ...[
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                      tooltip: 'Back',
                    ),
                    const SizedBox(width: 4),
                  ],
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: searchBarBackground,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: _searchFocusNode.hasFocus
                              ? const Color(0xFF2196F3).withValues(alpha: 0.8)
                              : Colors.white10,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.white54,
                              size: 22,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              focusNode: _searchFocusNode,
                              style: body1Regular.copyWith(color: Colors.white),
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {
                                if (value.isNotEmpty && !_recentSearches.contains(value)) {
                                  setState(() {
                                    _recentSearches.insert(0, value);
                                  });
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Search movies, genres, years...',
                                hintStyle: TextStyle(
                                  color: Colors.white38,
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          if (_searchQuery.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.close_rounded, color: Colors.white54, size: 20),
                              onPressed: () {
                                _searchController.clear();
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Horizontal Genre Filter Chips
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _genres.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final genre = _genres[index];
                  final isSelected = genre == _selectedGenre;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedGenre = genre;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2196F3) : searchBarBackground,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF2196F3) : Colors.white12,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        genre,
                        style: body2Bold.copyWith(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // Content Area: Recent Searches / Filtered Movie Grid / Empty State
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _buildBody(filteredMovies),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(List<MovieModel> filteredMovies) {
    // If user is not searching and "All" genre is selected, show recent searches + all movies
    if (_searchQuery.isEmpty && _selectedGenre == 'All') {
      return CustomScrollView(
        key: const ValueKey('default_state'),
        slivers: [
          if (_recentSearches.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recent Searches', style: body1Bold),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _recentSearches.clear();
                        });
                      },
                      child: Text(
                        'Clear all',
                        style: caption.copyWith(color: Colors.white54),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _recentSearches.map((term) {
                    return InkWell(
                      onTap: () => _onTagSelected(term),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: searchBarBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.history_rounded, size: 15, color: Colors.white54),
                            const SizedBox(width: 6),
                            Text(term, style: caption.copyWith(color: Colors.white70)),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _recentSearches.remove(term);
                                });
                              },
                              child: const Icon(Icons.close_rounded, size: 14, color: Colors.white38),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  Text('Popular Movies', style: heading2),
                  const Spacer(),
                  Text('${filteredMovies.length} movies', style: caption.copyWith(color: Colors.white54)),
                ],
              ),
            ),
          ),

          _buildMovieGrid(filteredMovies),
        ],
      );
    }

    // If movies are found for query / genre filter
    if (filteredMovies.isNotEmpty) {
      return CustomScrollView(
        key: const ValueKey('results_state'),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  Text(
                    _searchQuery.isNotEmpty ? 'Results for "$_searchQuery"' : '$_selectedGenre Movies',
                    style: heading2,
                  ),
                  const Spacer(),
                  Text(
                    '${filteredMovies.length} found',
                    style: caption.copyWith(color: const Color(0xFF2196F3)),
                  ),
                ],
              ),
            ),
          ),
          _buildMovieGrid(filteredMovies),
        ],
      );
    }

    // No movies found state
    return Center(
      key: const ValueKey('empty_state'),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: searchBarBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white10),
                ),
                child: const Icon(
                  Icons.search_off_rounded,
                  size: 40,
                  color: Colors.white38,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'No movies found',
                style: heading2,
              ),
              const SizedBox(height: 8),
              Text(
                'We couldn\'t find any matches for "${_searchQuery.isNotEmpty ? _searchQuery : _selectedGenre}". Check your spelling or try another keyword.',
                textAlign: TextAlign.center,
                style: body2Regular.copyWith(color: Colors.white54),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: searchBarBackground,
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                    _selectedGenre = 'All';
                  });
                },
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Reset filters'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieGrid(List<MovieModel> movies) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.62,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final movie = movies[index];
            return _MovieCard(
              movie: movie,
              onTap: () => _showMovieDetails(movie),
            );
          },
          childCount: movies.length,
        ),
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback onTap;

  const _MovieCard({
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: searchBarBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: movie.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: searchBarBackground,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: searchBarBackground,
                      child: const Icon(Icons.broken_image, color: Colors.white38),
                    ),
                  ),
                  // Dark gradient at bottom of poster
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            searchBarBackground,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Rating badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                          const SizedBox(width: 3),
                          Text(
                            movie.rating.toString(),
                            style: caption.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: body2Bold.copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        movie.genre,
                        style: caption.copyWith(color: Colors.white54, fontSize: 11),
                      ),
                      Text(
                        movie.year.toString(),
                        style: caption.copyWith(color: Colors.white38, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
