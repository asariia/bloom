import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String initialProductName;

  const EditPage({Key? key, required this.initialProductName}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _productNameController;

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController(text: widget.initialProductName);
  }

  @override
  void dispose() {
    _productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context, _productNameController.text);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _productNameController.text);
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
