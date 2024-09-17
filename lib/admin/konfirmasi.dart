import 'package:flutter/material.dart';
import 'package:ReservasiKalilo/api_provider.dart';
import 'riwayatkonfirmasi.dart';

class Konfirmasi extends StatefulWidget {
  @override
  _KonfirmasiState createState() => _KonfirmasiState();
}

class _KonfirmasiState extends State<Konfirmasi> {
  int _selectedIndex = 0;
  List<Map<String, String>> _bookings = [];
  List<Map<String, String>> _unconfirmedBookings = [];
  List<Map<String, String>> _confirmedBookings = [];

  @override
  void initState() {
    super.initState();
    // Fetch the purchase history when the widget is initialized
    _fetchPurchaseHistory();
  }

  void _fetchPurchaseHistory() async {
    try {
      List<Map<String, String>> bookings =
          await ApiProvider.getPurchaseHistory();

      setState(() {
        _bookings = bookings;
        _separateBookings();
      });
    } catch (error) {
      print('Error loading data: $error');
      // Handle the error as needed
    }
  }

  void _separateBookings() {
    _unconfirmedBookings = _bookings
        .where((booking) => !booking.containsKey('confirmed'))
        .toList();

    _confirmedBookings =
        _bookings.where((booking) => booking.containsKey('confirmed')).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MENU PENGELOLA'),
      ),
      body: _selectedIndex == 0
          ? _buildKonfirmasiScreen()
          : RiwayatKonfirmasi(
              confirmedBookings: _confirmedBookings,
              onDeletePressed: _onDeletePressed,
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Konfirmasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildKonfirmasiScreen() {
    return ListView.builder(
      itemCount: _unconfirmedBookings.length,
      itemBuilder: (context, index) {
        final bookingData = _unconfirmedBookings[index];

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
                    _onKonfirmasiButtonPressed(bookingData);
                  },
                  child: Text('Konfirmasi'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onDeletePressed(Map<String, String> bookingData) async {
    print('Delete button pressed. BookingData: $bookingData');
    // Perform actions for Delete button press
    await ApiProvider.deleteBooking(bookingData);
    _fetchPurchaseHistory(); // Refresh the purchase history after deletion
  }

  void _onKonfirmasiButtonPressed(Map<String, String> bookingData) async {
    print('Konfirmasi button pressed. BookingData: $bookingData');
    // Perform actions for Konfirmasi button press

    // Mark the booking as confirmed
    bookingData['confirmed'] = 'true';

    // Refresh the lists
    _separateBookings();

    // Remove the confirmed booking from the purchase history
    await ApiProvider.confirmBooking(bookingData);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
