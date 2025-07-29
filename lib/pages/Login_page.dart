import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🔶 Rotated Yellow Background Curve
          Positioned(
            top: -120,
            right: 0, // ➤ Move it to the top-right corner
            child: Transform.rotate(
              angle: 1.5708, // ➤ 90 degrees in radians
              child: Container(
                height: 50.h,
                width: 30.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E6D55),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50.w),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          // 🔳 Login Form
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.h),

                  /// Logo
                  SizedBox(
                    height: 20.h,
                    child: Image.asset(
                      'assets/images/logo1.png',
                      fit: BoxFit.contain,
                      color: const Color(0xFF2E6D55),
                    ),
                  ),

                  /// Phone Number Label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Phone Number',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),

                  /// Phone Number Field
                  Container(
                    height: 6.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
                        prefixIcon: Icon(Icons.phone, color: Colors.grey[400]),
                        hintText: 'Enter Your Phone Number',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),

                  /// Password Label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),

                  /// Password Field
                  Container(
                    height: 6.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: TextField(
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
                        prefixIcon: Icon(Icons.lock, color: Colors.grey[400]),
                        hintText: 'Create Your Password',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[400],
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),

                  /// Remember Me and Forgot Password
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Color(0xFF0B7AFF),
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text('Remember Me', style: TextStyle(fontSize: 10.sp)),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          context.push('/forgotpassword');
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Color(0xFF61B292),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  /// Log In Button
                  SizedBox(
                    width: double.infinity,
                    height: 6.h,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push('/Homepage');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF222222),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(fontSize: 12.sp, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),

                  /// Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have An Account?",
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push('/Signup');
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF61B292),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
