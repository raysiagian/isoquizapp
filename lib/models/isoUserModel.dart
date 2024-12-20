class User {
  final int id_User;
  final int id_Role;
  final String username;
  final String email;
  final String phoneNumber;
  final String password;
  final String gender;
  final String created_At;  // Changed to String
  final String updated_At;  // Changed to String

  User({
    required this.id_User,
    required this.id_Role,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.gender,
    required this.created_At,
    required this.updated_At,
  });

  // static final listIsoUser = [
  //   User(
  //     id_User: 1, 
  //     username: 'Mitski', 
  //     email: 'mitski@gmail.com', 
  //     phoneNumber: '08123332234', 
  //     password: 'mitski12345'
  //   ),
  // ];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id_User: json['id_User'] as int,
      id_Role: json['id_Role'] as int,
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      gender: json['gender'] as String,
      created_At: json['created_At'] as String,
      updated_At: json['updated_At'] as String,
    );
  }

}