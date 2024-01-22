class User {
  int? id;
  String username;
  String password;
  String phoneNumber; // Add this line

  User(
      {this.id,
      required this.username,
      required this.password,
      required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'phone_number': phoneNumber,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      phoneNumber: map['phone_number'],
    );
  }

  User copyWith(
      {int? id, String? username, String? password, String? phoneNumber}) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
