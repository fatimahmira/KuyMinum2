import 'package:KuyMinum/config/colors.dart';
import 'package:KuyMinum/config/string_router.dart';
import 'package:flutter/material.dart';

class DataDiri extends StatefulWidget {
  const DataDiri({Key key}) : super(key: key);

  @override
  _DataDiriState createState() => _DataDiriState();
}

class _DataDiriState extends State<DataDiri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: cPrimary,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: bgImage,
                fit: BoxFit.cover
            )
        ),
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Apa Kegiatan Kamu Hari ini?"),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, StringRouter.halaman_minum);
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
