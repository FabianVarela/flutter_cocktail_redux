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
