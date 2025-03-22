// features/recipe/domain/entities/recipe.dart

class Recipe {
  final int id;
  final String? image;
  final String? title;
  final int? readyInMinutes;
  final int? servings;
  final String? sourceUrl;
  final String? sourceName;

  final int? aggregateLikes;
  final bool? vegetarian;
  final bool? vegan;
  final bool? glutenFree;
  final bool? dairyFree;
  final List<ExtendedIngredient>? extendedIngredients;
  final List<AnalyzedInstruction>? analyzedInstructions;

  Recipe({
    required this.id,
    this.image,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    this.sourceName,

    this.aggregateLikes,
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.extendedIngredients,
    this.analyzedInstructions,
  });
}

class ExtendedIngredient {
  final int id;
  final String aisle;
  final String image;
  final String consistency;
  final String name;
  final String nameClean;
  final String original;
  final String originalName;
  final String unit;
  final List<String> meta;

  ExtendedIngredient({
    required this.id,
    required this.aisle,
    required this.image,
    required this.consistency,
    required this.name,
    required this.nameClean,
    required this.original,
    required this.originalName,
    required this.unit,
    required this.meta,
  });
}

class AnalyzedInstruction {
  final String name;
  final List<InstructionStep> steps;

  AnalyzedInstruction({required this.name, required this.steps});
}

class InstructionStep {
  final int number;
  final String step;
  final List<Ingredient> ingredients;
  final List<Equipment> equipment;

  InstructionStep({
    required this.number,
    required this.step,
    required this.ingredients,
    required this.equipment,
  });
}

class Ingredient {
  final int id;
  final String name;
  final String localizedName;
  final String image;

  Ingredient({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.image,
  });
}

class Equipment {
  final int id;
  final String name;
  final String localizedName;
  final String image;

  Equipment({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.image,
  });
}
