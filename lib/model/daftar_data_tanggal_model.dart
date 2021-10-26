// To parse this JSON data, do
//
//     final daftarDataTanggal = daftarDataTanggalFromJson(jsonString);

import 'dart:convert';

DaftarDataTanggal daftarDataTanggalFromJson(String str) => DaftarDataTanggal.fromJson(json.decode(str));

String daftarDataTanggalToJson(DaftarDataTanggal data) => json.encode(data.toJson());

class DaftarDataTanggal {
  DaftarDataTanggal({
    this.status,
    this.data,
    this.pesan,
  });

  int status;
  List<Datum> data;
  dynamic pesan;

  factory DaftarDataTanggal.fromJson(Map<String, dynamic> json) => DaftarDataTanggal(
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
    this.tanggal,
    this.dataJam,
  });

  String tanggal;
  List<DataJam> dataJam;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    tanggal: json["tanggal"],
    dataJam: List<DataJam>.from(json["data_jam"].map((x) => DataJam.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tanggal": tanggal,
    "data_jam": List<dynamic>.from(dataJam.map((x) => x.toJson())),
  };
}

class DataJam {
  DataJam({
    this.gambar,
    this.ukuran,
    this.jam,
  });

  String gambar;
  String ukuran;
  String jam;

  factory DataJam.fromJson(Map<String, dynamic> json) => DataJam(
    gambar: json["gambar"],
    ukuran: json["ukuran"],
    jam: json["jam"],
  );

  Map<String, dynamic> toJson() => {
    "gambar": gambar,
    "ukuran": ukuran,
    "jam": jam,
  };
}
