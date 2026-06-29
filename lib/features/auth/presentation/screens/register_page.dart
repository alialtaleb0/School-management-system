import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../../home_page.dart';
import '../../../student/presentation/screens/complete_profile_page.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  String _role = 'student';
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().register(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      passwordConfirmation: _confirmPasswordController.text,
      address: _addressController.text.trim(),
      phone: _phoneController.text.trim(),
      role: _role,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            Widget next;
            if (state.user?.role == 'student') {
              next = const CompleteProfilePage();
            } 
            // else if (state.user?.role == 'teacher') {
            //   next = const TeacherCompleteProfilePage();
            // } 
            else {
              next = const HomePage();
            }
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => next));
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!), backgroundColor: Colors.red));
            context.read<AuthCubit>().clearError();
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
                  Text('Create Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                  const SizedBox(height: 24),
                  Row(children: [
                    Expanded(child: CustomTextField(controller: _firstNameController, label: 'First Name', prefixIcon: Icons.person_outline, validator: (v) => (v == null || v.isEmpty) ? 'Required' : null)),
                    const SizedBox(width: 12),
                    Expanded(child: CustomTextField(controller: _lastNameController, label: 'Last Name', prefixIcon: Icons.person_outline, validator: (v) => (v == null || v.isEmpty) ? 'Required' : null)),
                  ]),
                  const SizedBox(height: 16),
                  CustomTextField(controller: _emailController, label: 'Email', prefixIcon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, validator: (v) => (v == null || v.isEmpty) ? 'Enter your email' : (!v.contains('@') ? 'Invalid email' : null)),
                  const SizedBox(height: 16),
                  CustomTextField(controller: _passwordController, label: 'Password', prefixIcon: Icons.lock_outlined, obscureText: _obscurePassword, validator: (v) => (v == null || v.isEmpty) ? 'Enter password' : (v.length < 8 ? 'At least 8 characters' : null), suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obscurePassword = !_obscurePassword))),
                  const SizedBox(height: 16),
                  CustomTextField(controller: _confirmPasswordController, label: 'Confirm Password', prefixIcon: Icons.lock_outlined, obscureText: _obscureConfirm, validator: (v) => v != _passwordController.text ? 'Passwords do not match' : null, suffixIcon: IconButton(icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility), onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm))),
                  const SizedBox(height: 16),
                  CustomTextField(controller: _addressController, label: 'Address', prefixIcon: Icons.location_on_outlined, validator: (v) => (v == null || v.isEmpty) ? 'Enter address' : null),
                  const SizedBox(height: 16),
                  CustomTextField(controller: _phoneController, label: 'Phone', prefixIcon: Icons.phone_outlined, keyboardType: TextInputType.phone, validator: (v) => (v == null || v.isEmpty) ? 'Enter phone number' : null),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _role,
                    decoration: const InputDecoration(labelText: 'Role', prefixIcon: Icon(Icons.badge_outlined)),
                    items: const [DropdownMenuItem(value: 'student', child: Text('Student')), DropdownMenuItem(value: 'teacher', child: Text('Teacher'))],
                    onChanged: (v) => setState(() => _role = v!),
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<AuthCubit, AuthState>(builder: (context, state) => LoadingButton(isLoading: state.isLoading, label: 'Register', onPressed: _register)),
                  const SizedBox(height: 12),
                  Center(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text('Already have an account? Login'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
