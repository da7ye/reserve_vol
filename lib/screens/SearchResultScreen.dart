import 'package:flutter/material.dart';
import 'package:reserve_vol/m/vols.dart';

class SearchResultScreen extends StatelessWidget {
  final Vols vol;
  final String? classValue;
  final DateTime? date;

// ?yak ngba8 valeurs vol(modele) wtype de class wla date mn page vol_screen
  SearchResultScreen({required this.vol, this.classValue, this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height * 1.8),
        child: AppBar(
          title: Center(
            child: Text(
              'Résultats de Recherche',
              style: TextStyle(fontSize: 27, color: Colors.white),
            ),
          ),
          backgroundColor: Color(0xFF0044A5),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  vol.a,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 50.0),
                Icon(Icons.airplanemode_active, size: 24),
                SizedBox(width: 50.0),
                Text(
                  vol.aPartirDe,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          vol.time,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${vol.price} MRU',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      vol.airline,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Type: ${vol.type}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${vol.passagers} ${vol.classe}',
                          style: TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle "Choisir" button click
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF0044A5),
                          ),
                          child: Text(
                            'Choisir',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
