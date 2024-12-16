import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    //agar rensponsive -- soon
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: 390,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 808.13,
              child: Container(
                width: 390,
                height: 35.87,
                child: Stack(),
              ),
            ),
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
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 328,
                        height: 64,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFF5090F3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 10,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 27,
                      top: 22,
                      child: Text(
                        'Username',
                        style: TextStyle(
                          color: Color(0xFF181818),
                          fontSize: 14,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 31,
              top: 378,
              child: Container(
                width: 328,
                height: 64,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 328,
                        height: 64,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFF5090F3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 10,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 24,
                      top: 23,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: Color(0xFF181818),
                          fontSize: 14,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 280,
                      top: 21,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          'assets/images/removeye.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 31,
              top: 466,
              child: Container(
                width: 328,
                height: 64,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 328,
                        height: 64,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFF5090F3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 10,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 24,
                      top: 23,
                      child: Text(
                        'Confirm password',
                        style: TextStyle(
                          color: Color(0xFF181818),
                          fontSize: 14,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 280,
                      top: 21,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          'assets/images/removeye.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 31,
              top: 577,
              child: Container(
                width: 328,
                height: 52,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 328,
                        height: 52,
                        decoration: ShapeDecoration(
                          color: Color(0xFF5090F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 134,
                      top: 15,
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
                  ],
                ),
              ),
            ),
            Positioned(
              left: 195,
              top: 650,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(),
                child: Image.asset(
                  'assets/images/arrback.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
