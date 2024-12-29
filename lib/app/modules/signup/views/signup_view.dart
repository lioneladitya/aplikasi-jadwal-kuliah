import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/app/routes/app_pages.dart';
import '../controllers/signup_controller.dart';
import 'package:myapp/app/routes/app_pages.dart';

class SignupView extends GetView<SignupController> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade500, Colors.blue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              // Logo
              Image.asset(
                "assets/images/sc_logo.png",
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                "Daftar",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "and save your schedule neatly.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Email Field
              TextField(
                controller: controller.cEmail,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Password Field
              TextField(
                controller: controller.cPass,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Register Button
              ElevatedButton(
                onPressed: () async {
                  String email = controller.cEmail.text.trim();
                  String password = controller.cPass.text.trim();

                  if (email.isEmpty || password.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Email and Password cannot be empty.',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  try {
                    // Register user
                    UserCredential userCredential =
                        await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    // Send email verification
                    if (userCredential.user != null &&
                        !userCredential.user!.emailVerified) {
                      await userCredential.user!.sendEmailVerification();
                      Get.snackbar(
                        'Success',
                        'Registration successful! Please check your email for verification.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }

                    // Navigate back to login page
                    Get.offAllNamed(Routes.LOGIN);
                  } catch (e) {
                    Get.snackbar(
                      'Registration Error',
                      e.toString(),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
