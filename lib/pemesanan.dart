import 'package:flutter/material.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';
import 'api_provider.dart'; // Import your ApiProvider

void main() => runApp(PemesananWidget());

class PemesananWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Example',
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String _selectedPaket = 'Paket A';
  TextEditingController _imageController = TextEditingController();

  List<String> _jenisPaket = ['Paket A', 'Paket B', 'Paket C'];

  final _formKey = GlobalKey<FormState>();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  void _selectImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageController.text = pickedFile.path;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form pemesanan',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Main(),
                ),
              );
            }),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              TextFormField(
                controller: _controller1,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _controller2,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _controller3,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone Number is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedPaket,
                items: _jenisPaket
                    .map((paket) => DropdownMenuItem<String>(
                          value: paket,
                          child: Text(paket),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Jenis Paket',
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedPaket = value!;
                  });
                },
              ), // Gambar QR dan teks "QR Pembayaran"
              SizedBox(height: 16.0),
              TextFormField(
                controller: _controller4,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Upload Bukti Pembayaran (JPG)',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () => _selectImage(context),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'QR Pembayaran',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Image.asset(
                'assets/image/qr.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 16.0),
                            TextFormField(
                controller: _controller4,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Upload Bukti Pembayaran (JPG)',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () => _selectImage(context),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scan QRIS untuk Pembayaran',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Image.asset(
                          'assets/qrcode.png',  // Pastikan gambar ini ada di folder assets
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Silakan scan kode QR di atas untuk melakukan pembayaran.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Proses data.
                      String name = _controller1.text;
                      String email = _controller2.text;
                      String phoneNumber = _controller3.text;
                      String jenisPaket = _selectedPaket;
                      String buktiPembayaran = _imageController.text;

                      // Membuat objek yang berisi data
                      final data = {
                        'name': name,
                        'email': email,
                        'phoneNumber': phoneNumber,
                        'jenisPaket': jenisPaket,
                        'buktiPembayaran': buktiPembayaran,
                      };

                      // Save form data using ApiProvider
                      await ApiProvider.saveFormData(data);

                      // Membersihkan formulir jika diperlukan.
                      _controller1.clear();
                      _controller2.clear();
                      _controller3.clear();
                      _imageController.clear();

                      // Menampilkan pesan konfirmasi.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Data telah disubmit!'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 50),
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
