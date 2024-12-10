import 'package:flutter/material.dart';
import 'package:quiz_iso_app/routes/appRouteConstants.dart';
import 'package:quiz_iso_app/routes/appRouter.dart';
import 'package:quiz_iso_app/views/mainScreen/quizScreen/pages/quizResultPage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      title: 'Iso App',
      initialRoute: AppRouteConstants.loginPage, // Set rute awal
      onGenerateRoute: AppRouter.onGenerateRoute, // Gunakan AppRouter
    );
  }
}
