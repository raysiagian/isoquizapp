class User {
  final int id_User;
  final int id_Role;
  final String username;
  final String email;
  final String phoneNumber;
  // final String password;
  final String gender;
  final String is_Active;
  final String created_At;  // Changed to String
  final String updated_At;  // Changed to String

  User({
    required this.id_User,
    required this.id_Role,
    required this.username,
    required this.email,
    required this.phoneNumber,  
    // required this.password,
    required this.gender,
    required this.is_Active,
    required this.created_At,
    required this.updated_At,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id_User: json['id_User'] as int,
      id_Role: json['id_Role'] as int,
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      // password: json['password'] as String,
      gender: json['gender'] as String,
      is_Active:json['is_Active'] as String,
      created_At: json['created_At'] as String,
      updated_At: json['updated_At'] as String,
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id_User': id_User,
      'id_Role': id_Role,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      // 'password': password,  // Uncomment if password is needed
      'gender': gender,
      'is_Active': is_Active,
      'created_At': created_At,
      'updated_At': updated_At,
    };
  }
  
}