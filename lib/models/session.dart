class Session{
  final int id;
  final String title;
  final String desc;

  Session({this.id, this.title, this.desc});

  factory Session.fromJson(Map<String, dynamic> json) {
    var description = (json['description'] != null && json['description'].trim() != "") ? json['description'] as String : "Pas de description pour cette session.";
    return Session(
      id: json['id'] as int,
      title: json['title'] as String,
      desc: description,
    );
  }
}