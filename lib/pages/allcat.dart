import 'package:flutter/material.dart';
import 'package:nks_traders/pages/CategoryPage.dart';
import 'package:sizer/sizer.dart';

class Allcat extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'image': 'assets/images/online_ups.png', 'label': 'Online Ups'},
    {'image': 'assets/images/solar_system.png', 'label': 'Solar System'},
    {
      'image': 'assets/images/inverter_battery.png',
      'label': 'Inverter Battery',
    },
    {'image': 'assets/images/inverter.png', 'label': 'Inverter'},
    {'image': 'assets/images/crackers.png', 'label': 'Gift Box'},
    {'image': 'assets/images/battery.png', 'label': 'Battery'},
    {'image': 'assets/images/water.png', 'label': 'RO System'},
    {'image': 'assets/images/dm_water.png', 'label': 'DM Water'},
    {'image': 'assets/images/water1.png', 'label': 'Distill Water'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E6D55),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "All Categories",
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Welcome Text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Welcome ',
                      style: TextStyle(fontSize: 13.sp, color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Louis',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 13.sp,
                          ),
                        ),
                        TextSpan(
                          text: ',\nwhat you looking for?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),

              /// Scrollable Grid with Navigation
              GridView.builder(
                itemCount: categories.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 2.h,
                  crossAxisSpacing: 2.w,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryPage(category: item['label']),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 10.h,
                          width: 10.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.sp),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Image.asset(
                              item['image'],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          item['label'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 8.sp),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
