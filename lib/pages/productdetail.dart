import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nks_traders/backend/provider/cart_provider.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({required this.product, super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final quantity = context.watch<QuantityProvider>().getQuantity(
      product['id'],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E6D55),
        elevation: 1,
        automaticallyImplyLeading: true,
        title: Text(
          product['title'] ?? 'Product',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 35.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.sp),
                color: Colors.white,
              ),
              child: product['image'] != null
                  ? Image.asset(product['image'], fit: BoxFit.contain)
                  : Icon(
                      Icons.image_not_supported,
                      size: 30.sp,
                      color: Colors.grey.shade400,
                    ),
            ),
            SizedBox(height: 2.h),

            // Static indicator
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.w),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == 0 ? Colors.black : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),

            // Title and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product['title'] ?? 'Product',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${(product['price'] ?? 0).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Bershka',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 9.sp),
            ),
            SizedBox(height: 1.h),

            // Short Description
            Text(
              product['description'] ?? 'No description available.',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 9.sp),
            ),
            SizedBox(height: 2.h),

            // About Product Heading
            Text(
              'About Product',
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 1.h),

            // Detailed Description
            Text(
              product['detaileddescription'] ??
                  'No additional details provided.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 9.sp),
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

                  style: TextStyle(fontSize: 8.5.sp, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 8.h), // Spacing for bottom bar
          ],
        ),
      ),

      // Sticky bottom bar
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 2.h),
        child: Row(
          children: [
            Expanded(
              child: quantity == 0
                  ? GestureDetector(
                      onTap: () =>
                          context.read<QuantityProvider>().add(product['id']),
                      child: Container(
                        height: 5.5.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF222222),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'ADD TO CART',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.5.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 5.5.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF222222),
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Add to cart if not already
                  if (quantity == 0) {
                    context.read<QuantityProvider>().add(product['id']);
                  }
                  // Navigate to Cart Page
                  context.push('/Cart');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E6D55),
                  padding: EdgeInsets.symmetric(vertical: 1.8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                ),
                child: Text(
                  'Buy Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
