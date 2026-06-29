import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../../home_page.dart';
import '../cubit/student_cubit.dart';
import '../cubit/student_state.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _dobController = TextEditingController();
  final _studentNumberController = TextEditingController();

  @override
  void dispose() {
    _dobController.dispose();
    _studentNumberController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<StudentCubit>().completeProfile(
      _dobController.text.trim(),
      _studentNumberController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Profile')),
      body: BlocListener<StudentCubit, StudentState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
            context.read<StudentCubit>().clearError();
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person_pin,
                    size: 64,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Complete Your Profile',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please provide additional information to complete your student profile.',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    controller: _dobController,
                    label: 'Date of Birth',
                    hint: 'YYYY-MM-DD',
                    prefixIcon: Icons.calendar_today,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Enter date of birth' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _studentNumberController,
                    label: 'Student Number',
                    prefixIcon: Icons.numbers,
                    keyboardType: TextInputType.number,
                    validator: (v) => (v == null || v.isEmpty)
                        ? 'Enter student number'
                        : null,
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<StudentCubit, StudentState>(
                    builder: (context, state) => LoadingButton(
                      isLoading: state.isLoading,
                      label: 'Submit',
                      onPressed: _submit,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
