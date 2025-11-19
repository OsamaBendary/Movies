import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/services/auth service/auth_service.dart';
import '../../../core/theme/app colors/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscure = true;
  bool isLogin = true;
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = FireAuth();
  final _formKey = GlobalKey<FormState>();

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      if (isLogin) {
        await _authService.signIn(email, password);

        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            RouteNames.layout,
                (Route<dynamic> route) => false,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed. Please check your credentials.";

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        errorMessage = "Invalid email or password.";
      }

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _authService.signInWithGoogle();

      if (user != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged in successfully with Google!')),
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteNames.layout,
              (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Google Login Failed: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 67),
                Center(
                  child: 
                  Image.asset("assets/logos/logo.png", scale: 0.5,),
                ),

                const SizedBox(height: 69),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    } else if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                  style: TextStyle(color: AppColors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    hintText: "Email",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    hintTextDirection: TextDirection.ltr,
                    prefixIconColor: Colors.grey,
                    fillColor: AppColors.grey,
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))
                    ),
                  ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    } else if (value.length < 8) {
                      return "Password must be at least 8 characters";
                    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return "Password must contain an uppercase letter";
                    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return "Password must contain a number";
                    }
                    return null;
                  },
                  obscureText: obscure,
                  style: TextStyle(color: AppColors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                    ),
                    hintText: "Password",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    hintTextDirection: TextDirection.ltr,
                    prefixIconColor: Colors.grey,
                    suffixIconColor: Colors.grey,
                    fillColor: AppColors.grey,
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))
                  ),
                ),

                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.forgot);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        onPressed: _isLoading ? null : _submit,
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.yellow,
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have Account?",
                      style: TextStyle(color: AppColors.white, fontSize: 14,)
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.register);
                      },
                      child: Text(
                       "Create Account",
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Divider(color: AppColors.white, thickness: 1.2),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Or",
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: AppColors.white, thickness: 1.2),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleGoogleSignIn,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.yellow,
                      foregroundColor: AppColors.yellow,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side:  BorderSide(
                          color: AppColors.black,
                          width: 1,
                        ),
                      ),
                      splashFactory: InkRipple.splashFactory,
                    ),
                    child: _isLoading
                        ?  SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.yellow,
                        strokeWidth: 3,
                      ),
                    )
                        : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/icons/super g.png",
                          height: 24, color: AppColors.black,
                        ),
                        const SizedBox(width: 10),
                         Text(
                          "Login With Google",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

              ],
            ),
          ),
        ),
      ),
    );}}