import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ListMinum extends StatefulWidget {
  final String gambar;
  final String jam;
  final String ukuran;

  const ListMinum({Key key, this.gambar, this.jam, this.ukuran}) : super(key: key);

  @override
  _ListMinumState createState() => _ListMinumState();
}

class _ListMinumState extends State<ListMinum> {
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
        isFirst: true,
        indicatorStyle: IndicatorStyle(
      indicatorXY: 0.0,
      height: 50,
      width: 50,
      indicator: CircleAvatar(
        child: Image.asset(
          widget.gambar,
          // 'assets/images/1.png',
        ),
        backgroundColor: Colors.white,
      )),
        afterLineStyle: LineStyle(
    thickness: 1
        ),
        axis: TimelineAxis.vertical,
        endChild: Padding(
    padding: const EdgeInsets.only(top: 10.0, bottom: 35),
    child: InkWell(
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                  widget.jam,
                  // "jam",
                  style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8.0),
            child: Text(
              widget.ukuran,
              // "100 ml",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
      ],
    ),
        )),
        ),
      );
  }
}
