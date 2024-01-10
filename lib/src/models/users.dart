class User {
  final int? externalId;
  final String username;
  final String email;

  const User({
    required this.externalId,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      externalId: json['externalId'],
      username: json['username'],
      email: json['email'],
    );
  }

  factory User.fromApi(Map<String, dynamic> json) {
    return User(
      externalId: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  dynamic toJson() {
    return {
      'externalId': externalId,
      'username': username,
      'email': email,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
