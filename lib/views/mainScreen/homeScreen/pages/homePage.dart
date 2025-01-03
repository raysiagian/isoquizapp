import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quiz_iso_app/models/isoQuizCategoryModel.dart';
import 'package:quiz_iso_app/static/apiUrl.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';
import 'package:quiz_iso_app/views/mainScreen/homeScreen/widget/quizCardWidget.dart';
import 'package:quiz_iso_app/views/mainScreen/homeScreen/widget/totalScoreandRanks.dart';
import 'package:quiz_iso_app/models/isoUserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({
    Key? key, 
    required this.token,
  }) :super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _token;
  User? _loggedInUser;
  


  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchUser();
  }


  // _loadTokenAndFetchUser() async {
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // // String? token = await storage.read(key: 'access_token'); 
  //   // String? token = prefs.getString('access_token'); 

  //   final storage = FlutterSecureStorage();
  //   String? token = await storage.read(key: 'access_token');

  //   if (token != null) {
  //     setState(() {
  //       _token = token;
  //     });
  //     print("Token found: $token");

  //     try {
  //       // Load user menggunakan token
  //       final user = await fetchUser(token);
  //       setState(() {
  //         _loggedInUser = user;
  //       });
  //     } catch (e) {
  //       print("Error fetching user: $e");
  //     }
  //   } else {
  //     print("No token found, redirecting to login");
  //     Navigator.pushReplacementNamed(context, '/login');
  //   }
  // }

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


  Future<List<IsoQuizCategoryModel>> fetchCategory() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedCategories');

    if (cachedData != null) {
      // Parse data dari cache
      final jsonData = jsonDecode(cachedData) as List<dynamic>;
      final cachedCategories =
          jsonData.map((e) => IsoQuizCategoryModel.fromJson(e)).toList();

      // Lakukan refresh cache di latar belakang
      refreshCategoryDataInBackground();

      // Kembalikan data cache
      return cachedCategories;
    } else {
      // Jika tidak ada cache, fetch dari API
      final categoryList = await fetchCategoryFromApi();
      await cacheCategoryData(categoryList);
      return categoryList;
    }
  }


    Future<List<IsoQuizCategoryModel>> fetchCategoryFromApi() async {
    try {
      final response = await http.get(Uri.parse(apiUrl + 'api/getCategory'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['data'] as List<dynamic>;
        return jsonData.map((e) => IsoQuizCategoryModel.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to load category from API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching category: $e');
    }
  }

    Future<void> cacheCategoryData(List<IsoQuizCategoryModel> categoryList) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = categoryList.map((e) => e.toJson()).toList();
    prefs.setString('cachedCategories', jsonEncode(jsonData));
  }

  Future<void> refreshCategoryDataInBackground() async {
    try {
      final categoryList = await fetchCategoryFromApi();
      await cacheCategoryData(categoryList);
    } catch (e) {
      print("Background refresh failed: $e");
    }
  }

    
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),  
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              SizedBox(height: 10),
              Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: _loggedInUser != null ? Image.asset(
                          _loggedInUser!.gender == 'male' ? "assets/images/Male Icon Home.png" :
                          _loggedInUser!.gender == 'female' ? "assets/images/Female Icon Home.png" :
                          "assets/images/Male Icon Home.png",
                          fit: BoxFit.cover,
                        ) : SizedBox(),
                      ),
                      // radius: 20, // Ukuran lingkaran
                      // backgroundImage: AssetImage('assets/images/male.png'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _loggedInUser != null ? _loggedInUser!.username : '',
                          style: LocalTextStyle.textTheme.headlineSmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                         Text(
                          _loggedInUser != null ? _loggedInUser!.email : '',
                          style: LocalTextStyle.textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
          backgroundColor: LocalColorsStyle.primaryColor,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30, left: screenWidth * 0.08, right: screenWidth * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Data lainnya di atas ListView.builder
              TotalScoreandRanksWidget(),
              const SizedBox(height: 20),
            FutureBuilder<List<IsoQuizCategoryModel>>(
              future: fetchCategory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child:
                        Text('Error fetching category: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final categoryList = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      final category = categoryList[index];
                      return QuizCardWidget(
                        isoquizcategorymodel: category,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No categories available.'),
                  );
                }
              },
            ),

              // Data lainnya di bawah ListView.builder
              const SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
    );
  }
}
