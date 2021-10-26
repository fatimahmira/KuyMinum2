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
        onModelReady: (prov) => prov.init(),
        builder: (context, prov, child) {
          return Scaffold(
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () async {
              //     prov.hapus();
              //   },
              //   child: Icon(Icons.delete),
              // ),
              appBar: AppBar(
                elevation: 0,
                title: Text("Data Minum Harian"),
              ),
              body: prov.state == ViewState.Fetching
                  ? Center(child: CircularProgressIndicator())
                  : prov.state == ViewState.FetchNull
                  ? Center(child: Text("Tidak Ada Data"))
                  : SingleChildScrollView(
                      child: Column(
                          children: List.generate(
                              prov.listTanggal.data.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15.0, top: 25),
                                          child: Text(
                                              prov.listTanggal.data[index]
                                                  .tanggal,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Card(
                                          child: Column(
                                            children: List.generate(
                                                prov.listTanggal.data[index]
                                                    .dataJam.length,
                                                (index2) => ListMinum(
                                                      ukuran: prov
                                                          .listTanggal
                                                          .data[index]
                                                          .dataJam[index2]
                                                          .ukuran,
                                                      gambar: prov
                                                          .listTanggal
                                                          .data[index]
                                                          .dataJam[index2]
                                                          .gambar,
                                                      jam: prov
                                                          .listTanggal
                                                          .data[index]
                                                          .dataJam[index2]
                                                          .jam,
                                                    )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))),
                    ));
        });
  }
}
