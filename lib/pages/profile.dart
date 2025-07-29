import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.shopping_bag_outlined, 'title': 'My orders'},
      {'icon': Icons.assignment_return_outlined, 'title': 'My returns'},
      {'icon': Icons.person_outline, 'title': 'Personal details'},
      {'icon': Icons.credit_card_outlined, 'title': 'Payment methods'},
      {'icon': Icons.email_outlined, 'title': 'Newsletter'},
      {'icon': Icons.chat_bubble_outline, 'title': 'Chat'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Picture and Name
            Row(
              children: [
                CircleAvatar(
                  radius: 22.sp,
                  backgroundImage: AssetImage(
                    "assets/images/user.jpg",
                  ), // Replace with your image
                ),
                SizedBox(width: 4.w),
                Text(
                  "Varadharajan",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),

            /// Menu Items
            ...menuItems.map(
              (item) => Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(item['icon'], color: Colors.grey[800]),
                    title: Text(
                      item['title'],
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 12.sp),
                    onTap: () {
                      // Navigate to each section
                    },
                  ),
                  Divider(height: 0, color: Colors.grey.shade300),
                ],
              ),
            ),

            const Spacer(),

            /// Logout
            Container(
              height: 5.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                 context.go('/LoginSplash');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB0413E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      5,
                    ), // 👈 Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ), // Inner horizontal padding
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.logout, color: Colors.black),
                    SizedBox(width: 12),
                    Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12.sp,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
