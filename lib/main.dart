import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'providers/auth_provider.dart';
import 'providers/task_provider.dart';
import 'providers/user_provider.dart';
import 'services/local_storage_service.dart';
import 'routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await LocalStorageService().initHive();

  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.containsKey('token');

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Management App',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            titleLarge: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            bodyMedium: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                color: Colors.white70),
          ),
        ),
        initialRoute: isLoggedIn ? '/tasks' : '/login',
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
