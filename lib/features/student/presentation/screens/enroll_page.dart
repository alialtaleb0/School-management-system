import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/loading_button.dart';
import '../cubit/student_cubit.dart';
import '../cubit/student_state.dart';

class EnrollPage extends StatefulWidget {
  const EnrollPage({super.key});

  @override
  State<EnrollPage> createState() => _EnrollPageState();
}

class _EnrollPageState extends State<EnrollPage> {
  final _formKey = GlobalKey<FormState>();
  final _levelIdController = TextEditingController();
  final _sectionIdController = TextEditingController();
  final _academicYearController = TextEditingController();

  @override
  void dispose() {
    _levelIdController.dispose();
    _sectionIdController.dispose();
    _academicYearController.dispose();
    super.dispose();
  }

  void _enroll() {
    if (!_formKey.currentState!.validate()) return;
    context.read<StudentCubit>().enroll(
      int.parse(_levelIdController.text.trim()),
      int.parse(_sectionIdController.text.trim()),
      _academicYearController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enroll in Class')),
      body: BlocListener<StudentCubit, StudentState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Enrollment successful!'),
                backgroundColor: Colors.green,
              ),
            );
            context.read<StudentCubit>().resetSuccess();
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
                    Icons.school,
                    size: 64,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Enroll in a Class',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    controller: _levelIdController,
                    label: 'Level ID',
                    prefixIcon: Icons.format_list_numbered,
                    keyboardType: TextInputType.number,
                    validator: (v) => (v == null || v.isEmpty)
                        ? 'Enter level ID'
                        : (int.tryParse(v) == null
                              ? 'Enter a valid number'
                              : null),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _sectionIdController,
                    label: 'Section ID',
                    prefixIcon: Icons.group,
                    keyboardType: TextInputType.number,
                    validator: (v) => (v == null || v.isEmpty)
                        ? 'Enter section ID'
                        : (int.tryParse(v) == null
                              ? 'Enter a valid number'
                              : null),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _academicYearController,
                    label: 'Academic Year',
                    hint: 'e.g. 2025',
                    prefixIcon: Icons.calendar_month,
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Enter academic year' : null,
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<StudentCubit, StudentState>(
                    builder: (context, state) => LoadingButton(
                      isLoading: state.isLoading,
                      label: 'Enroll Now',
                      onPressed: _enroll,
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
