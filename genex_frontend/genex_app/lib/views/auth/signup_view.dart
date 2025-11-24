// lib/views/auth/signup_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/providers.dart';
import '../../viewmodels/auth_state.dart';
import '../../widgets/loading_button.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtr = TextEditingController();
  final _emailCtr = TextEditingController();
  final _passwordCtr = TextEditingController();
  String role = 'patient'; // default

  @override
  void dispose() {
    _nameCtr.dispose();
    _emailCtr.dispose();
    _passwordCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final authVM = ref.read(authViewModelProvider.notifier);

    // Listen for auth state changes to navigate or show error
    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated) {
        // Token is already saved and set in ApiService inside AuthViewModel
        Navigator.of(context).pushReplacementNamed('/home');
      } else if (next.status == AuthStatus.error && next.errorMessage != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtr,
                decoration: InputDecoration(labelText: 'Full name'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: _emailCtr,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (v) =>
                    v != null && v.contains('@') ? null : 'Enter valid email',
              ),
              TextFormField(
                controller: _passwordCtr,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (v) => v != null && v.length >= 6 ? null : 'Min 6 chars',
              ),
              // SizedBox(height: 12),
              // DropdownButtonFormField<String>(
              //   value: role,
              //   items: [
              //     DropdownMenuItem(value: 'patient', child: Text('Patient')),
              //     DropdownMenuItem(value: 'doctor', child: Text('Doctor')),
              //   ],
              //   onChanged: (v) => setState(() {
              //     role = v ?? 'patient';
              //   }),
              //   decoration: InputDecoration(labelText: 'Role'),
              // ),
              SizedBox(height: 20),
              LoadingButton(
                loading: authState.status == AuthStatus.authenticating,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Signup with name, email, password, role
                    // AuthViewModel will store the JWT token automatically
                    authVM.signup(
                      name: _nameCtr.text.trim(),
                      email: _emailCtr.text.trim(),
                      password: _passwordCtr.text,
                      role: role,
                    );
                  }
                },
                label: 'Sign Up',
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('/signin'),
                child: Text('Already have account? Sign in'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
