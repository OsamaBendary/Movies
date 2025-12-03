import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/widgets/custom_button/custom_button.dart';

import '../../../../../core/services/auth service/auth_service.dart';
import '../../../../../core/theme/app colors/app_colors.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _usernameController = TextEditingController();
  final _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _usernameController.text = user.displayName ?? '';
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        try {
          if (username != user.displayName) {
            await user.updateDisplayName(username);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile: ${e.message}')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An unknown error occurred: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back, color: AppColors.yellow,)),
        title: Text("Pick Avatar", style: TextStyle(color: AppColors.yellow),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 37,),
              Center(
                child: InkWell(
                  onTap: (){

                  },
                  child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Image(image: AssetImage(FireAuth.user!.photoURL?? ""), fit: BoxFit.cover,)),
                ),
              ),
              SizedBox(height: 35,),
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
              SizedBox(height: 20,),
              TextFormField(
                controller: _numberController,
                validator: (value) {
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone Number is required";
                    } else if (!RegExp(
                      r'^(?:(00201|\+201)|01)[0-2,5][0-9]{8}$',
                    ).hasMatch(value)) {
                      return "Enter a valid Phone Number";
                    }
                    return null;
                  };
                },
                style: TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.call),
                  hintText: "Mobile Number",
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
              Spacer(),

              CustomButton(color: AppColors.yellow, text: "Update Profile", textColor: AppColors.black, onPressed: (){_updateProfile();})
            ],
          ),
        ),
      ),
    );
  }
}
