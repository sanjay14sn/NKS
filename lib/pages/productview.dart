import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductViewPage extends StatelessWidget {
  const ProductViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Icon(Icons.arrow_back, color: Colors.black, size: 18.sp),
                SizedBox(width: 3.w),
                Image.asset(
                  'assets/images/myntra_logo.png', // Use your logo asset
                  height: 4.h,
                ),
                SizedBox(width: 3.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WATCHES",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "38423 Items",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 9.sp,
                      ),
                    ),
                  ],
                )
              ],
            ),
            actions: [
              Icon(Icons.search, color: Colors.black, size: 20.sp),
              SizedBox(width: 4.w),
              Icon(Icons.favorite_border, color: Colors.black, size: 20.sp),
              SizedBox(width: 4.w),
              Stack(
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      color: Colors.black, size: 20.sp),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14.sp,
                        minHeight: 14.sp,
                      ),
                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 2.w),
            ],
          ),
        ),
      ),
      body: Center(child: Text('Product View Page')),
    );
  }
}
