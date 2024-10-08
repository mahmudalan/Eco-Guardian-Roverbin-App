import 'individual_bar.dart';

class BarData{
  final double senin;
  final double selasa;
  final double rabu;
  final double kamis;
  final double jumat;
  final double sabtu;
  final double minggu;

  BarData ({
    required this.senin,
    required this.selasa,
    required this.rabu,
    required this.kamis,
    required this.jumat,
    required this.sabtu,
    required this.minggu
  });

  List<IndividualBar> barData = [];

  //pengenalan bar data
  void initializedBarData() {
    barData = [
      //sen
      IndividualBar(x: 0, y:  senin),
      //sel
      IndividualBar(x: 1, y:  selasa),
      //rab
      IndividualBar(x: 2, y:  rabu),
      //kam
      IndividualBar(x: 3, y:  kamis),
      //jum
      IndividualBar(x: 4, y:  jumat),
      //sab
      IndividualBar(x: 5, y:  sabtu),
      //min
      IndividualBar(x: 6, y:  minggu),
    ];
  }

}