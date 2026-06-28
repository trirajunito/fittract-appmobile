import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/workout/workout_cubit.dart';
import '../cubit/workout/workout_state.dart';

import '../cubit/weight/weight_cubit.dart';
import '../cubit/weight/weight_state.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text(
          "Statistik",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ringkasan Aktivitas",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: BlocBuilder<WorkoutCubit, WorkoutState>(
                    builder: (context, state) {
                      int totalWorkout = 0;

                      if (state is WorkoutLoaded) {
                        totalWorkout = state.workouts.length;
                      }

                      return _summaryCard(
                        color: Colors.orange,
                        icon: Icons.fitness_center,
                        title: "Workout",
                        value: "$totalWorkout",
                      );
                    },
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: BlocBuilder<WeightCubit, WeightState>(
                    builder: (context, state) {
                      int totalWeight = 0;

                      if (state is WeightLoaded) {
                        totalWeight = state.weights.length;
                      }

                      return _summaryCard(
                        color: Colors.green,
                        icon: Icons.monitor_weight,
                        title: "Data Berat",
                        value: "$totalWeight",
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Target Mingguan",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const LinearProgressIndicator(
                      value: .75,
                      minHeight: 12,
                      borderRadius:
                          BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "75% Target Workout Mingguan",
                      style: TextStyle(
                        color:
                            Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.insights,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Analisis",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    BlocBuilder<WorkoutCubit,
                        WorkoutState>(
                      builder: (context, state) {
                        int total = 0;

                        if (state
                            is WorkoutLoaded) {
                          total =
                              state.workouts.length;
                        }

                        return Text(
                          "• Total workout yang telah dilakukan : $total",
                          style:
                              const TextStyle(
                            height: 1.8,
                          ),
                        );
                      },
                    ),

                    BlocBuilder<WeightCubit,
                        WeightState>(
                      builder: (context, state) {
                        int total = 0;

                        if (state
                            is WeightLoaded) {
                          total =
                              state.weights.length;
                        }

                        return Text(
                          "• Riwayat berat badan tersimpan : $total",
                          style:
                              const TextStyle(
                            height: 1.8,
                          ),
                        );
                      },
                    ),

                    const Text(
                      "• Terus tingkatkan konsistensi latihan setiap minggu.",
                      style: TextStyle(
                        height: 1.8,
                      ),
                    ),

                    const Text(
                      "• Catat berat badan secara rutin agar perkembangan mudah dipantau.",
                      style: TextStyle(
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              color: Colors.blue.shade50,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: Colors.amber,
                      size: 35,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        "Tips Hari Ini\n\n"
                        "Olahraga minimal 30 menit setiap hari, "
                        "cukupi kebutuhan air putih, "
                        "dan istirahat yang cukup agar hasil latihan lebih optimal.",
                        style: TextStyle(
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard({
    required Color color,
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor:
                  color.withOpacity(.15),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}