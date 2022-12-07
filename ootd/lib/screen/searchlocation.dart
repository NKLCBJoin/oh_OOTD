//이용구 주소 검색받아 페이지


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:ootd/API/setlocation.dart';
import 'package:ootd/model/model.dart';

import 'loading.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.deepPurple,
      // ),
      home: const LocationSet(title: '주소 검색'),
    );
  }
}


class LocationSet extends StatefulWidget {
  const LocationSet({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LocationSet> createState() => _LocationSetState();
}

class _LocationSetState extends State<LocationSet> {


  TextEditingController _AddressController = TextEditingController(); //텍스트 컨트롤러 생성
  location_func location_class = location_func(); //클래스 생성


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>Loading()));
            },
          ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  DarkMode.DarkOn? Color(0xff29323c) : Color(0xffa1c4fd), //DarkMode.DarkOn? Colors.grey[900] :Colors.blue[300],
                  DarkMode.DarkOn? Color(0xff485563) :Color(0xffc2e9fb),
                ]
            )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(padding: const EdgeInsets.all(60)),

                  Icon(Icons.location_on,size: 130,color: Colors.indigoAccent,),

                  Padding(padding: const EdgeInsets.all(30)),

                  Text(Language.En?'Address':'주소', style: TextStyle(fontSize: 30, color:  DarkMode.DarkOn?Colors.white:Colors.blueGrey)),

                  Padding(padding: const EdgeInsets.all(10)),

                  AddressText(),

                  Padding(padding: const EdgeInsets.all(10)),

                  InkWell(//위치 설정UI
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7.0,
                            offset: Offset(4, 6), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(Language.En?'set to search location':"위치 설정", style: TextStyle(fontSize: 17, color: Colors.white)),
                      )
                    ),
                      onTap: (){
                        LoadingData.Lol = false;
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>Loading()));
                      },
                  ),

                  Padding(padding: const EdgeInsets.all(10)),
                  InkWell(//위치 설정UI
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.05,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7.0,
                              offset: Offset(4, 6), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(Language.En?'set to current location':"현재 위치로 설정", style: TextStyle(fontSize: 17, color: Colors.white)),
                        )
                    ),
                    onTap: ()async{
                      print("현재 위치 주소");
                      await location_class.Nowlocation(); //이 함수를 실행시켜 전역변수 x_pos와 y_pos와 gu, si를 현재 기준으로 변경한다.
                      //미완성 이동 코드
                      LoadingData.Lol = false;
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>Loading()));
                    },
                  ),
                 /* SizedBox(
                    height: 50,
                    width: double.infinity,
                    child:TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey),
                      child: Text("현재 위치로 설정", style: TextStyle(fontSize: 17, color: Colors.white)),
                      onPressed: () async {
                        print("현재 위치 주소");
                        await location_class.Nowlocation(); //이 함수를 실행시켜 전역변수 x_pos와 y_pos와 gu, si를 현재 기준으로 변경한다.
                        //미완성 이동 코드
                        LoadingData.Lol = false;
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>Loading()));
                      },
                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget AddressText() {//주소를 보여주는 창 위젯으로 처리
    return GestureDetector( //빈곳까지 터치 가능하게 하는 코드?
      onTap: () { //눌럿을 경우 카카오 api 실행
        HapticFeedback.mediumImpact();
        _addressAPI(); // 카카오 주소 API 실행
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _AddressController, //이 컨트롤러를 이용해 값을 바로 가져온는 듯
            enabled: false,
            //decoration: InputDecoration(isDense: false,),
            autocorrect: true,
            decoration:  InputDecoration(hintText: Language.En?'Search address':'주소 검색하기',hintStyle:TextStyle(color: DarkMode.DarkOn?Colors.white70:Colors.blueGrey[200] ) ),
            maxLines: 2,
            minLines: 1,
            style: TextStyle(fontSize: 20
            ,color:  DarkMode.DarkOn?Colors.white70:Colors.blueGrey[200]),
          ),
        ],
      ),
    );
  }


  _addressAPI() async {
    //카카오 주소 api
    String api_return_adress;
    KopoModel model = await Navigator.push(
      context, CupertinoPageRoute(builder: (context) => RemediKopo(),
    ),
    );
    _AddressController.text = '${model.address!} ${model.buildingName!}';
    //print(_AddressController.toString());
    api_return_adress = model.address.toString() + model.buildingName.toString();

    location.address = api_return_adress; //전역변수에 주소값 넣기.
    location_class.fetchData(); //좌표 얻는 함수 실행 > x_pos, y_pos에 값 들어감
  }
}

