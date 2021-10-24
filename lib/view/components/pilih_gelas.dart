import 'package:KuyMinum/config/colors.dart';
import 'package:KuyMinum/data/data.dart';
import 'package:KuyMinum/locator.dart';
import 'package:KuyMinum/provider/minum_provider.dart';
import 'package:KuyMinum/provider/pilih_gelas_provider.dart';
import 'package:flutter/material.dart';

import '../../base_view.dart';

class PilihGelas extends StatefulWidget {
  const PilihGelas({Key key}) : super(key: key);

  @override
  _PilihGelasState createState() => _PilihGelasState();
}

class _PilihGelasState extends State<PilihGelas> {

  @override
  Widget build(BuildContext context) {
    return BaseView<MinumProvider>(
      onModelReady: (model) => model.initGelas(),
      builder: (context, prov, child){
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            child: Container(
              // height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0, bottom: 30),
                    child: Text ("Konfirmasi Minum",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text ("Apakah Anda memang minum air saat ini?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0, bottom: 30),
                    child: RaisedButton(
                      child: Text("Ya, Tentu saja"),
                        color: cPrimary,
                        onPressed: (){
                      Navigator.pop(context);
                    }),
                  )
                ],
              ),
            ));
      },
    );
  }
}
