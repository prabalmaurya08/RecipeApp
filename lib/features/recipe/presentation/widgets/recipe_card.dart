// features/recipe/presentation/widgets/recipe_card_widget.dart

import 'package:flutter/material.dart';
import 'package:recipe_app/features/recipe/domain/entities/recipe.dart';
import 'package:recipe_app/features/recipe/presentation/pages/recipe_detail_screen.dart';

class RecipeCardWidget extends StatelessWidget {
  final Recipe recipe;

  const RecipeCardWidget({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0), // Add margin for spacing
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailScreen(recipeId: recipe.id),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Stack(
                children: [
                  recipe.image != null
                      ? Image.network(
                        recipe.image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.error),
                        loadingBuilder: (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value:
                                  loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                            ),
                          );
                        },
                      )
                      : Container(
                        height: 150,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    height: 150,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recipe.title ?? 'No Title',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2, // Limit title lines
                overflow: TextOverflow.ellipsis, // Add ellipsis if overflow
              ),
            ),
            // Add other recipe details here, like rating, cooking time, etc.
          ],
        ),
      ),
    );
  }
}
