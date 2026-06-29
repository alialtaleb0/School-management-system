import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/grade_card.dart';
import '../cubit/student_cubit.dart';
import '../cubit/student_state.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().getGrades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Grades')),
      body: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          if (state.isLoading)
            return const Center(child: CircularProgressIndicator());
          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(state.error!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<StudentCubit>().getGrades(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state.grades.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.grade_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No grades yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => context.read<StudentCubit>().getGrades(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.grades.length,
              itemBuilder: (context, index) {
                final g = state.grades[index];
                return GradeCard(
                  subjectName: g.subjectName,
                  grade: g.grade,
                  date: g.date,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
