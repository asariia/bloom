import 'package:flutter/material.dart';
import 'katalog_admin.dart'; 
import 'katalog_customer.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
        fontFamily: 'Poppins', 
      ),
      home: const Choice(), 
    );
  }
}

class Choice extends StatelessWidget {
  const Choice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 390,
          height: 844,
          color: const Color(0xFFFDFBF9),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 60.0),
                  child: Image.asset(
                    'assets/images/logobloom2.png', 
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),
                // Tombol Admin
                SizedBox(
                  width: 153,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6E0F2D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                     
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KatalogAdmin()),
                      );
                    },
                    child: const Text(
                      'Admin',
                      style: TextStyle(
                        color: Color(0xFFFDFBF9),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'or',
                  style: TextStyle(
                    color: Color(0x996E0F2D),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 20),
                // Tombol Customer
                SizedBox(
                  width: 153,
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF6E0F2D)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KatalogCustomer()),
                      );
                    },
                    child: const Text(
                      'Customer',
                      style: TextStyle(
                        color: Color(0xFF6E0F2D),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
