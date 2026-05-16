import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uog_guide/screens/profile_screen.dart';

import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/gpa_screen.dart';
import 'screens/departments_screen.dart';
import 'firebase_options.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

Future<void> saveTheme(ThemeMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(
    'theme',
    mode == ThemeMode.dark ? 'dark' : 'light',
  );
}

Future<void> toggleTheme() async {
  if (themeNotifier.value == ThemeMode.light) {
    themeNotifier.value = ThemeMode.dark;
  } else {
    themeNotifier.value = ThemeMode.light;
  }
  await saveTheme(themeNotifier.value);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final savedTheme = prefs.getString('theme') ?? 'light';
  themeNotifier.value = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;

  runApp(const UOGGuideApp());
}

class UOGGuideApp extends StatelessWidget {
  const UOGGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'UOG Guide',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          home: const MainShell(),
        );
      },
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    GpaScreen(),
    DepartmentsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDark ? AppColors.darkSurface : AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'GPA',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.domain_outlined),
            activeIcon: Icon(Icons.domain),
            label: 'Departments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
