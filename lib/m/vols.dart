import 'package:cloud_firestore/cloud_firestore.dart';

class Vols {
  String a;
  String aPartirDe;
  String classe;
  Timestamp date;
  int passagers;
  String type;
  String airline;
  String price;
  String time;

  Vols({
    required this.a,
    required this.aPartirDe,
    required this.classe,
    required this.date,
    required this.passagers,
    required this.type,
    required this.airline,
    required this.time,
    required this.price,
  });
}
