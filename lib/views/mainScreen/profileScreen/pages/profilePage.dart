import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quiz_iso_app/static/apiUrl.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/models/isoUserModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

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
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'access_token');

    if (token != null) {
      setState(() {
        _token = token;
      });
      print("Token found: $token");

      // Coba memuat user dari cache terlebih dahulu
      final cachedUser = await loadUserFromCache();
      if (cachedUser != null) {
        setState(() {
          _loggedInUser = cachedUser;
        });
        print("Loaded user from cache");
      } else {
        // Jika tidak ada di cache, fetch dari API
        try {
          final user = await fetchUser(token);
          setState(() {
            _loggedInUser = user;
          });
          await saveUserToCache(user);
        } catch (e) {
          print("Error fetching user: $e");
        }
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

  Future<void> saveUserToCache(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(user.toJson());
    await prefs.setString('cachedUser', userData);
  }

   Future<User?> loadUserFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedUser');
    if (cachedData != null) {
      final jsonData = jsonDecode(cachedData);
      return User.fromJson(jsonData);
    }
    return null;
  }



  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
     String formattedJoinDate = 'Unknown';
  
  if (_loggedInUser != null && _loggedInUser!.created_At.isNotEmpty) {
    try {
      DateTime joinDate = DateTime.parse(_loggedInUser!.created_At);
      formattedJoinDate = DateFormat('dd MMMM yyyy').format(joinDate);
    } catch (e) {
      print('Error parsing date: $e');
    }
  }
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
                       const SizedBox(height: 8),
                        Text(
                         "Bergabung: $formattedJoinDate",
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