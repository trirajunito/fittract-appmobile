import 'package:flutter/material.dart';

import 'dashboard_page.dart';
import 'workout_page.dart';
import 'weight_page.dart';
import 'bmi_page.dart';
import 'statistic_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  late final List<Widget> pages = const [
    DashboardPage(),
    WorkoutPage(),
    WeightPage(),
    BMIPage(),
    StatisticPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: IndexedStack(
          key: ValueKey(currentIndex),
          index: currentIndex,
          children: pages,
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: NavigationBar(
              height: 72,
              elevation: 15,

              backgroundColor: const Color(0xffFFFFFF),

              indicatorColor: Colors.blue.shade100,

              animationDuration: const Duration(
                milliseconds: 400,
              ),

              labelBehavior:
                  NavigationDestinationLabelBehavior.alwaysShow,

              selectedIndex: currentIndex,

              onDestinationSelected: (index) {
                setState(() {
                  currentIndex = index;
                });
              },

              destinations: [
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.home_rounded,
                    color: Colors.blue.shade700,
                  ),
                  icon: const Icon(Icons.home_outlined),
                  label: "Home",
                ),

                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.fitness_center,
                    color: Colors.orange.shade700,
                  ),
                  icon: const Icon(
                    Icons.fitness_center_outlined,
                  ),
                  label: "Workout",
                ),

                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.monitor_weight,
                    color: Colors.green.shade700,
                  ),
                  icon: const Icon(
                    Icons.monitor_weight_outlined,
                  ),
                  label: "Weight",
                ),

                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.calculate,
                    color: Colors.deepPurple.shade700,
                  ),
                  icon: const Icon(
                    Icons.calculate_outlined,
                  ),
                  label: "BMI",
                ),

                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.bar_chart,
                    color: Colors.red.shade700,
                  ),
                  icon: const Icon(
                    Icons.bar_chart_outlined,
                  ),
                  label: "Statistik",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}