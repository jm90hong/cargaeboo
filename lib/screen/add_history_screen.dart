

import 'package:cargaeboo/config/my_widget.dart';
import 'package:flutter/material.dart';

import '../config/my_color.dart';
import '../database.dart';
import '../entity/car.dart';
import '../entity/history.dart';
import '../entity/parts.dart';
import '../util/my_util.dart';


class AddHistoryScreen extends StatefulWidget {
  Car car;
  AddHistoryScreen({required this.car});

  @override
  State<AddHistoryScreen> createState() => _AddHistoryScreenState();
}

class _AddHistoryScreenState extends State<AddHistoryScreen> {

  TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey.shade500);
  TextEditingController distanceController = TextEditingController();
  List<Parts> allParts = [];
  List<String> dropdownList = [];
  String selectedDropdown = '';
  String _selectedDate='날짜 선택';

  void init() async{
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final partsDao = database.partsDao;
    allParts = await partsDao.findAllParts();
    allParts.forEach((element) {
      dropdownList.add(element.name);
    });
    selectedDropdown=dropdownList[0];
    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('교환이력 등록',style: TextStyle(fontWeight: FontWeight.bold),)
      ),
      body: FullContainer(
        padding: EdgeInsets.symmetric(horizontal: 16), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50,),
                    Text('무엇을 교환하셨나요?',style: titleStyle,),
                    DropdownButton(
                      value: selectedDropdown,
                      items: dropdownList.map((String item) {
                        return DropdownMenuItem<String>(
                          child: Text('$item'),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          selectedDropdown = value;
                        });
                      },
                    ),
                    SizedBox(height: 25,),
                    Text('언제 교환하셨나요?',style: titleStyle,),
                    OutlinedButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          ).then((selectedDate) {
                            setState(() {
                              var year = selectedDate?.year.toString();
                              var month = selectedDate?.month.toString();
                              var day = selectedDate?.day.toString();

                              setState(() {
                                _selectedDate='$year년 $month월 $day일';
                              });


                            });
                          });
                        },
                        child: Text(_selectedDate)
                    ),


                    SizedBox(height: 25,),
                    Text('교환시 현재 차량 \n주행거리는 얼마인가요?',style: titleStyle,),

                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      width: MediaQuery.of(context).size.width*0.8,
                      child: TextFormField(
                        controller: distanceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: '10000',
                            labelText: '현재 주행거리 (km)',
                            labelStyle: TextStyle(fontWeight:FontWeight.bold)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            LongButton(
                width: MediaQuery.of(context).size.width*0.9,
                borderRadius: 10,
                onTap: () async {

                  if(_selectedDate=='날짜선택'){
                    MyUtil.showToast('날짜를 선택해주세요');
                    return;
                  }

                  if(distanceController.text.isEmpty){
                    MyUtil.showToast('현재 주행거리를 입력해주세요');
                    return;
                  }

                  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
                  final historyDao = database.historyDao;
                  History history = History(
                      carIdx: widget.car.idx??0,
                      partsIdx: allParts.firstWhere((element) => element.name==selectedDropdown).idx??0,
                      distance: distanceController.text.toString(),
                      date: _selectedDate
                  );

                  historyDao.insertHistory(history);
                  MyUtil.showToast('교환이력 등록 완료');
                  Navigator.of(context).pop();
                }, 
              text: '등록하기',
              backgroundColor: MyColor.mainColor,
            )
          ],
        ),
      ),
    );
  }



}
