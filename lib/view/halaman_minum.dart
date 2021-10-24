import 'package:KuyMinum/base_view.dart';
import 'package:KuyMinum/config/colors.dart';
import 'package:KuyMinum/config/string_router.dart';
import 'package:KuyMinum/config/view_state.dart';
import 'package:KuyMinum/locator.dart';
import 'package:KuyMinum/provider/firestore_provider.dart';
import 'package:KuyMinum/provider/login_provider.dart';
import 'package:KuyMinum/provider/minum_provider.dart';
import 'package:KuyMinum/view/components/list_minum.dart';
import 'package:KuyMinum/view/components/pilih_gelas.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class HalamanMinum extends StatefulWidget {
  const HalamanMinum({Key key}) : super(key: key);

  @override
  _HalamanMinumState createState() => _HalamanMinumState();
}

class _HalamanMinumState extends State<HalamanMinum> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MinumProvider>(
      onModelReady: (model) => model.initMinum(),
      builder: (context, prov, child) {
        return Scaffold(
          backgroundColor: Colors.lightBlueAccent[70],
          drawerScrimColor: Color(0xFF82b1ff),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: bgImage, fit: BoxFit.cover)),
            height: MediaQuery.of(context).size.height,
            // alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 55, right: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Material(
                        elevation: 5.0,
                        shape: CircleBorder(),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.pushNamed(
                                  context, StringRouter.pengaturan);
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            child: Icon(
                              Icons.settings_sharp,
                            ),
                            radius: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 150.0, top: 30),
                    child: Text(
                      "Selamat Datang ${locator<LoginProvider>().user.displayName}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  PieChart(
                    dataMap: prov.dataMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 2.2,
                    ringStrokeWidth: 42,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    colorList: [
                      Colors.lightBlueAccent,
                      Colors.lightBlueAccent.withOpacity(0.5)
                    ],
                    legendOptions: LegendOptions(
                      showLegends: false,
                    ),
                    centerText:
                        prov.dataMap['minum'].toInt().toString() + " ml",
                    chartValuesOptions: ChartValuesOptions(
                        showChartValues: false, decimalPlaces: 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, right: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          elevation: 5.0,
                          shape: CircleBorder(),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                prov.visibleList = !prov.visibleList;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              child: Icon(Icons.list_alt_outlined),
                              radius: 20.0,
                            ),
                          ),
                        ),
                        AvatarGlow(
                          glowColor: Color(prov.gelas['warna']),
                          endRadius: 60.0,
                          child: Material(
                            elevation: 8.0,
                            shape: CircleBorder(),
                            child: InkWell(
                              onTap: () {
                                prov.minum100ml();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return PilihGelas();
                                    });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                child: Image.asset(
                                  prov.gelas['gelas'],
                                  height: 50,
                                ),
                                radius: 30.0,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          // Replace this child with your own
                          elevation: 5.0,
                          shape: CircleBorder(),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                prov.visible = !prov.visible;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              child: Icon(Icons.wifi_protected_setup_rounded),
                              radius: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text(prov.gelas['ukuran']),
                  Visibility(
                    visible: prov.visible,
                    child: Container(
                      height: 80,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
                          itemCount: prov.listGelas.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  prov.gelas = prov.listGelas[index];
                                  prov.listGelas[index]['selected'] =
                                      !prov.listGelas[index]['selected'];
                                  for (int i = 0;
                                      i < prov.listGelas.length;
                                      i++) {
                                    if (i != index) {
                                      prov.listGelas[i]['selected'] = false;
                                    }
                                  }
                                  prov.gelasSelected(prov.listGelas[index]);
                                  // locator<MinumProvider>().initGelas();
                                });
                              },
                              child: Card(
                                color: prov.listGelas[index]['selected']
                                    ? Colors.lightBlueAccent
                                    : Colors.white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      flex: 5,
                                      child: Image.asset(
                                        prov.listGelas[index]['gelas'],
                                      ),
                                    ),
                                    Text(
                                      prov.listGelas[index]['ukuran'],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  prov.state == ViewState.FetchNull
                      ? Text("Anda Belum Minum Hari ini")
                      : Visibility(
                          visible: prov.visibleList,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      prov.state == ViewState.FetchNull
                                          ? "Anda Belum Minum Hari ini"
                                          : "Riwayat Minum",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  prov.state == ViewState.Fetching
                                      ? CircularProgressIndicator()
                                      : Column(
                                          children: List.generate(
                                              prov.riwayatMinum.data.length,
                                              (index) => ListMinum(
                                                    gambar: prov.riwayatMinum
                                                        .data[index].gambar,
                                                    jam: prov.riwayatMinum
                                                        .data[index].jam,
                                                    ukuran: prov.riwayatMinum
                                                        .data[index].ukuran,
                                                  ))),
                                ],
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
