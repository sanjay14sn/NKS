import 'package:flutter/material.dart';
import 'package:nks_traders/backend/data.dart'; // Make sure this contains the products list
import 'package:nks_traders/backend/provider/cart_provider.dart';
import 'package:nks_traders/pages/productdetail.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CategoryPage extends StatelessWidget {
  final String category;

  const CategoryPage({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    // 🔍 Filter products that match the category
    final categoryProducts = products
        .where(
          (p) =>
              p['categories'].toString().toLowerCase() ==
              category.toLowerCase(),
        )
        .toList();

    Widget buildGrid(List<Map<String, dynamic>> items) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2.h,
          crossAxisSpacing: 3.w,
          childAspectRatio: 0.62,
        ),
        itemBuilder: (context, index) {
          final product = items[index];
          final quantity = context.watch<QuantityProvider>().getQuantity(
            product['id'],
          );

          return GestureDetector(
            onTap: () {
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
                  // 🖼 Image with heart icon
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
                          padding: const EdgeInsets.all(6),
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

                  // 📝 Product Info
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

                        // 💵 Price + Quantity Button
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

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // 🔰 Header (unchanged)
          Container(
            width: 100.w,
            height: 15.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2E6D55),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.sp),
                bottomRight: Radius.circular(20.sp),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Filter logic
                  },
                  child: Icon(Icons.tune, color: Colors.white, size: 20.sp),
                ),
              ],
            ),
          ),

          // ✅ Make product section scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  categoryProducts.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            'No products found in $category',
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        )
                      : buildGrid(categoryProducts),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
