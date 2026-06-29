import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/student/presentation/cubit/student_cubit.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/screens/login_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  runApp(const SchoolApp());
}

class SchoolApp extends StatelessWidget {
  const SchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()),
        BlocProvider(create: (_) => di.sl<StudentCubit>()),
      ],
      child: MaterialApp(
        title: 'School System',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const LoginPage(),
      ),
    );
  }
}
