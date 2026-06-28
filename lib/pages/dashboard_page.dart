import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/workout/workout_cubit.dart';
import '../cubit/workout/workout_state.dart';

import '../cubit/weight/weight_cubit.dart';
import '../cubit/weight/weight_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();

    context.read<WorkoutCubit>().loadWorkouts();
    context.read<WeightCubit>().loadWeights();
  }

  String greeting() {
    final hour = DateTime.now().hour;

    if (hour < 11) {
      return "Selamat Pagi ☀️";
    } else if (hour < 15) {
      return "Selamat Siang 🌤";
    } else if (hour < 18) {
      return "Selamat Sore 🌇";
    } else {
      return "Selamat Malam 🌙";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2563EB),
              Color(0xff1D4ED8),
              Color(0xff0F172A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<WorkoutCubit>().loadWorkouts();
              context.read<WeightCubit>().loadWeights();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //-------------------------------- HEADER

                  Text(
                    greeting(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "💪 FitTrack",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Pantau perkembangan latihan dan kesehatanmu setiap hari.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(.85),
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 35),

                  //-------------------------------- SUMMARY

                  Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<WorkoutCubit, WorkoutState>(
                          builder: (context, state) {
                            int total = 0;

                            if (state is WorkoutLoaded) {
                              total = state.workouts.length;
                            }

                            return _summaryCard(
                              icon: Icons.fitness_center,
                              title: "Workout",
                              value: "$total",
                              color: Colors.orange,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: BlocBuilder<WeightCubit, WeightState>(
                          builder: (context, state) {
                            String berat = "-";

                            if (state is WeightLoaded &&
                                state.weights.isNotEmpty) {
                              berat =
                                  "${state.weights.last.weight} Kg";
                            }

                            return _summaryCard(
                              icon: Icons.monitor_weight,
                              title: "Berat",
                              value: berat,
                              color: Colors.green,
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  //-------------------------------- TARGET

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.12),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white24,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.flag,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Target Mingguan",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          "Tetap Konsisten 🔥",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(30),
                          child: const LinearProgressIndicator(
                            value: .75,
                            minHeight: 12,
                            backgroundColor:
                                Colors.white24,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "75% Target Mingguan",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  //-------------------------------- MOTIVASI

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.08),
                      borderRadius:
                          BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: const [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Tips Hari Ini",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Olahraga selama 30 menit setiap hari lebih baik daripada olahraga berat hanya sekali seminggu.\n\nJangan lupa minum air putih dan lakukan stretching sebelum memulai latihan.",
                          style: TextStyle(
                            color: Colors.white70,
                            height: 1.6,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _summaryCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withOpacity(.2),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}