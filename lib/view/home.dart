import 'package:KuyMinum/base_view.dart';
import 'package:KuyMinum/config/colors.dart';
import 'package:KuyMinum/config/string_router.dart';
import 'package:KuyMinum/config/view_state.dart';
import 'package:KuyMinum/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;
  bool isSelectedDesa = false;
  List<Map<String, String>> welcomeData = [
    {
      'image': "assets/images/w1.png",
      'text': "Minum air putih yang cukup biar kamu tetap fokus",
    },
    {
      'image': "assets/images/w2.png",
      'text': "Air putih juga bisa bantu kamu turunin berat badan loh",
    },
    {
      'image': "assets/images/w3.png",
      'text': "Rutin minum air putih bisa untuk jaga kulit kamu biar tetap sehat",
    },
    {
      'image': "assets/images/w4.png",
      'text': "Sesibuk apapun hari mu minum air putih bisa buat kamu tetap semangat",
    }
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return BaseView<LoginProvider>(
      builder: (context, prov, child){
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: bgImage, fit: BoxFit.cover)),
              child: SizedBox(
                width: double.infinity,
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 0.8.sh,
                      child: PageView.builder(
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemCount: welcomeData.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return WelcomeContent(
                            image: welcomeData[index]['image'],
                            text: welcomeData[index]['text'],
                          );
                        },
                      ),
                    ),
                    Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(welcomeData.length,
                                          (index) => buildDot(index: index)),
                                ),
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: prov.state == ViewState.Fetching
                                    ? Center(child: CircularProgressIndicator())
                                    : RaisedButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_forward),
                                        Text("Login"),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: Colors.white,
                                  onPressed: () async {
                                    var login = await prov.loginApi();
                                    // prov.state == ViewState.Fetching;
                                    if (login == true) {
                                      print("yok login yok");
                                      Navigator.pushNamed(context, StringRouter.halaman_minum);
                                      // Navigator.pushNamed(context, StringRouter.data_diri);
                                    } else {
                                      print("gagal");
                                    }
                                  },
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: SizedBox(
                              //     child: RaisedButton(
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(10.0),
                              //         child: Row(
                              //           mainAxisAlignment: MainAxisAlignment.center,
                              //           children: [
                              //             Icon(Icons.arrow_forward),
                              //             Text("Sign Up"),
                              //           ],
                              //         ),
                              //       ),
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(20)),
                              //       color: Colors.white,
                              //       onPressed: () async {
                              //         await prov.loginCoba();
                              //       },
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    // return BaseView<LoginProvider>(
    //   builder: (context, prov, child) {
    //     return Scaffold(
    //       body: Container(
    //         decoration: BoxDecoration(
    //             image: DecorationImage(image: bgImage, fit: BoxFit.cover)),
    //         height: MediaQuery.of(context).size.height,
    //         alignment: Alignment.center,
    //         child: Column(
    //           mainAxisSize: MainAxisSize.max,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(
    //               "Selamat Datang",
    //               style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(top: 130.0),
    //               child: prov.state == ViewState.Fetching
    //                   ? CircularProgressIndicator()
    //                   : RaisedButton(
    //                 onPressed: () async {
    //                   var login = await prov.signInwithGoogle();
    //                   // prov.state == ViewState.Fetching;
    //                   if (login == true) {
    //                     print("yok login yok");
    //                     Navigator.pushNamed(context, StringRouter.data_diri);
    //                   } else {
    //                     print("gagal");
    //                   }
    //                 },
    //                 color: Colors.lightBlueAccent,
    //                 shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.all(Radius.circular(20))),
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
    //                   child: Row(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       Padding(
    //                         padding:
    //                             const EdgeInsets.only(right: 10.0, left: 30.0),
    //                         child: Text("Login"),
    //                       ),
    //                       Padding(
    //                         padding:
    //                             const EdgeInsets.only(right: 20.0, left: 10.0),
    //                         child: Icon(Icons.arrow_forward_sharp),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }


  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? cPrimary : Colors.white,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

class WelcomeContent extends StatelessWidget {
  final String image;
  final String text;
  WelcomeContent({this.image, this.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(86.h),
        ),
        Text(
          "Kuy Minum",
          style: TextStyle(
              color: cPrimary,
              fontSize: ScreenUtil().setSp(96),
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.all(86.h),
        ),
        Image.asset(
          "$image",
          height: 620.h,
          width: 800.w,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "$text",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: ScreenUtil().setSp(50)),
        ),
      ],
    );
  }
}

