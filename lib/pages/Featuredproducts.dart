import 'package:flutter/material.dart';
import 'package:nks_traders/backend/data.dart';
import 'package:nks_traders/backend/provider/cart_provider.dart';
import 'package:nks_traders/pages/productdetail.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductGridPage extends StatelessWidget {
  const ProductGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = products
        .where((p) => p['featuredproducts'] == true)
        .toList();
    final trending = products
        .where((p) => p['trendingProduct'] == true)
        .toList();
    final dmOrDistill = products
        .where(
          (p) =>
              p['categories'] == 'DM Water' ||
              p['categories'] == 'Distill Water',
        )
        .toList();

    Widget buildGrid(List<Map<String, dynamic>> items) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2.h,
          crossAxisSpacing: 3.w,
          childAspectRatio: 0.58,
        ),
        itemBuilder: (context, index) {
          final product = items[index];
          final quantity = context.watch<QuantityProvider>().getQuantity(
            product['id'],
          );

          return GestureDetector(
            onTap: () {
              // Navigate to product detail page or show product info
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(product: product),
                ),
              );
            },
            child: Container(
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
                  /// Image
                  Stack(
                    children: [
                      Container(
                        height: 16.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.sp),
                            topRight: Radius.circular(12.sp),
                          ),
                          image: DecorationImage(
                            image: AssetImage(product['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// Info
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          product['variant'],
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          product['description'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        SizedBox(height: 1.h),

                        /// Price and Add
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹${product['price'].toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            quantity == 0
                                ? GestureDetector(
                                    onTap: () => context
                                        .read<QuantityProvider>()
                                        .add(product['id']),
                                    child: Container(
                                      height: 4.5.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF222222),
                                        borderRadius: BorderRadius.circular(
                                          8.sp,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'ADD',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 4.5.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF222222),
                                      borderRadius: BorderRadius.circular(8.sp),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () => context
                                              .read<QuantityProvider>()
                                              .decrement(product['id']),
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 16.sp,
                                          ),
                                        ),
                                        Text(
                                          '$quantity',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => context
                                              .read<QuantityProvider>()
                                              .increment(product['id']),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 16.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(height: 0.8.h),
                        Row(
                          children: [
                            ...List.generate(5, (starIndex) {
                              double rating = product['rating'] ?? 0;
                              return Icon(
                                starIndex < rating.floor()
                                    ? Icons.star
                                    : starIndex < rating
                                    ? Icons.star_half
                                    : Icons.star_border,
                                size: 12.sp,
                                color: Colors.amber,
                              );
                            }),
                            SizedBox(width: 4),
                            Text(
                              (product['ratingCount'] ?? 0).toString(),

                              style: TextStyle(
                                fontSize: 8.5.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.8.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (featured.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Text(
                'Featured Products',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ),
            buildGrid(featured),
          ],
          if (trending.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Text(
                'Trending Products',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ),
            buildGrid(trending),
          ],
          if (dmOrDistill.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Text(
                'DM / Distilled Water',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ),
            buildGrid(dmOrDistill),
          ],
        ],
      ),
    );
  }
}
