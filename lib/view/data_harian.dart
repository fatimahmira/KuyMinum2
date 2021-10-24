import 'dart:convert';

import 'package:KuyMinum/base_view.dart';
import 'package:KuyMinum/config/colors.dart';
import 'package:KuyMinum/config/view_state.dart';
import 'package:KuyMinum/provider/data_hariaan_provider.dart';
import 'package:KuyMinum/provider/firestore_provider.dart';
import 'package:KuyMinum/view/components/list_minum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataHarian extends StatefulWidget {
  const DataHarian({Key key}) : super(key: key);

  @override
  _DataHarianState createState() => _DataHarianState();
}

class _DataHarianState extends State<DataHarian> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return BaseView<DataHarianProvider>(
        // onModelReady: (prov) => prov.fetchDataHarian(),
        builder: (context, prov, child) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async{
                // prov.delete();
            },
              child: Icon(Icons.delete),
            ),
              appBar: AppBar(
                elevation: 0,
                title: Text("Data Minum Harian"),
              ),
              body:
              prov.state == ViewState.Fetching
                  ? CircularProgressIndicator()
                  : Column(
                children: [
                  ListTile(
                    // subtitle:  ,
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(
                      Icons.notifications_active_sharp,
                    ),
                    title: Text(
                      "Tanggal",
                    ),
                  ),
                ],
                    )
              );
        });
  }
}
