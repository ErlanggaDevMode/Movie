import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movies/providers.dart';

class GenreScreen extends ConsumerStatefulWidget {
  const GenreScreen({super.key});

  @override
  ConsumerState<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends ConsumerState<GenreScreen> {
  final TextEditingController _searchController = TextEditingController();

  final FocusNode _searchFocusNode = FocusNode();

  String _searchQuery = '';
  bool _isGenreExpanded = true;
  Sorting _selectedSort = Sorting.aToZ;

  final List<GenreState> _genres = [
    GenreState(genre: 'Action'),
    GenreState(genre: 'Adventure'),
    GenreState(genre: 'Animation'),
    GenreState(genre: 'Biographical'),
    GenreState(genre: 'Comedy'),
    GenreState(genre: 'Crime'),
    GenreState(genre: 'Documentary'),
    GenreState(genre: 'Drama'),
    GenreState(genre: 'Fantasy'),
    GenreState(genre: 'Historical'),
    GenreState(genre: 'Horror'),
    GenreState(genre: 'Musical'),
    GenreState(genre: 'Mystery'),
    GenreState(genre: 'Noir'),
    GenreState(genre: 'Romance'),
    GenreState(genre: 'Science Fiction'),
    GenreState(genre: 'Sports'),
    GenreState(genre: 'Thriller'),
    GenreState(genre: 'War'),
    GenreState(genre: 'Western'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  List<GenreState> get _selectedGenres {
    return _genres.where((genre) => genre.isSelected).toList();
  }

  void _performSearch(String value) {
    setState(() {
      _searchQuery = value.trim();
    });

    _searchFocusNode.unfocus();
  }

  void _toggleGenre(int index, bool selected) {
    setState(() {
      _genres[index].isSelected = selected;
    });
  }

  void _clearSearch() {
    _searchController.clear();

    setState(() {
      _searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(movieImagesProvider);

    return SafeArea(
      child: Container(
        color: const Color(0xFF151515),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screen title
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Text(
                'Find a Movie',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Search field
            _buildSearchField(),

            const SizedBox(height: 12),

            // Genre selection
            _buildGenreSection(),

            const Divider(color: Color(0xFF424242), height: 24),

            // Sorting control
            _buildSortPicker(),

            const SizedBox(height: 8),

            // Movie list
            Expanded(child: _buildMovieList(images)),
          ],
        ),
      ),
    );
  }

  // Search field
  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        autocorrect: false,
        enableSuggestions: false,
        onSubmitted: _performSearch,
        decoration: InputDecoration(
          hintText: 'Movie name, genre',
          hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
          filled: true,
          fillColor: const Color(0xFF292929),
          prefixIcon: IconButton(
            onPressed: () {
              _performSearch(_searchController.text);
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          suffixIcon: IconButton(
            onPressed: _clearSearch,
            icon: const Icon(Icons.close, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white54),
          ),
        ),
      ),
    );
  }

  // Genre section
  Widget _buildGenreSection() {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        expandIconColor: Colors.white,
        expansionCallback: (index, isExpanded) {
          setState(() {
            _isGenreExpanded = isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            backgroundColor: const Color(0xFF151515),
            canTapOnHeader: true,
            isExpanded: _isGenreExpanded,
            headerBuilder: (context, isExpanded) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
                child: Row(
                  children: [
                    Text(
                      'Genres',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 22,
                      height: 22,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${_selectedGenres.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: SizedBox(
                height: 40,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.trackpad,
                    },
                  ),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _genres.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final genre = _genres[index];

                      return FilterChip(
                        label: Text(genre.genre),
                        selected: genre.isSelected,
                        backgroundColor: const Color(0xFF292929),
                        selectedColor: const Color(0xFF4A4A4A),
                        checkmarkColor: Colors.white,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: genre.isSelected
                                ? Colors.white24
                                : const Color(0xFF424242),
                          ),
                        ),
                        labelStyle: TextStyle(
                          color:
                              genre.isSelected ? Colors.white : Colors.white70,
                          fontSize: 13,
                        ),
                        onSelected: (selected) {
                          _toggleGenre(index, selected);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sorting picker
  Widget _buildSortPicker() {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            _selectedSort.label,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: Colors.white),
          ),
          PopupMenuButton<Sorting>(
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            color: const Color(0xFF292929),
            initialValue: _selectedSort,
            onSelected: (value) {
              setState(() {
                _selectedSort = value;
              });
            },
            itemBuilder: (context) {
              return Sorting.values.map((sort) {
                return CheckedPopupMenuItem<Sorting>(
                  value: sort,
                  checked: _selectedSort == sort,
                  child: Text(
                    sort.label,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }

  // Movie poster list
  Widget _buildMovieList(List<String> images) {
    final filteredImages = _searchQuery.isEmpty
        ? images
        : images.where((imageUrl) {
            final movieNumber = '${images.indexOf(imageUrl) + 1}';
            final query = _searchQuery.toLowerCase();
            return 'movie $movieNumber'.contains(query) ||
                imageUrl.toLowerCase().contains(query);
          }).toList();

    if (filteredImages.isEmpty) {
      return const Center(
        child: Text(
          'No movie images available.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: filteredImages.length,
      itemBuilder: (context, index) {
        final imageUrl = filteredImages[index];
        final originalIndex = images.indexOf(imageUrl);

        return GestureDetector(
          onTap: () {
            // Movie detail navigation can be added here.
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 140,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      imageUrl,
                      width: 100,
                      height: 140,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 140,
                          color: const Color(0xFF292929),
                          child: const Icon(
                            Icons.movie,
                            color: Colors.white54,
                            size: 36,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        Text(
                          'Movie ${originalIndex + 1}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Release year unavailable',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Genre state
class GenreState {
  final String genre;
  bool isSelected;

  GenreState({required this.genre, this.isSelected = false});
}

// Sorting options
enum Sorting {
  aToZ('A-Z'),
  zToA('Z-A'),
  rating('Rating'),
  year('Year');

  const Sorting(this.label);

  final String label;
}
