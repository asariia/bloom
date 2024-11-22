import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController _nameController = TextEditingController();

  Future<void> _createProduct() async {
    String name = _nameController.text.trim();

    if (name.isEmpty) {
      _showDialog("Error", "Nama produk tidak boleh kosong!");
      return;
    }

    final productData = {'name': name};

    try {
      final response = await http.post(
        Uri.parse('https://opposite-striped-makemake.glitch.me/product'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer <your-token>',
        },
        body: json.encode(productData),
      );

      if (response.statusCode == 201) {
        _showDialog("Success", "Produk berhasil dibuat!");
      } else {
        _showDialog("Error", 'Gagal membuat produk: ${response.body}');
      }
    } catch (e) {
      _showDialog("Error", 'Terjadi kesalahan: $e');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (title == "Success") Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createProduct,
              child: Text('Create Product'),
            ),
          ],
        ),
      ),
    );
  }
}
