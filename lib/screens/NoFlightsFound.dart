import 'package:flutter/material.dart';

class NoFlightsFoundScreen extends StatelessWidget {
  final String aPartirDeValue;
  final String aValue;

// ?yak ngba8 valeurs aPartirDe wdestination mn page vol_screen
  NoFlightsFoundScreen(
      {required this.aPartirDeValue,
      required this.aValue}); 

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  aPartirDeValue,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 50.0),
                Icon(Icons.airplanemode_active, size: 24),
                SizedBox(width: 50.0),
                Text(
                  aValue,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 130.0), // Add spacing
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.report_problem_outlined,
                  color: Colors.red,
                  size: 80.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  "Il n'ya aucun vol trouvé ce jour",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
