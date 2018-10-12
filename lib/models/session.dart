class Session{
  final int id;
  final String title;
  final String desc;
  final List<dynamic> speakers;

  Session({this.id, this.title, this.desc, this.speakers});

  factory Session.fromJson(Map<String, dynamic> json) {
    var description = (json['description'] != null && json['description'].trim() != "") ? json['description'] as String : "Pas de description pour cette session.";
    var speakers = json['speakers'] == null ? [] : json['speakers'] as List<dynamic>;
    return Session(
      id: json['id'] as int,
      title: json['title'] as String,
      desc: description,
      speakers: speakers,
    );
  }
}