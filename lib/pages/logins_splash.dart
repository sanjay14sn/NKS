import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class LoginSplash extends StatefulWidget {
  const LoginSplash({Key? key}) : super(key: key);

  @override
  State<LoginSplash> createState() => _LoginSplashState();
}

class _LoginSplashState extends State<LoginSplash> {
  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      print("✅ Location permission granted");
    } else if (status.isDenied) {
      print("⚠️ Location permission denied");
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Open settings to enable manually
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          SizedBox(
            height: 80.h,
            width: 100.w,
            child: Image.asset(
              'assets/images/splash1.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: 10.h,
            left: 0,
            child: Transform.rotate(
              angle: 4.7124,
              child: Container(
                height: 50.h,
                width: 30.w,
                decoration: BoxDecoration(
                  color: Color(0xFFD9B43D),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50.w),
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 100.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2E6D55),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'NKS',
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF2C94C)),
                      children: [
                        TextSpan(
                          text: 'TRADERS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Text(
                    "An online shopping App that specializes in selling inverters, Online UPS, Offline UPS, inverter batteries, Solar Products and car batteries",
                    style: TextStyle(fontSize: 11.sp, color: Colors.white70),
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 6.h,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push('/Login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF222222),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                      ),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
