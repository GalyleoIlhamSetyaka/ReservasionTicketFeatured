import 'dart:convert';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatScreen extends StatefulWidget {
  final List<Map<String, String>> purchaseHistory;

  RiwayatScreen({required this.purchaseHistory});

  @override
  _RiwayatScreenState createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  @override
  void initState() {
    super.initState();
    // Mengambil data dari shared_preferences saat inisialisasi
    getPurchaseHistory();
  }

  List<Map<String, String>> purchaseHistory = [];

  Future<void> getPurchaseHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = prefs.getStringList('purchaseHistory') ?? [];

    setState(() {
      purchaseHistory = historyList
          .map<Map<String, String>>(
            (data) => Map<String, String>.from(
                jsonDecode(data) as Map<String, dynamic>),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pembelian'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Main(), // Replace 'Main()' with your main screen widget
                ),
              );
            }),
      ),
      body: ListView.builder(
        itemCount: purchaseHistory.length,
        itemBuilder: (context, index) {
          final purchaseData = purchaseHistory[index];
          return PurchaseCard(
            name: purchaseData['name'] ?? '',
            email: purchaseData['email'] ?? '',
            phoneNumber: purchaseData['phoneNumber'] ?? '',
            jenisPaket: purchaseData['jenisPaket'] ?? '',
            buktiPembayaran: purchaseData['buktiPembayaran'] ?? '',
          );
        },
      ),
    );
  }
}

class PurchaseCard extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final String jenisPaket;
  final String buktiPembayaran;

  PurchaseCard({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.jenisPaket,
    required this.buktiPembayaran,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Name: $name'),
          ),
          ListTile(
            title: Text('Email: $email'),
          ),
          ListTile(
            title: Text('Phone Number: $phoneNumber'),
          ),
          ListTile(
            title: Text('Jenis Paket: $jenisPaket'),
          ),
          ListTile(
            title: Text('Bukti Pembayaran: $buktiPembayaran'),
          ),
        ],
      ),
    );
  }
}
