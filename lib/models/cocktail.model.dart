class CocktailCategory {
  final String category;

  CocktailCategory(this.category);

  CocktailCategory.fromJson(Map<String, dynamic> json)
      : this.category = json['strCategory'];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'strCategory': this.category};
  }
}
