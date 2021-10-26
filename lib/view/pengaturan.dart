import 'package:KuyMinum/base_view.dart';
import 'package:KuyMinum/config/colors.dart';
import 'package:KuyMinum/config/string_router.dart';
import 'package:KuyMinum/config/view_state.dart';
import 'package:KuyMinum/locator.dart';
import 'package:KuyMinum/main.dart';
import 'package:KuyMinum/provider/login_provider.dart';
import 'package:KuyMinum/provider/pengaturan_provider.dart';
import 'package:KuyMinum/view/components/dialog_notifikasi.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({Key key}) : super(key: key);

  @override
  _PengaturanState createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {

  @override
  Widget build(BuildContext context) {
    return BaseView<PengaturanProvider>(
      onModelReady: (model) async => await model.init(),
      builder: (context, prov, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: Text("Pengaturan"),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: prov.state == ViewState.Fetching
                  ? CircularProgressIndicator()
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          // subtitle:  ,
                          contentPadding: EdgeInsets.all(0),
                          leading: Icon(
                            Icons.notifications_active_sharp,
                          ),
                          trailing: DropdownButton(
                            // icon: Container(),
                            value: prov.selected,
                            items: prov.list.map((String val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Text(val),
                              );
                            }).toList(),
                            onChanged: (String value) async{
                              setState(() {
                                prov.selected = value;
                                prov.ubahNotifikasi();
                              });
                              // await AndroidAlarmManager.periodic(
                              //     Duration(minutes: value), 0, doNotification);

                            },
                          ),
                          title: Text(
                            "Notifikasi",
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Icon(
                            Icons.article,
                          ),
                          title: Text(
                            "Data Minum Harian",
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, StringRouter.data_minum);
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Icon(Icons.logout, color: colorDanger),
                          title: Text(
                            "Keluar",
                            style: TextStyle(color: colorDanger),
                          ),
                          onTap: () async {
                            await prov.keluar();
                              Navigator.pushReplacementNamed(
                                  context, StringRouter.home);

                          },
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
