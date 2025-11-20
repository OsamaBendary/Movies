import 'package:flutter/material.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/services/auth service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/theme/app colors/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _authService = FireAuth();

  final List<String> avatars = [
    "assets/prof pics/1.png",
    "assets/prof pics/2.png",
    "assets/prof pics/3.png",
    "assets/prof pics/4.png",
    "assets/prof pics/5.png",
    "assets/prof pics/6.png",
    "assets/prof pics/7.png",
    "assets/prof pics/8.png",
    "assets/prof pics/9.png",
  ];

  late PageController _pageController;
  double _currentPageOffset = 0.0;
  int _currentPageIndex = 0;

  bool obscure = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: 0.45, initialPage: 0);
    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    if (mounted) {
      setState(() {
        _currentPageOffset = _pageController.page ?? 0.0;
        _currentPageIndex = _currentPageOffset.round();
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      String selectedAvatarPath = 'your_selected_path_variable';

      if (user != null) {
        try {
          await user.updatePhotoURL(selectedAvatarPath);
          print('Avatar path saved successfully: $selectedAvatarPath');
        } on FirebaseAuthException catch (e) {
          print('Error updating profile: ${e.message}');
        }
      }
      return;
    }

    if (_passwordController.text != _rePasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match.')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();

    final selectedAvatar = avatars[_currentPageIndex];

    try {
      await _authService.signUp(email, password);

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateDisplayName(username);
        await user.updatePhotoURL(selectedAvatar);
      }

      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteNames.layout,
          (Route<dynamic> route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Registration failed. Please try again.";
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
      }

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unexpected error occurred.')),
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

  Widget _buildAvatar(int index) {
    final path = avatars[index];

    double pageOffset =
        _pageController.hasClients && _pageController.page != null
        ? _pageController.page!
        : index.toDouble();

    double difference = (index - pageOffset).abs();

    double scale = (1.0 - (difference * 0.4)).clamp(0.7, 1.0);
    return Transform.scale(
      scale: scale,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          _pageController.animateToPage(
            index,

            duration: const Duration(milliseconds: 300),

            curve: Curves.easeOut,
          );
        },
        child: SizedBox(
          width: 158,
          height: 161,
          child: Image(image: AssetImage(path), fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.yellow,
        ),
        title: Text(
          "Register",
          style: TextStyle(
            color: AppColors.yellow,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 9),

                SizedBox(
                  height: 169,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: avatars.length,
                    itemBuilder: (context, index) {
                      return _buildAvatar(index);
                    },
                  ),
                ),

                const SizedBox(height: 41),


                TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                  style: TextStyle(color: AppColors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: "Name",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    hintTextDirection: TextDirection.ltr,
                    prefixIconColor: Colors.grey,
                    fillColor: AppColors.grey,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                TextFormField(
                  controller: _rePasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Re-Password is required";
                    }
                    if (value != _passwordController.text) {
                      return "Passwords must match";
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
                    hintText: "Re-Password",
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account?",
                      style: TextStyle(color: AppColors.white, fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.login);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
