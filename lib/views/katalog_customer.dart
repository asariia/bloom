import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KatalogCustomer extends StatefulWidget {
  @override
  _KatalogCustomerState createState() => _KatalogCustomerState();
}

class _KatalogCustomerState extends State<KatalogCustomer> {
  List<dynamic> products = [];
  bool isLoading = true;
  final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU2ZDk5NDc3LTc4Y2QtNDJhYy1hZTQxLTRkYmEyZTg5OGM5OCIsImVtYWlsIjoicmltYmFob3VzZUBnbWFpbC5jb20iLCJpYXQiOjE3MzIyMjY5MjYsImV4cCI6MTczMjQ4NjEyNn0.wdDbZ0ViNq_F_KACroRh3jkz4OOB5sWR0xhoE5NVcb8";

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse('https://opposite-striped-makemake.glitch.me/product'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        products = responseData['data']['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 146,
              height: 39,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logobloom2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Product List',
              style: TextStyle(
                color: Color(0xFF6E0F2D),
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final productName = product['name'];

                      return ListTile(
                        title: Text(productName ?? 'Produk Tanpa Nama'),
                        subtitle: Text('ID: ${product['id']}'),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
