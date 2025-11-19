import 'package:flutter/material.dart';
import 'package:movies/core/widgets/custom_button/custom_button.dart';
import '../../../core/services/auth service/auth_service.dart';
import '../../../core/theme/app colors/app_colors.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final FireAuth _auth = FireAuth();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();

      try {
        await _auth.sendPasswordResetEmail(email);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Password reset link sent to $email. Please check your inbox!",
              style: TextStyle(color: AppColors.black),
            ),
            backgroundColor: AppColors.yellow,
          ),
        );

        Navigator.pop(context);

      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Error: Failed to send reset email. Please try again. ($e)",
              style: TextStyle(color: AppColors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon: Icon(Icons.arrow_back), color: AppColors.yellow,),
        title: Text("Forget Password", style: TextStyle(color: AppColors.white, fontSize: 22, fontWeight: FontWeight.w400),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/Forgot password-bro 1.png"),
                    SizedBox(height: 16,),
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
                    SizedBox(height: 16,),
                    CustomButton(
                      color: AppColors.yellow,
                      text: "Verify Email",
                      textColor: AppColors.black,
                      onPressed: _resetPassword,
                    ),
                  ]
              )
          ),
        ),
      ),
    );
  }
}