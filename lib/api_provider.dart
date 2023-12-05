import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  // Login endpoint
  static Future<bool> loginUser(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if the user is registered
    final savedUsername = prefs.getString('username_$username');
    final savedPassword = prefs.getString('password_$username');

    if (savedUsername == username && savedPassword == password) {
      prefs.setBool('isLoggedIn', true);
      return true;
    } else {
      return false;
    }
  }

  // Logout endpoint
  static Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }

  // Register user endpoint
  static Future<void> registerUser(
      String username, String password, String email) async {
    final prefs = await SharedPreferences.getInstance();

    // Get the existing list of users or create a new list
    List<String>? userList = prefs.getStringList('userList') ?? [];

    // Check if the user is already registered
    if (userList.contains(username)) {
      // User with the same username already exists
      print('Username already exists. Choose a different username.');
      return;
    }

    // Save the registration details to the list
    userList.add(username);
    prefs.setStringList('userList', userList);
    prefs.setString('username_$username', username);
    prefs.setString('password_$username', password);
    prefs.setString('email_$username', email);

    print('User registered successfully!');
  }

  // Save form data endpoint
  static Future<void> saveFormData(Map<String, String> formData) async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = prefs.getStringList('purchaseHistory') ?? [];
    historyList.add(jsonEncode(formData));
    prefs.setStringList('purchaseHistory', historyList);
  }

  // Get purchase history endpoint
  static Future<List<Map<String, String>>> getPurchaseHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = prefs.getStringList('purchaseHistory') ?? [];

    return historyList
        .map<Map<String, String>>(
          (data) => Map<String, String>.from(json.decode(data)),
        )
        .toList();
  }

  // Get belum konfirmasi data endpoint
  static Future<List<Map<String, String>>> getBelumKonfirmasiData() async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = prefs.getStringList('purchaseHistory') ?? [];

    return historyList
        .where((data) {
          final decodedData = Map<String, String>.from(json.decode(data));
          return decodedData['isConfirmed'] != 'true';
        })
        .map<Map<String, String>>(
          (data) => Map<String, String>.from(json.decode(data)),
        )
        .toList();
  }

  // Get sudah konfirmasi data endpoint
  static Future<List<Map<String, String>>> getSudahKonfirmasiData() async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = prefs.getStringList('purchaseHistory') ?? [];

    return historyList
        .where((data) {
          final decodedData = Map<String, String>.from(json.decode(data));
          return decodedData['isConfirmed'] == 'true';
        })
        .map<Map<String, String>>(
          (data) => Map<String, String>.from(json.decode(data)),
        )
        .toList();
  }

  // Confirm booking endpoint
  static Future<void> confirmBooking(Map<String, String> bookingData) async {
    // Add confirmation logic here, such as saving to the database or sending a confirmation email.

    // Set 'isConfirmed' flag to 'true' in the data
    final prefs = await SharedPreferences.getInstance();
    final bookings = prefs.getStringList('purchaseHistory') ?? [];
    final index = bookings.indexOf(jsonEncode(bookingData));
    final confirmedData =
        Map<String, String>.from(json.decode(bookings[index]));
    confirmedData['isConfirmed'] = 'true';
    bookings[index] = jsonEncode(confirmedData);
    prefs.setStringList('purchaseHistory', bookings);
  }

  // Delete booking endpoint
  static Future<void> deleteBooking(Map<String, String> bookingData) async {
    final prefs = await SharedPreferences.getInstance();
    final bookings = prefs.getStringList('purchaseHistory') ?? [];
    bookings.remove(jsonEncode(bookingData));
    prefs.setStringList('purchaseHistory', bookings);
  }
}
