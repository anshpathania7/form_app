import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../home/tabs/home_view.dart';
import 'tabs/rehab_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late int _index;
  @override
  void initState() {
    super.initState();
    Get.create(() => HomeController()..init(), tag: 'home', permanent: true);
    _pageController = PageController();
    _index = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) => setState(() {
          if (index < 2) {
            _pageController.jumpToPage(index);
            _index = index;
          }
        }),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(color: Colors.black),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_handball_sharp,
            ),
            label: "Rehab",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.run_circle,
            ),
            label: "Practice",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile",
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _index == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                final controller = Get.find<HomeController>();
                controller.insertFakeData();
              },
              isExtended: true,
              icon: const Icon(
                Icons.play_arrow,
                size: 32,
              ),
              label: const Text("Start Session"),
              extendedTextStyle: const TextStyle(
                fontSize: 18,
              ),
              extendedPadding: const EdgeInsets.symmetric(horizontal: 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: PageView(
          controller: _pageController,
          pageSnapping: false,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeView(),
            RehabView(),
          ],
        ),
      ),
    );
  }
}
