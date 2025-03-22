// features/recipe/presentation/widgets/search_bar_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/recipe/presentation/bloc/recipe_bloc.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        controller: _searchController,
        hintText: 'Search Recipes',
        leading: const Icon(Icons.search),
        trailing: [
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                });
                _searchController.clear();
                BlocProvider.of<RecipeBloc>(
                  context,
                ).add(GetTrendingRecipesEvent());
              },
            ),
        ],
        onChanged: (value) {
          setState(() {
            _isSearching = value.isNotEmpty;
          });
          if (value.isNotEmpty) {
            BlocProvider.of<RecipeBloc>(context).add(GetRecipeListEvent(value));
          } else {
            BlocProvider.of<RecipeBloc>(context).add(GetTrendingRecipesEvent());
          }
        },
      ),
    );
  }
}
