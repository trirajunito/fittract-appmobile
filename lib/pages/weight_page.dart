import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/weight_model.dart';
import '../cubit/weight/weight_cubit.dart';
import '../cubit/weight/weight_state.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final _formKey = GlobalKey<FormState>();

  final weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<WeightCubit>().loadWeights();
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  Future<void> saveWeight() async {
    if (!_formKey.currentState!.validate()) return;

    final weight = WeightModel(
      weight: double.parse(weightController.text),
      date: DateTime.now().toString(),
    );

    await context.read<WeightCubit>().addWeight(weight);

    weightController.clear();

    if (mounted) {
      context.read<WeightCubit>().loadWeights();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berat badan berhasil disimpan"),
      ),
    );
  }

  Future<void> deleteWeight(int id) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Hapus Data"),
          content: const Text(
            "Yakin ingin menghapus data berat badan ini?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );

    if (result == true) {
      context.read<WeightCubit>().deleteWeight(id);
    }
  }

  Future<void> refresh() async {
    context.read<WeightCubit>().loadWeights();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text(
          "Berat Badan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: refresh,
        child: BlocBuilder<WeightCubit, WeightState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor:
                                Colors.green.shade100,
                            child: Icon(
                              Icons.monitor_weight,
                              color: Colors.green.shade700,
                              size: 35,
                            ),
                          ),

                          const SizedBox(height: 15),

                          const Text(
                            "Input Berat Badan",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20),

                          TextFormField(
                            controller:
                                weightController,
                            keyboardType:
                                TextInputType.number,
                            decoration:
                                InputDecoration(
                              labelText:
                                  "Berat Badan (Kg)",
                              prefixIcon: const Icon(
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
                                return "Berat badan wajib diisi";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.green,
                                foregroundColor:
                                    Colors.white,
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          15),
                                ),
                              ),
                              onPressed: saveWeight,
                              icon: const Icon(
                                Icons.save,
                              ),
                              label: const Text(
                                "Simpan",
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
                ),

                const SizedBox(height: 25),

                const Text(
                  "Riwayat Berat",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                if (state is WeightLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child:
                          CircularProgressIndicator(),
                    ),
                  ),

                if (state is WeightLoaded &&
                    state.weights.isEmpty)
                  Container(
                    padding:
                        const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.monitor_weight_outlined,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Belum ada data berat badan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                if (state is WeightLoaded)
                  ...state.weights.reversed.map(
                    (item) => Card(
                      elevation: 3,
                      margin:
                          const EdgeInsets.only(
                        bottom: 15,
                      ),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                18),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Colors.green.shade100,
                          child: Icon(
                            Icons.monitor_weight,
                            color:
                                Colors.green.shade700,
                          ),
                        ),
                        title: Text(
                          "${item.weight} Kg",
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          item.date.substring(
                              0, 10),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () =>
                              deleteWeight(
                                  item.id!),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}