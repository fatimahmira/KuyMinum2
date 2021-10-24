// To parse this JSON data, do
//
//     final daftarDataHarian = daftarDataHarianFromJson(jsonString);

import 'dart:convert';

DaftarDataHarian daftarDataHarianFromJson(String str) => DaftarDataHarian.fromJson(json.decode(str));

String daftarDataHarianToJson(DaftarDataHarian data) => json.encode(data.toJson());

class DaftarDataHarian {
  DaftarDataHarian({
    this.status,
    this.data,
    this.pesan,
  });

  int status;
  List<Datum> data;
  dynamic pesan;

  factory DaftarDataHarian.fromJson(Map<String, dynamic> json) => DaftarDataHarian(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    pesan: json["pesan"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "pesan": pesan,
  };
}

class Datum {
  Datum({
    this.gambar,
    this.ukuran,
    this.tgl,
    this.jam,
  });

  String gambar;
  String ukuran;
  String tgl;
  String jam;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    gambar: json["gambar"],
    ukuran: json["ukuran"],
    tgl: json["tgl"],
    jam: json["jam"],
  );

  Map<String, dynamic> toJson() => {
    "gambar": gambar,
    "ukuran": ukuran,
    "tgl": tgl,
    "jam": jam,
  };
}
