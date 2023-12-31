import 'package:flutter/material.dart';
import 'package:reserve_vol/screens/hotesls_screen.dart';
import 'package:reserve_vol/screens/vol_screen.dart';

class MyTabbedScreen extends StatefulWidget {
  @override
  _MyTabbedScreenState createState() => _MyTabbedScreenState();
}

// ? tabscreen jam3a le deux screens vols w hotels.
class _MyTabbedScreenState extends State<MyTabbedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height * 1.8),
        child: AppBar(
          title: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
                children: [
                  TextSpan(text: 'Choisissez '),
                  TextSpan(
                    text: 'Votre Voyage',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Color(0xFF0044A5),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Center(
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: 0.8,
                            child: Icon(Icons.airplanemode_active),
                          ),
                          SizedBox(width: 8.0),
                          Text('Vol'),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.business),
                          SizedBox(width: 8.0),
                          Text('Hotels'),
                        ],
                      ),
                    ),
                  ],
                  labelPadding: EdgeInsets.symmetric(horizontal: 40.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                VolScreen(),
                HotelsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
