import 'package:events360/core/constants/constants.dart';
import 'package:events360/core/themes/app_colors.dart';
import 'package:events360/core/widgets/app_snackbar.dart';
import 'package:events360/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignIn = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  // Password validation regex
  final _passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{6,32}$');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    value = value.trim();

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (value.length > 32) {
      return 'Password must not exceed 32 characters';
    }

    if (!_passwordRegex.hasMatch(value)) {
      return 'Password must contain at least one letter and one number';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    value = value.trim();

    if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      try {
        if (_isSignIn) {
          final response = await authProvider.signIn(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );

          if (mounted) {
            if (response['success'] == true) {
              // Clear text fields after successful sign in
              _emailController.clear();
              _passwordController.clear();

              showSnackBar(
                context,
                'Sign in successfull!',
              );

              await Navigator.of(context).pushNamedAndRemoveUntil(
                '/landing',
                (route) => false,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(response['error'] ?? 'Authentication failed'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        } else {
          final response = await authProvider.signUp(
            _nameController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );

          if (mounted) {
            if (response['success'] == true) {
              FocusScope.of(context).unfocus();
              _nameController.clear();
              _emailController.clear();
              _passwordController.clear();

              // Switch to sign in mode after successful signup
              setState(() {
                _isSignIn = true;
              });

              showSnackBar(
                context,
                'Account created successfully! Sign in to continue',
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(response['error'] ?? 'Failed to create account'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        }
      } on Exception catch (e) {
        // This catch block will handle any other exceptions
        String errorMessage = 'An unexpected error occurred';

        if (e.toString().contains('Invalid email or password')) {
          errorMessage = 'Invalid email or password';
        } else if (e.toString().contains('already registered')) {
          errorMessage = 'This email is already registered';
        } else if (e.toString().contains('weak password')) {
          errorMessage = 'Please choose a stronger password';
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              Text(
                _isSignIn ? 'Welcome Back!' : 'Create Account',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _isSignIn ? 'Sign in to continue' : 'Sign up to get started',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (!_isSignIn)
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          filled: true,
                          fillColor: isDarkMode
                              ? AppColors.greyDark
                              : AppColors.greyLight,
                          border: Constants.inputBorder,
                          enabledBorder: Constants.inputBorder,
                          focusedBorder: Constants.inputBorderFocused,
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          if (value.trim().isEmpty) {
                            return 'Name cannot be just spaces';
                          }
                          return null;
                        },
                        onChanged: (value) => _nameController.text = value,
                      ),
                    if (!_isSignIn) Constants.h16,
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: isDarkMode
                            ? AppColors.greyDark
                            : AppColors.greyLight,
                        border: Constants.inputBorder,
                        enabledBorder: Constants.inputBorder,
                        focusedBorder: Constants.inputBorderFocused,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: _validateEmail,
                      onChanged: (value) =>
                          _emailController.text = value.trim(),
                    ),
                    Constants.h16,
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: isDarkMode
                            ? AppColors.greyDark
                            : AppColors.greyLight,
                        border: Constants.inputBorder,
                        enabledBorder: Constants.inputBorder,
                        focusedBorder: Constants.inputBorderFocused,
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      validator: _validatePassword,
                      onChanged: (value) =>
                          _passwordController.text = value.trim(),
                    ),
                  ],
                ),
              ),
              Constants.h24,
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.blue,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        _isSignIn ? 'Sign In' : 'Sign Up',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              Constants.h16,
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey),
                    borderRadius: Constants.br12),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isSignIn = !_isSignIn;
                    });
                  },
                  child: Text(
                    _isSignIn
                        ? 'New to the app? Sign Up Here'
                        : 'Already have an account? Sign In',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
