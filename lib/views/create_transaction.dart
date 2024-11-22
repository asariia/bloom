import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateTransactionPage extends StatefulWidget {
  @override
  _CreateTransactionPageState createState() => _CreateTransactionPageState();
}

class _CreateTransactionPageState extends State<CreateTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _invoiceNoController = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _productsController = TextEditingController();

  final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImU2ZDk5NDc3LTc4Y2QtNDJhYy1hZTQxLTRkYmEyZTg5OGM5OCIsImVtYWlsIjoicmltYmFob3VzZUBnbWFpbC5jb20iLCJpYXQiOjE3MzIyMjY5MjYsImV4cCI6MTczMjQ4NjEyNn0.wdDbZ0ViNq_F_KACroRh3jkz4OOB5sWR0xhoE5NVcb8";

  Future<void> _createTransaction() async {
    final url = 'https://opposite-striped-makemake.glitch.me/transaction';

    final Map<String, dynamic> transactionData = {
      'invoiceNo': _invoiceNoController.text,
      'customer': _customerController.text,
      'products': _productsController.text,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(transactionData),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Transaction Created')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create transaction')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Transaction")),
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
                    _createTransaction();
                  }
                },
                child: Text('Create Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
