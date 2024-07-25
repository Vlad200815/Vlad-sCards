class MyUser {
  final String id;
  final String email;
  String? password;

  MyUser({
    this.password,
    required this.id,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'password': password};
  }

  MyUser copyWith({
    String? id,
    String? email,
    String? password,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
