import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:somethink/screens/game_screen.dart';
import 'package:somethink/screens/settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                ),
                icon: IconTheme(
                  data: Theme.of(context).iconTheme,
                  child: const Icon(
                    Icons.settings,
                    size: 30,
                  ),
                ),
              ),
            ),
            const Spacer(),
            IconTheme(
              data: Theme.of(context).iconTheme,
              child: const Icon(Icons.spatial_tracking_outlined, size: 200),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.deepOrange,
                  minimumSize: Size(size.width * 0.7, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide.none,
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  PageTransition(
                    child: const GameScreen(),
                    type: PageTransitionType.fade,
                  ),
                ),
                child: const Text(
                  "Play",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.025),
          ],
        ),
      ),
    );
  }
}
