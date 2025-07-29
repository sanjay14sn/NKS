import 'package:flutter/material.dart';
import 'package:nks_traders/backend/data.dart';
import 'package:sizer/sizer.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Filter favorite products
    final favoriteProducts = products.where((p) => p['isfav'] == true).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Favorites",style: TextStyle(color: Colors.white,fontSize: 18),),
        backgroundColor: const Color(0xFF2E6D55),
        centerTitle: true,
      ),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : GridView.builder(
              padding: EdgeInsets.all(4.w),
              itemCount: favoriteProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 3.w,
                mainAxisSpacing: 2.h,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.sp),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Image + Heart
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.sp),
                              topRight: Radius.circular(12.sp),
                            ),
                            child: Image.asset(
                              product['image'],
                              width: double.infinity,
                              height: 16.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite,
                                size: 14.sp,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// Title
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(height: 0.5.h),

                            /// Price
                            Text(
                              '₹${product['price'].toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 0.5.h),

                  
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
