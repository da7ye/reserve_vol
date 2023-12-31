import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reserve_vol/controllers/vols_controller.dart';
import 'package:reserve_vol/m/vols.dart';
import 'package:reserve_vol/screens/NoFlightsFound.dart';
import 'package:reserve_vol/screens/SearchResultScreen.dart';
import 'package:reserve_vol/widget/my_button.dart';

import '../widget/myDropDownMenu.dart';

class VolScreen extends StatefulWidget {
  @override
  _VolScreenState createState() => _VolScreenState();
}

class _VolScreenState extends State<VolScreen> {
  final volsController _volsController = Get.put(volsController());
  TextEditingController _dateController = TextEditingController();

//? tout les valeurs li lahi mzlt ngb8 mn formulaire
  String? _fromValue;
  String? _toValue;
  DateTime? _dateValue;
  String? _passengerValue;
  String? _classValue;
  String? _typeValue;

// ? nb7ch 3n les donnees li ndor mn firebase
  Future<void> searchFlightsFromFirebase(
    String from,
    String to,
    DateTime? date,
    String classe,
    String type,
    int passengers,
  ) async {
    final volsController _volsController = Get.find<volsController>();
    _volsController.setIsLoadingVols(true);

// ?  nverifie les donnees li ndor mn firebase 1 par 1
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      Query<Map<String, dynamic>> query = firebaseFirestore.collection('Vols');

      if (from.isNotEmpty) {
        query = query.where('a', isEqualTo: from);
      }
      if (to.isNotEmpty) {
        query = query.where('aPartirDe', isEqualTo: to);
      }
      if (date != null) {
        query = query.where('date', isEqualTo: date);
      }
      if (classe.isNotEmpty) {
        query = query.where('classe', isEqualTo: classe);
      }
      if (type.isNotEmpty) {
        query = query.where('type', isEqualTo: type);
      }
      if (passengers > 0) {
        query = query.where('passagers', isEqualTo: passengers);
      }

      _volsController.vols.clear(); // n5wi le controller v7altou vih donnees 
      
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data();
//?   nrba6 les donnees li gab8 mn formulaire m3a 4ouk li ndor vfirebase
        Vols vol = Vols(
          a: data['a'] ?? '',
          aPartirDe: data['aPartirDe'] ?? '',
          classe: data['classe'] ?? '',
          date: data['date'] ?? '',
          passagers: data['passagers'] ?? '',
          price: data['price'] ?? '',
          time: data['time'] ?? '',
          airline: data['airline'] ?? '',
          type: data['type'] ?? '',
        );

        _volsController.vols.add(vol); 
      }

// ? nverifie si le vol exist ngiss SearchResultScreen() sinon ngiss NoFlightsFoundScreen()
      if (_volsController.vols.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchResultScreen(
              vol: _volsController.vols.first,
              classValue: _classValue,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoFlightsFoundScreen(
              aPartirDeValue: _fromValue ?? '',
              aValue: _toValue ?? '',
            ),
          ),
        );
      }

      _volsController.setIsLoadingVols(false);
    } catch (error) {
      print('Error searching for flights: $error');
      _volsController.setIsLoadingVols(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 60), 
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF0044A5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'A partir de',
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white70),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _fromValue = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'A',
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white70),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _toValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          readOnly: true,
                          controller: _dateController,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _dateValue ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                            );

                            if (pickedDate != null &&
                                pickedDate != _dateValue) {
                              setState(() {
                                _dateValue = pickedDate;
                                _dateController.text =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                              });
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Date',
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white70),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: MyDropdownMenu(
                          labelText: 'Type:',
                          items: ['One way', 'Two way'],
                          value: _typeValue,
                          onChanged: (String? value) {
                            setState(() {
                              _typeValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Passengers',
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white70),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _passengerValue = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: MyDropdownMenu(
                          labelText: 'Class:',
                          items: ['Economy', 'First class'],
                          value: _classValue,
                          onChanged: (String? value) {
                            setState(() {
                              _classValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: MyButton(
                onPressed: () {
                  if (_fromValue != null &&
                      _toValue != null &&
                      _dateValue != null &&
                      _classValue != null &&
                      _typeValue != null &&
                      _passengerValue != null) {
                    searchFlightsFromFirebase(
                      _fromValue!,
                      _toValue!,
                      _dateValue!,
                      _classValue!,
                      _typeValue!,
                      int.parse(_passengerValue!),
                    );
                  } else { //? en cas l'un des chemps est null
                    print("One or more input values are null");
                  }
                },
                title: 'Recherche',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
