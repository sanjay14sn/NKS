import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nks_traders/backend/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BottomNavShell extends StatefulWidget {
  final Widget child;
  const BottomNavShell({Key? key, required this.child}) : super(key: key);

  @override
  State<BottomNavShell> createState() => _BottomNavShellState();
}

class _BottomNavShellState extends State<BottomNavShell> {
  int _selectedIndex = 0;

  final List<String> _routes = ['/Homepage', '/Favorites', '/Cart', '/Profile'];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.home_outlined,
      Icons.favorite_border,

      Icons.shopping_bag_outlined,
      Icons.person_2_outlined,
    ];

    final labels = ['Home', 'Favorites', 'Cart', 'Profile'];

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Consumer<QuantityProvider>(
        builder: (context, quantityProvider, _) {
          final totalCartCount = quantityProvider.totalCartCount;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(icons.length, (index) {
                final selected = index == _selectedIndex;

                Widget iconWidget = Icon(
                  icons[index],
                  color: selected ? const Color(0xFF2E6D55) : Colors.black,
                  size: 18.sp,
                );

                if (index == 3 && totalCartCount > 0) {
                  iconWidget = Stack(
                    clipBehavior: Clip.none,
                    children: [
                      iconWidget,
                      Positioned(
                        top: -1.3.h,
                        right: 25.w,
                        child: Container(
                          padding: EdgeInsets.all(0.7.h),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF2C94C),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$totalCartCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return GestureDetector(
                  onTap: () => _onTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.h,
                    ),
                    decoration: selected
                        ? BoxDecoration(
                            color: const Color(0xFF2E6D55).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.sp),
                          )
                        : const BoxDecoration(),
                    child: Row(
                      children: [
                        iconWidget,
                        if (selected) ...[
                          SizedBox(width: 2.w),
                          Text(
                            labels[index],
                            style: TextStyle(
                              color: const Color(0xFF2E6D55),
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
