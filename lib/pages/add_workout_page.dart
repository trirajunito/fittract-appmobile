import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/workout/workout_cubit.dart';
import '../models/workout_model.dart';

class AddWorkoutPage extends StatefulWidget {
  const AddWorkoutPage({super.key});

  @override
  State<AddWorkoutPage> createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final setController = TextEditingController();
  final repsController = TextEditingController();
  final weightController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    namaController.dispose();
    setController.dispose();
    repsController.dispose();
    weightController.dispose();
    super.dispose();
  }

  Future<void> saveWorkout() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    final workout = WorkoutModel(
      nama: namaController.text.trim(),
      setCount: int.parse(setController.text),
      reps: int.parse(repsController.text),
      weight: double.parse(weightController.text),
      tanggal: DateTime.now().toString(),
    );

    await context.read<WorkoutCubit>().addWorkout(workout);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  InputDecoration inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text(
          "Tambah Workout",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.15),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        Icons.fitness_center,
                        size: 38,
                        color: Colors.blue.shade700,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Workout Baru",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Isi data latihan yang ingin disimpan",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
                      controller: namaController,
                      decoration: inputDecoration(
                        label: "Nama Latihan",
                        icon: Icons.fitness_center,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Nama latihan wajib diisi";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    TextFormField(
                      controller: setController,
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration(
                        label: "Jumlah Set",
                        icon: Icons.repeat,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Jumlah set wajib diisi";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    TextFormField(
                      controller: repsController,
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration(
                        label: "Jumlah Reps",
                        icon: Icons.loop,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Jumlah reps wajib diisi";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    TextFormField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration(
                        label: "Berat (Kg)",
                        icon: Icons.monitor_weight,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Berat wajib diisi";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 35),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: isLoading ? null : saveWorkout,
                        icon: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.save),
                        label: Text(
                          isLoading
                              ? "Menyimpan..."
                              : "Simpan Workout",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}