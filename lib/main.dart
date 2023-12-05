import 'package:ReservasiKalilo/login.dart';
import 'package:ReservasiKalilo/pemesanan.dart';
import 'package:flutter/material.dart';
import 'package:ReservasiKalilo/backup.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ReservasiKalilo/riwayat.dart';
import 'api_provider.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}

class Main extends StatefulWidget {
  @override
  _Main createState() => _Main();
}

class _Main extends State<Main> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    Main(),
    PemesananWidget(),
    MyWebView(url: 'https://app.lapentor.com/sphere/kalilo'),
    RiwayatScreen(
      purchaseHistory: [],
    ),
  ];

  final List<IconData> _iconOptions = [
    Icons.home,
    Icons.bookmark,
    Icons.preview,
    Icons.history,
    Icons.logout,
  ];

  Color _getIconColor(int index) {
    if (_selectedIndex == index) {
      return Colors.blue; // warna saat dipilih
    } else {
      return Colors.grey; // warna saat tidak dipilih
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 4) {
      ApiProvider.logoutUser();

      // If the logout button is tapped, navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      // For other items, navigate to the respective screens
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => _widgetOptions[index]),
      );
    }
  }

  int _current = 0;
  final List<String> _images = [
    'assets/image/asxxx.jpg',
    'assets/image/bg.jpg',
    'assets/image/kalilo2.jpeg',
    'assets/image/tmbnl.jpg',
    'assets/image/hutan-pinus-kalilo.jpg',
  ];

  final List<String> _packages = [
    'assets/PP/HPK-1.png',
    'assets/PP/HPK-2.png',
    'assets/PP/HPK-3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(100, 181, 246, 1),
                  Color.fromRGBO(43, 90, 219, 1),
                ],
              ),
            ),
            child: ListView(
              children: [
                Container(
                  width: 364,
                  height: 234,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/image/background.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 364,
                            height: 234,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Selamat Datang di Aplikasi Kalilo,',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Mudahkan pemesanan tiket melalui aplikasi',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(height: 20),
                      Positioned(
                        top: 184,
                        left: 23,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PemesananWidget()));
                          },
                          child: Text('Pesan Sekarang'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(70, 30),
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 13),
                            textStyle: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Row(
                            children: [
                              const Text(
                                'GALLERI',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Helvetica',
                                  fontSize: 20,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              CarouselSlider(
                                items: _images.map((image) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                            image: AssetImage(image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 16 / 9,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _images.map((image) {
                                  int index = _images.indexOf(image);
                                  return Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 2.0,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _current == index
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  child: Container(
                    child: const Text(
                      'PAKET PENGUNJUNG',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Helvetica',
                          fontSize: 20,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    ),
                  ),
                ),
                Container(
                    child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: _packages.map((package) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(package),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _packages.map((package) {
                        int index = _packages.indexOf(package);
                        return Container(
                          width: 16.0,
                          height: 16.0,
                          margin: EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _current == index ? Colors.blue : Colors.grey,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                )),
                SizedBox(height: 20),
              ],
            )),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                _iconOptions[0],
                color: _getIconColor(0),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _iconOptions[1],
                color: _getIconColor(1),
              ),
              label: 'Pemesanan',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _iconOptions[2],
                color: _getIconColor(2),
              ),
              label: 'Kalilo',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _iconOptions[3],
                color: _getIconColor(3),
              ),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _iconOptions[4],
                color: _getIconColor(4),
              ),
              label: 'Logout',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
