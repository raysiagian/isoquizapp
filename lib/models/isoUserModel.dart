class User {
  final int id_User;
  final String username;
  final String email;
  final String phoneNumber;
  final String password;

  User({
    required this.id_User,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  static final listIsoUser = [
    User(
      id_User: 1, 
      username: 'Mitski', 
      email: 'mitski@gmail.com', 
      phoneNumber: '08123332234', 
      password: 'mitski12345'
    ),
  ];

}