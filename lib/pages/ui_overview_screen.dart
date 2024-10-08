import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../bloc/ui_bloc.dart';
import '../chart/bar_graph.dart';
import '../services/realtime_db.dart';

class UIOverviewScreen extends StatefulWidget {
  @override
  State<UIOverviewScreen> createState() => _UIOverviewScreenState();
}

class _UIOverviewScreenState extends State<UIOverviewScreen> {

  bool isIoTOn = false;
  dynamic beratSampah;
  bool isMoving = false;
  List<double> HistorySampah = [
    1.4,
    5.2,
    2.6,
    6.5,
    4.3,
    7.8,
    5.4
  ];

  @override
  void initState(){
    dataSampah.onValue.listen((event) {
      final getdataSampah = event.snapshot;
      setState(() {
        beratSampah = getdataSampah.value;
      });
    });

    super.initState();
  }

  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UIBloc()..add(onUIEventCalled()),
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black87,
              title: Text('Eco Guardian Roverbin'),
              actions: [
                IconButton(
                    onPressed: signUserOut,
                    icon: Image.asset('lib/images/exit.png', color: Colors.white, height: 20,)
                )
              ],
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('lib/images/home.png', color: Colors.white,height: 25),
                        Padding(
                          padding: const EdgeInsets.only(left: 10 ),
                          child: Text('Home'),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('lib/images/notification.png', color: Colors.white,height: 25),
                        Padding(
                          padding: const EdgeInsets.only(left: 10 ),
                          child: Text('Notifications'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: BlocBuilder<UIBloc, UIState> (
              builder: (context, state){
                if (state is UILoading){
                  return Center(
                    child : CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                if (state is UILoaded){
                  return TabBarView(
                    children: [
                      buildHomeTab(),
                      buildNotifikasiTab(),
                    ],
                  );
                }
                return Container();
              },
            ),
          )
      ),
    );
  }

  Widget buildHomeTab() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            buildDiagramSampah(),
            SizedBox(height: 10),
            buildControlSystemCard(),
            SizedBox(height: 10),
            buildBeratSampahCard(),
            SizedBox(height: 10),
            buildMoveButton(),
          ],
        ),
      ),
    );
  }

  Widget buildDiagramSampah(){
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: SizedBox(
          height: 150,
          child: MyBarGraph(
            HistorySampah : HistorySampah,
          ),
        ),
      ),
    );
  }

  Widget buildControlSystemCard() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Text(
            'Control System',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          buildIoTSwitch(),
          SizedBox(height: 20),
          buildIoTStatusText(),
        ],
      ),
    );
  }

  Widget buildIoTSwitch() {
    return FlutterSwitch(
      width: 75.0,
      activeColor: Colors.black87,
      height: 45.0,
      valueFontSize: 17.0,
      toggleSize: 30.0,
      value: isIoTOn,
      borderRadius: 30.0,
      padding: 4.0,
      showOnOff: false,
      onToggle: (val) {
        setState(() {
          isIoTOn = val;
        });
      },
    );
  }

  Widget buildIoTStatusText() {
    return Text(
      isIoTOn ? 'Eco Guardian Roverbin: On' : 'Eco Guardian Roverbin: Off',
      style: TextStyle(fontSize: 16),
    );
  }

  Widget buildBeratSampahCard() {
    return Container(
      padding: EdgeInsets.only(right: 95.0, left: 95.0, top: 13.0, bottom: 13.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          const Text(
            'Volume Sampah (Kg)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          buildSleekCircularSlider(),
        ],
      ),
    );
  }

  Widget buildSleekCircularSlider() {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        startAngle: 150,
        angleRange: 240,
        customColors: CustomSliderColors(
          progressBarColor: Colors.black,
        ),
        infoProperties: InfoProperties(
          mainLabelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          modifier: (double value) {
            beratSampah = value;
            return 'Now: $value Kg';
          },
        ),
      ),
      min: 0,
      max: 10,
      initialValue: beratSampah.toDouble(),
      onChange: null,
    );
  }

  Widget buildMoveButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(1.0),
      child: ElevatedButton.icon(
        onPressed: () {
          setState(() {
            isMoving = !isMoving;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isMoving ? Colors.red : Colors.black87,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        icon: Icon(isMoving ? Icons.stop : Icons.play_arrow),
        label: Text(isMoving ? 'Stop Moving' : 'Start Moving'),
      ),
    );
  }


  Widget buildNotifikasiTab() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildNotifikasiItem(
              'Tempat Sampah Bersih',
              'Sampah berhasil dibuang.',
            ),
            buildNotifikasiItem(
              'Sampah Menumpuk!',
              'Kondisi berat sampah melebihi batas.',
            ),
            buildNotifikasiItem(
              'Tempat Sampah Gagal Terhubung',
              'Cek Tempat Sampah Secara Manual dan hubungkan ulang.',
            ),
            buildNotifikasiItem(
              'Tempat Sampah Bersih',
              'Sampah berhasil dibuang.',
            ),
            buildNotifikasiItem(
              'Sampah Menumpuk!',
              'Kondisi berat sampah melebihi batas.',
            ),

            // ... Tambahkan notifikasi lainnya
          ],
        ),
      ),
    );
  }

  Widget buildNotifikasiItem(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          SizedBox(height: 4.0),
          Text(
            'Waktu: ${DateTime.now().toLocal()}',
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
      trailing: Icon(Icons.notification_important),
    );
  }
}