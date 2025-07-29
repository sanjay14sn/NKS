import 'package:flutter/material.dart';
import 'package:nks_traders/backend/data.dart';
import 'package:nks_traders/backend/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E6D55),
        elevation: 0,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<QuantityProvider>(
        builder: (context, provider, _) {
          if (provider.totalCartCount == 0) {
            // ✅ Empty Cart UI
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 22.h,
                    child: Image.asset(
                      'assets/images/emptycart.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Your bag is empty\nLooking for ideas?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to home/shop
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF222222),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 1.5.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                    ),
                    child: Text(
                      'Start Shopping',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // ✅ Non-empty Cart UI
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(2.h),
                    children: provider.quantities.entries.map((entry) {
                      final product = products.firstWhere(
                        (p) => p['id'] == entry.key,
                      );
                      final quantity = entry.value;
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: Image.asset(
                            product['image'],
                            width: 50,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/placeholder.jpeg', // 👈 your dummy image here
                                width: 50,
                                fit: BoxFit.cover,
                              );
                            },
                          ),

                          title: Text(product['title']),
                          subtitle: Text(
                            '${product['variant']} - ₹${product['price']}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => provider.decrement(entry.key),
                              ),
                              Text('$quantity'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => provider.increment(entry.key),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    children: [
                      _summaryRow(
                        'Sub-Total',
                        _getSubtotal(provider).toStringAsFixed(2),
                      ),
                      _summaryRow('Delivery Charge', '5.00'),
                      _summaryRow('Tax', '5.00'),
                      _summaryRow('Discount', '-10.00'),
                      const Divider(),
                      _summaryRow(
                        'Total Cost',
                        (_getSubtotal(provider) + 5 + 5 - 10).toStringAsFixed(
                          2,
                        ),
                        isBold: true,
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              builder: (context) => const CheckoutBottomSheet(),
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E6D55),
                            padding: EdgeInsets.symmetric(vertical: 1.8.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '₹$value',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  double _getSubtotal(QuantityProvider provider) {
    double total = 0;
    provider.quantities.forEach((id, qty) {
      final product = products.firstWhere((p) => p['id'] == id);
      total += product['price'] * qty;
    });
    return total;
  }
}
class CheckoutBottomSheet extends StatelessWidget {
  const CheckoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // ✅ Background color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),    // Top-left circular
          topRight: Radius.circular(20),   // Top-right circular
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 2.h,
          left: 5.w,
          right: 5.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Small line at the top center
            Container(
              width: 15.w,
              height: 0.6.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 2.h),

            Text(
              "Checkout",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.h),

            _checkoutRow("Delivery", "Select Method"),
            _checkoutRow("Payment", "", trailingIcon: Icons.payment),
            _checkoutRow("Promo Code", "Pick discount"),
            _checkoutRow("Total Cost", "2000", bold: true),

            SizedBox(height: 2.h),

            Text(
              "By placing an order you agree to our Terms And Conditions",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9.sp, color: Colors.grey),
            ),

            SizedBox(height: 1.5.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Place order logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E6D55),
                  padding: EdgeInsets.symmetric(vertical: 1.8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _checkoutRow(
    String title,
    String value, {
    IconData? trailingIcon,
    bool bold = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: TextStyle(fontSize: 11.sp)),
      trailing: trailingIcon != null
          ? Icon(trailingIcon, size: 20.sp)
          : Text(
              value,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                fontSize: 11.sp,
              ),
            ),
      onTap: () {
        // Handle each row tap separately if needed
      },
    );
  }
}


Widget _checkoutRow(
  String title,
  String value, {
  IconData? trailingIcon,
  bool bold = false,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(title, style: TextStyle(fontSize: 11.sp)),
    trailing: trailingIcon != null
        ? Icon(trailingIcon, size: 20.sp)
        : Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontSize: 11.sp,
            ),
          ),
    onTap: () {
      // Handle each row tap separately if needed
    },
  );
}
