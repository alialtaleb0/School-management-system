import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/student_cubit.dart';
import '../cubit/student_state.dart';

class MyEnrollmentsPage extends StatefulWidget {
  const MyEnrollmentsPage({super.key});

  @override
  State<MyEnrollmentsPage> createState() => _MyEnrollmentsPageState();
}

class _MyEnrollmentsPageState extends State<MyEnrollmentsPage> {
  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().getEnrollments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Enrollments')),
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
                    onPressed: () =>
                        context.read<StudentCubit>().getEnrollments(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state.enrollments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No enrollments yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => context.read<StudentCubit>().getEnrollments(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.enrollments.length,
              itemBuilder: (context, index) {
                final e = state.enrollments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).primaryColor.withAlpha(30),
                      child: Icon(
                        Icons.school,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    title: Text(
                      e.levelName ?? 'Level ${e.levelId}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(e.sectionName ?? 'Section ${e.sectionId}'),
                        Text('Year: ${e.academicYear}'),
                      ],
                    ),
                    trailing: Text(
                      e.createdAt,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
