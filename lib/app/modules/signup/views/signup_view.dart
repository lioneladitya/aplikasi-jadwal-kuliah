import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Tambahkan Firebase Auth
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 390,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 153,
              top: 223.66,
              child: SizedBox(
                width: 84.50,
                height: 36.92,
                child: Text(
                  'Daftar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF5090F3),
                    fontSize: 26,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 57,
              top: 260.58,
              child: SizedBox(
                width: 275.17,
                height: 20.05,
                child: Text(
                  'and save your schedule neatly.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 14,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 116,
              top: 69.63,
              child: Container(
                width: 158.17,
                height: 154.03,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/sc_logo.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 31,
              top: 290,
              child: Container(
                width: 328,
                height: 64,
                child: TextField(
                  controller: controller.cEmail,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Color(0xFF181818),
                      fontSize: 14,
                      fontFamily: 'Nunito',
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF5090F3)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF5090F3)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 31,
              top: 378,
              child: Container(
                width: 328,
                height: 64,
                child: TextField(
                  controller: controller.cPass,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Color(0xFF181818),
                      fontSize: 14,
                      fontFamily: 'Nunito',
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF5090F3)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF5090F3)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 31,
              top: 577,
              child: GestureDetector(
                onTap: () async {
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
                    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    // Send email verification
                    if (userCredential.user != null && !userCredential.user!.emailVerified) {
                      await userCredential.user!.sendEmailVerification();
                      Get.snackbar(
                        'Success',
                        'Registration successful! Please check your email for verification.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  } catch (e) {
                    Get.snackbar(
                      'Registration Error',
                      e.toString(),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: Container(
                  width: 328,
                  height: 52,
                  decoration: ShapeDecoration(
                    color: Color(0xFF5090F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Register',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}