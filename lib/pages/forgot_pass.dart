import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  String selectedCountryCode = '+91';
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),

              /// Lock Icon
              Icon(Icons.lock_outline, size: 10.h, color: Colors.grey[700]),

              SizedBox(height: 5.h),

              /// Heading
              Text(
                'Forget Password?',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 3.h),

              /// Subheading
              Text(
                'Enter your phone number to reset \nyour password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
              ),

              SizedBox(height: 5.h),

              /// Country Code & Phone Number Row
              Row(
                children: [
                  /// Country Code Box
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    height: 6.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: selectedCountryCode,
                        items: ['+91']
                            .map((code) => DropdownMenuItem(
                                  value: code,
                                  child: Text(code),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCountryCode = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),

                  /// Phone Number Field
                  Expanded(
                    child: Container(
                      height: 6.h,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '1234567890',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 4.h),

              /// Verify Button
              SizedBox(
                width: double.infinity,
                height: 6.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3C8D6C)
,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Handle verify tap
                  },
                  child: Text(
                    'Verify',
                    style: TextStyle(fontSize: 12.sp,color: Colors.white),
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
