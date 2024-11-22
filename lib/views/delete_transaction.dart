import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteTransactionPage extends StatelessWidget {
  final String transactionId;

  DeleteTransactionPage({required this.transactionId});

  final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU2ZDk5NDc3LTc4Y2QtNDJhYy1hZTQxLTRkYmEyZTg5OGM5OCIsImVtYWlsIjoicmltYmFob3VzZUBnbWFpbC5jb20iLCJpYXQiOjE3MzIyMjY5MjYsImV4cCI6MTczMjQ4NjEyNn0.wdDbZ0ViNq_F_KACroRh3jkz4OOB5sWR0xhoE5NVcb8"; // Use your actual token

  Future<void> _deleteTransaction(BuildContext context) async {
    final url = 'https://opposite-striped-makemake.glitch.me/transaction/$transactionId';

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction Deleted')));
      Navigator.pop(context); // Go back to the previous page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete transaction')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete Transaction")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _deleteTransaction(context);
          },
          child: Text('Delete Transaction'),
        ),
      ),
    );
  }
}
