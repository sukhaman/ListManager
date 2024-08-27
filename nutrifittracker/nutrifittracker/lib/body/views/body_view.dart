import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrifittracker/body/bloc/body_bloc.dart';
import 'package:nutrifittracker/body/bloc/body_event.dart';
import 'package:nutrifittracker/body/bloc/body_state.dart';
import 'package:nutrifittracker/dialogs/error_dialog.dart';

class BodyView extends StatefulWidget {
  const BodyView({super.key});

  @override
  State<BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<BodyView> {
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _heightFeetController = TextEditingController(); // Feet
  final _heightInchesController = TextEditingController(); // Inches
  final _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<BodyBloc, BodyState>(
      listener: (context, state) {
        if (state is BodyError) {
          showErrorDialog(context, state.message);
        } else if (state is BodyAdded) {
          showErrorDialog(context, 'Body added successfully');
        } else {
          showErrorDialog(context, 'Something went wrong');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Body Data')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _heightFeetController,
                      decoration:
                          const InputDecoration(labelText: 'Height (Feet)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _heightInchesController,
                      decoration:
                          const InputDecoration(labelText: 'Height (Inches)'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveData() {
    final age = int.tryParse(_ageController.text);
    final gender = _genderController.text;
    final heightFeet = int.tryParse(_heightFeetController.text);
    final heightInches = int.tryParse(_heightInchesController.text);
    final weight = int.tryParse(_weightController.text);

    if (age != null &&
        heightFeet != null &&
        heightInches != null &&
        weight != null &&
        gender.isNotEmpty) {
      context.read<BodyBloc>().add(
            BodyAddRequestEvent(
              age: age,
              gender: gender,
              heightInFeet: heightFeet,
              heightInInches: heightInches,
              weight: weight,
            ),
          );
    } else {
      showErrorDialog(context, 'Please fill in all fields correctly.');
    }
  }
}
