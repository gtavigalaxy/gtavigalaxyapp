import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/countdown_screen.dart';
import 'screens/search_screen.dart';
import 'services/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(const GtaviGalaxyApp());
}

class GtaviGalaxyApp extends StatelessWidget {
  const GtaviGalaxyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GTAVI Galaxy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0E0E16),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF2D78),
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFFFF2D78),
          secondary: const Color(0xFF9D4EDD),
          surface: const Color(0xFF16161F),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0E0E16),
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF16161F),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
        ),
      ),
      home: const MainNav(),
    );
  }
}

class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _index = 0;

  static const _screens = [
    HomeScreen(),
    CountdownScreen(),
    SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: const Color(0xFF0E0E16),
        indicatorColor: const Color(0xFFFF2D78).withValues(alpha: 0.2),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.newspaper_outlined),
            selectedIcon: Icon(Icons.newspaper),
            label: 'News',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer),
            label: 'Countdown',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
