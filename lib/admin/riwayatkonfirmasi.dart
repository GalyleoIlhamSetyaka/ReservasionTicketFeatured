import 'package:flutter/material.dart';

class RiwayatKonfirmasi extends StatelessWidget {
  final List<Map<String, String>> confirmedBookings;
  final Function(Map<String, String>) onDeletePressed;

  RiwayatKonfirmasi(
      {required this.confirmedBookings, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildConfirmedScreen(),
    );
  }

  Widget _buildConfirmedScreen() {
    return ListView.builder(
      itemCount: confirmedBookings.length,
      itemBuilder: (context, index) {
        final bookingData = confirmedBookings[index];

        return Card(
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Name: ${bookingData['name']}'),
                Text('Email: ${bookingData['email']}'),
                Text('Phone Number: ${bookingData['phoneNumber']}'),
                Text('Jenis Paket: ${bookingData['jenisPaket']}'),
                Text('Bukti Pembayaran: ${bookingData['buktiPembayaran']}'),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    onDeletePressed(bookingData);
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
