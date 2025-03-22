// features/recipe/data/models/recipe_model.dart

import 'package:recipe_app/features/recipe/domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({
    required int id,
    String? image,
    String? title,
    int? readyInMinutes,
    int? servings,
    String? sourceUrl,
    String? sourceName,

    int? aggregateLikes,
    bool? vegetarian,
    bool? vegan,
    bool? glutenFree,
    bool? dairyFree,
    List<ExtendedIngredient>? extendedIngredients,
    List<AnalyzedInstruction>? analyzedInstructions,
  }) : super(
         id: id,
         image: image,
         title: title,
         readyInMinutes: readyInMinutes,
         servings: servings,
         sourceUrl: sourceUrl,
         sourceName: sourceName,

         aggregateLikes: aggregateLikes,
         vegetarian: vegetarian,
         vegan: vegan,
         glutenFree: glutenFree,
         dairyFree: dairyFree,
         extendedIngredients: extendedIngredients,
         analyzedInstructions: analyzedInstructions,
       );

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    print("Id from JSON: ${json['id']}");
    print("Servings from JSON: ${json['servings']}");
    print("readyInMinutes from JSON: ${json['readyInMinutes']}");

    return RecipeModel(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      sourceUrl: json['sourceUrl'],
      sourceName: json['sourceName'],

      aggregateLikes: json['aggregateLikes'],
      vegetarian: json['vegetarian'],
      vegan: json['vegan'],
      glutenFree: json['glutenFree'],
      dairyFree: json['dairyFree'],
      extendedIngredients:
          (json['extendedIngredients'] as List?)
              ?.map(
                (ingredient) => ExtendedIngredient(
                  id: ingredient['id'],
                  aisle: ingredient['aisle'],
                  image: ingredient['image'],
                  consistency: ingredient['consistency'],
                  name: ingredient['name'],
                  nameClean: ingredient['nameClean'],
                  original: ingredient['original'],
                  originalName: ingredient['originalName'],
                  unit: ingredient['unit'],
                  meta:
                      (ingredient['meta'] as List?)
                          ?.map((meta) => meta.toString())
                          .toList() ??
                      [],
                ),
              )
              .toList(),
      analyzedInstructions:
          (json['analyzedInstructions'] as List?)
              ?.map(
                (instruction) => AnalyzedInstruction(
                  name: instruction['name'] ?? '',
                  steps:
                      (instruction['steps'] as List?)
                          ?.map(
                            (step) => InstructionStep(
                              number: step['number'],
                              step: step['step'] ?? '',
                              ingredients:
                                  (step['ingredients'] as List?)
                                      ?.map(
                                        (ing) => Ingredient(
                                          id: ing['id'],
                                          name: ing['name'] ?? '',
                                          localizedName:
                                              ing['localizedName'] ?? '',
                                          image: ing['image'] ?? '',
                                        ),
                                      )
                                      .toList() ??
                                  [],
                              equipment:
                                  (step['equipment'] as List?)
                                      ?.map(
                                        (eq) => Equipment(
                                          id: eq['id'],
                                          name: eq['name'] ?? '',
                                          localizedName:
                                              eq['localizedName'] ?? '',
                                          image: eq['image'] ?? '',
                                        ),
                                      )
                                      .toList() ??
                                  [],
                            ),
                          )
                          .toList() ??
                      [],
                ),
              )
              .toList(),
    );
  }
}
