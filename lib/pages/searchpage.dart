import 'package:flutter/material.dart';
import 'package:nks_traders/backend/data.dart';
import 'package:sizer/sizer.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _filteredProducts = [];
  List<Map<String, dynamic>> _defaultSuggestions = [];

  @override
  void initState() {
    super.initState();
    _defaultSuggestions = products.where((p) {
      final title = p['title'].toString().toLowerCase();
      return title.contains('water') ||
          p['categories'].toString().toLowerCase().contains('water');
    }).toList();
  }

  void _onSearchChanged(String value) {
    if (value.length < 3) {
      setState(() => _filteredProducts.clear());
      return;
    }

    final query = value.toLowerCase();
    final results = products.where((product) {
      return product['title'].toLowerCase().contains(query);
    }).toList();

    setState(() {
      _filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF2E6D55),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Search',
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Box
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            // Label
            Text(
              _searchController.text.length < 3 ? 'Suggestions' : 'Results',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1.h),
            // Suggestion list
            Expanded(
              child:
                  (_searchController.text.length < 3
                          ? _defaultSuggestions
                          : _filteredProducts)
                      .isEmpty
                  ? const Center(child: Text('No results found'))
                  : ListView.builder(
                      itemCount: (_searchController.text.length < 3
                          ? _defaultSuggestions.length
                          : _filteredProducts.length),
                      itemBuilder: (context, index) {
                        final product = _searchController.text.length < 3
                            ? _defaultSuggestions[index]
                            : _filteredProducts[index];

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.asset(
                            product['image'],
                            width: 12.w,
                            height: 12.w,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 12.w,
                              height: 12.w,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.image_not_supported),
                            ),
                          ),
                          title: Text(
                            product['title'],
                            style: TextStyle(fontSize: 11.sp),
                          ),
                          subtitle: Text(
                            product['variant'],
                            style: TextStyle(fontSize: 9.sp),
                          ),
                          onTap: () {
                            // Handle product tap (navigate to details if needed)
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
