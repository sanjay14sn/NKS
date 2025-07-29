import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nks_traders/backend/provider/location_provider.dart';
import 'package:nks_traders/pages/Featuredproducts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<LocationProvider>(context, listen: false).fetchLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 21.h,
            backgroundColor: const Color(0xFF2E6D55),
            automaticallyImplyLeading: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.sp),
                bottomRight: Radius.circular(20.sp),
              ),
            ),
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final isCollapsed = constraints.maxHeight < 22.h;

                return Transform.translate(
                  offset: Offset(
                    0,
                    isCollapsed ? 0 : -4.h,
                  ), // 👈 Slight upward nudge when expanded
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: isCollapsed
                            ? 2.h
                            : 2.5.h, // 👈 Less padding on expand
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isCollapsed)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 15.sp,
                                        ),
                                        SizedBox(width: 1.w),
                                        Consumer<LocationProvider>(
                                          builder:
                                              (context, locationProvider, _) {
                                                final city =
                                                    locationProvider.city;
                                                final state =
                                                    locationProvider.state;
                                                return Text(
                                                  city != null && state != null
                                                      ? '$city, $state'
                                                      : 'Fetching location...',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                );
                                              },
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.white,
                                          size: 14.sp,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12.sp),
                                  ),
                                  child: Icon(
                                    Icons.notifications_none,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                ),
                              ],
                            ),
                          if (!isCollapsed) SizedBox(height: 1.8.h),

                          // 🔍 Search and Filter - Always visible
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => context.push('/Search'),
                                  child: Container(
                                    height: isCollapsed ? 4.8.h : 6.h,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        15.sp,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: Colors.grey.shade400,
                                          size: 16.sp,
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          'Search',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Container(
                                height: isCollapsed ? 4.8.h : 6.h,
                                width: isCollapsed ? 4.8.h : 6.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child: Icon(
                                  Icons.tune,
                                  size: isCollapsed ? 16.sp : 20.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 🔻 Category Title
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/allProducts'),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔻 Horizontal Category List
          SliverToBoxAdapter(
            child: SizedBox(
              height: 15.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: GestureDetector(
                      onTap: () => context.push('/category/${item['label']}'),
                      child: Column(
                        children: [
                          Container(
                            height: 12.h,
                            width: 12.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(2.w),
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            item['label']!,
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 🔻 Product Grid Section
          SliverToBoxAdapter(child: ProductGridPage()),

          SliverToBoxAdapter(child: SizedBox(height: 3.h)),
        ],
      ),
    );
  }
}
