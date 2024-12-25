import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quiz_iso_app/static/apiUrl.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/models/isoUserModel.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProflePageState();
}

class _ProflePageState extends State<ProfilePage> {
  late String _token;
  User? _loggedInUser;

  @override

  
  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchUser();
  }


  _loadTokenAndFetchUser() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // // String? token = await storage.read(key: 'access_token'); 
    // String? token = prefs.getString('access_token'); 

    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    if (token != null) {
      setState(() {
        _token = token;
      });
      print("Token found: $token");

      try {
        // Load user menggunakan token
        final user = await fetchUser(token);
        setState(() {
          _loggedInUser = user;
        });
      } catch (e) {
        print("Error fetching user: $e");
      }
    } else {
      print("No token found, redirecting to login");
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<User> fetchUser(String token) async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl + 'api/user'), // Pastikan endpoint benar
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return User.fromJson(jsonData);
      } else {
        throw Exception('Failed to load user: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching user: $e');
    }
  }


  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth,
              height: 250,
              child: _loggedInUser != null 
              ? Image.asset(
                  _loggedInUser!.gender == 'male' 
                      ? "assets/images/Male Profile Background.png" 
                      : _loggedInUser!.gender == 'female' 
                          ? "assets/images/Female Profile Background.png" 
                          : "assets/images/Male Profile Background.png",
                  fit: BoxFit.cover,
                )
              : SizedBox(),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                // Content Here
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _loggedInUser != null ? _loggedInUser!.username : '',
                        style: LocalTextStyle.textTheme.headlineSmall!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                        Text(
                        _loggedInUser != null ? _loggedInUser!.email : '',
                        style: LocalTextStyle.textTheme.titleSmall!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
         )
      ),
    );
  }
}