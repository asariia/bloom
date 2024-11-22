import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateTransactionPage extends StatefulWidget {
  final String transactionId;

  UpdateTransactionPage({required this.transactionId});

  @override
  _UpdateTransactionPageState createState() => _UpdateTransactionPageState();
}

class _UpdateTransactionPageState extends State<UpdateTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _invoiceNoController = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _productsController = TextEditingController();

  final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU2ZDk5NDc3LTc4Y2QtNDJhYy1hZTQxLTRkYmEyZTg5OGM5OCIsImVtYWlsIjoicmltYmFob3VzZUBnbWFpbC5jb20iLCJpYXQiOjE3MzIyMjY5MjYsImV4cCI6MTczMjQ4NjEyNn0.wdDbZ0ViNq_F_KACroRh3jkz4OOB5sWR0xhoE5NVcb8";

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  Future<void> _updateTransaction() async {
    final url = 'https://opposite-striped-makemake.glitch.me/transaction/${widget.transactionId}';

    final Map<String, dynamic> transactionData = {
      'invoiceNo': _invoiceNoController.text,
      'date': _getCurrentDate(),
      'customer': _customerController.text,
      'products': [
        {
          'productId': '30ec93e5-7112-4969-9463-4fb19dbc781a',
          'quantity': '10',
          'price': '2000000',
        },
        {
          'productId': '5a68b869-5246-4f80-a0a4-3b66548500cf',
          'quantity': '20',
          'price': '1000000',
        },
      ],
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(transactionData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction Updated')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update transaction')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Transaction")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _invoiceNoController,
                decoration: InputDecoration(labelText: 'Invoice No'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an invoice number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _customerController,
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a customer name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productsController,
                decoration: InputDecoration(labelText: 'Products (comma separated)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter products';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _updateTransaction();
                  }
                },
                child: Text('Update Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
