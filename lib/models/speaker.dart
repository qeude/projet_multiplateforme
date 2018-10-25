class Speaker{
  final String id;
  final String name;
  final String company;
  final String bio;
  final String shortBio;
  final String avatar;

  Speaker({this.id, this.name, this.company, this.bio, this.shortBio, this.avatar});

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      id: json['id'].toString(),
      name: json['name'] as String,
      company: (json['company'] != null) ? json['company'] as String : " ",
      bio: json['bio'] as String,
      shortBio: json['shortBio'] as String,
      avatar: json['photoUrl'] as String,
    );
  }
}