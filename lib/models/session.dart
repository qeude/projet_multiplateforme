class Session{
  final int id;
  final String title;
  final String titleMobile;

  Session({this.id, this.title, this.titleMobile});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] as int,
      title: json['title'] as String,
      titleMobile: json['titleMobile'] as String,
    );
  }
}