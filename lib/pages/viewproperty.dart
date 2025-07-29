import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PropertyPurchaseFlow extends StatelessWidget {
  const PropertyPurchaseFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.arrow_back, size: 20.sp),
              SizedBox(height: 2.h),
              Text(
                "Property Purchase Flow",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(2.w),
                child: Image.asset(
                  'assets/images/dummy1.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Land Information",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Purpose", style: TextStyle(fontSize: 10.sp)),
                  Text("For sale", style: TextStyle(fontSize: 10.sp)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Size", style: TextStyle(fontSize: 10.sp)),
                  Text("1,800 sq ft", style: TextStyle(fontSize: 10.sp)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Location", style: TextStyle(fontSize: 10.sp)),
                  Text("Coimbatore", style: TextStyle(fontSize: 10.sp)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price", style: TextStyle(fontSize: 10.sp)),
                  Text("₹8,00,000",
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                "Description",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 0.5.h),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                style: TextStyle(fontSize: 9.sp),
              ),
              SizedBox(height: 2.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(2.w),
                child: Image.asset(
                  'assets/images/gmapdummy.png',
                  height: 20.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      ),
                      child: Text('Call', style: TextStyle(fontSize: 11.sp)),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      ),
                      child:
                          Text('WhatsApp', style: TextStyle(fontSize: 11.sp)),
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
