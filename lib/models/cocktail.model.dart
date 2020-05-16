class CocktailCategory {
  final String category;

  CocktailCategory(this.category);

  CocktailCategory.fromJson(Map<String, dynamic> json)
      : this.category = json['strCategory'];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'strCategory': this.category};
  }
}

class Cocktail {
  final String id;
  final String name;
  final String image;

  Cocktail(this.id, this.name, this.image);

  Cocktail.fromJson(Map<String, dynamic> json)
      : this.id = json['idDrink'],
        this.name = json['strDrink'],
        this.image = json['strDrinkThumb'];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idDrink': this.id,
      'strDrink': this.name,
      'strDrinkThumb': this.image,
    };
  }
}

class CocktailDetail {
  final String id;
  final String name;
  final String category;
  final bool isAlcoholic;
  final String glass;
  final String instruction;
  final List<String> ingredients;
  final List<String> measures;

  CocktailDetail(this.id, this.name, this.category, this.isAlcoholic,
      this.glass, this.instruction, this.ingredients, this.measures);

  CocktailDetail.fromJson(Map<String, dynamic> json)
      : this.id = json['idDrink'],
        this.name = json['strDrink'],
        this.category = json['strCategory'],
        this.isAlcoholic = json['strAlcoholic'] == 'Alcoholic',
        this.glass = json['strGlass'],
        this.instruction = json['strInstructions'],
        this.ingredients = List<String>.generate(
            15, (int index) => json['strIngredient${index + 1}']),
        this.measures = List<String>.generate(
            15, (int index) => json['strMeasure${index + 1}']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{
      'idIngredient': this.id,
      'strIngredient': this.name,
      'strCategory': this.category,
      'strAlcoholic': this.isAlcoholic ? 'Alcoholic' : 'Non alcoholic',
      'strGlass': this.glass,
      'strInstructions': this.instruction,
    };

    this.ingredients.asMap().forEach(
        (int index, String item) => map['strIngredient${index + 1}'] = item);
    this.measures.asMap().forEach(
        (int index, String item) => map['strMeasure${index + 1}'] = item);

    return map;
  }
}
