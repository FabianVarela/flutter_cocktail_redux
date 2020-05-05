class Alert {
  final String type;
  final String title;
  final String message;

  Alert({
    this.type = '',
    this.title = '',
    this.message = '',
  });

  Alert.fromJson(Map<String, dynamic> json)
      : this.type = json['icon'],
        this.title = json['title'],
        this.message = json['message'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = Map<String, dynamic>();

    json['type'] = this.type;
    json['title'] = this.title;
    json['message'] = this.message;

    return json;
  }
}
