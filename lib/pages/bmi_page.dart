import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bmi/bmi_cubit.dart';
import '../cubit/bmi/bmi_state.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  final _formKey = GlobalKey<FormState>();

  final weightController = TextEditingController();
  final heightController = TextEditingController();

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  Color getColor(String category) {
    if (category.toLowerCase().contains("kurus")) {
      return Colors.orange;
    }
    if (category.toLowerCase().contains("normal")) {
      return Colors.green;
    }
    if (category.toLowerCase().contains("gemuk") ||
        category.toLowerCase().contains("obes")) {
      return Colors.red;
    }

    return Colors.blue;
  }

  IconData getIcon(String category) {
    if (category.toLowerCase().contains("normal")) {
      return Icons.favorite;
    }

    if (category.toLowerCase().contains("kurus")) {
      return Icons.monitor_weight;
    }

    if (category.toLowerCase().contains("gemuk") ||
        category.toLowerCase().contains("obes")) {
      return Icons.warning_amber;
    }

    return Icons.calculate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text(
          "BMI Calculator",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor:
                            Colors.deepPurple.shade100,
                        child: Icon(
                          Icons.calculate,
                          size: 36,
                          color:
                              Colors.deepPurple.shade700,
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Hitung BMI",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      TextFormField(
                        controller:
                            weightController,
                        keyboardType:
                            TextInputType.number,
                        decoration:
                            InputDecoration(
                          labelText:
                              "Berat Badan (Kg)",
                          prefixIcon:
                              const Icon(
                            Icons.monitor_weight,
                          ),
                          filled: true,
                          fillColor:
                              Colors.grey.shade100,
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    15),
                            borderSide:
                                BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Masukkan berat badan";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      TextFormField(
                        controller:
                            heightController,
                        keyboardType:
                            TextInputType.number,
                        decoration:
                            InputDecoration(
                          labelText:
                              "Tinggi Badan (Cm)",
                          prefixIcon:
                              const Icon(
                            Icons.height,
                          ),
                          filled: true,
                          fillColor:
                              Colors.grey.shade100,
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    15),
                            borderSide:
                                BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Masukkan tinggi badan";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.deepPurple,
                            foregroundColor:
                                Colors.white,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      15),
                            ),
                          ),
                          onPressed: () {
                            if (!_formKey
                                .currentState!
                                .validate()) {
                              return;
                            }

                            context
                                .read<BMICubit>()
                                .calculateBMI(
                                  weight: double.parse(
                                      weightController
                                          .text),
                                  height: double.parse(
                                      heightController
                                          .text),
                                );
                          },
                          icon: const Icon(
                            Icons.calculate,
                          ),
                          label: const Text(
                            "Hitung BMI",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              BlocBuilder<BMICubit, BMIState>(
                builder: (context, state) {
                  if (state is BMILoaded) {
                    final color =
                        getColor(state.category);

                    return Card(
                      elevation: 5,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                20),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(
                                25),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor:
                                  color.withOpacity(
                                      .15),
                              child: Icon(
                                getIcon(
                                    state.category),
                                color: color,
                                size: 35,
                              ),
                            ),

                            const SizedBox(
                                height: 15),

                            Text(
                              state.bmi
                                  .toStringAsFixed(
                                      2),
                              style:
                                  TextStyle(
                                fontSize: 42,
                                color: color,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                                height: 10),

                            Text(
                              state.category,
                              style:
                                  TextStyle(
                                color: color,
                                fontSize: 22,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                                height: 18),

                            const Divider(),

                            const SizedBox(
                                height: 10),

                            const Text(
                              "Kategori BMI\n\n"
                              "• <18.5 : Kurus\n"
                              "• 18.5 - 24.9 : Normal\n"
                              "• 25 - 29.9 : Gemuk\n"
                              "• ≥30 : Obesitas",
                              textAlign:
                                  TextAlign.center,
                              style:
                                  TextStyle(
                                height: 1.6,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}