import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeletePage extends StatefulWidget {
  final String productId; // ID produk yang akan dihapus
  final String productName; // Nama produk untuk konfirmasi

  DeletePage({required this.productId, required this.productName});

  @override
  _DeletePageState createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  bool isDeleting = false; // Status saat proses penghapusan

  // Menambahkan token sebagai variabel global (sesuaikan dengan cara penyimpanan token Anda)
  final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU2ZDk5NDc3LTc4Y2QtNDJhYy1hZTQxLTRkYmEyZTg5OGM5OCIsImVtYWlsIjoicmltYmFob3VzZUBnbWFpbC5jb20iLCJpYXQiOjE3MzIyMjY5MjYsImV4cCI6MTczMjQ4NjEyNn0.wdDbZ0ViNq_F_KACroRh3jkz4OOB5sWR0xhoE5NVcb8";

  // Fungsi untuk menghapus produk
  Future<void> _deleteProduct() async {
    setState(() {
      isDeleting = true;
    });

    final response = await http.delete(
      Uri.parse('https://opposite-striped-makemake.glitch.me/product/${widget.productId}'),
      headers: {
        'Authorization': 'Bearer $token', // Menambahkan token ke header Authorization
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produk berhasil dihapus!')),
        );
        Navigator.pop(context, true); // Kembali ke halaman sebelumnya dengan hasil true
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus produk: ${responseData['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: ${response.statusCode}')),
      );
    }

    setState(() {
      isDeleting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hapus Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Apakah Anda yakin ingin menghapus produk "${widget.productName}"?',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            isDeleting
                ? Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _deleteProduct,
                        child: Text('Ya, Hapus'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, false); // Kembali tanpa melakukan apa-apa
                        },
                        child: Text('Batal'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
