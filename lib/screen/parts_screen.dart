import 'package:cargaeboo/config/my_widget.dart';
import 'package:cargaeboo/model/parts_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/my_color.dart';
import '../database.dart';
import '../entity/parts.dart';
import '../util/my_util.dart';
import 'add_parts_screen.dart';

class PartsScreen extends StatefulWidget {
  const PartsScreen({super.key});

  @override
  State<PartsScreen> createState() => _PartsScreenState();
}

class _PartsScreenState extends State<PartsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PartsModel>(context,listen: false).getMyParts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Colors.white,
        title: const Text('내 소모품',style: TextStyle(fontFamily: 'nt_bold',color: Colors.black),)
      ),
      body: FullContainer(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 25,),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('소모품을 등록하여',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                  Text('차량을 주기적으로 관리하세요' ,style: TextStyle(color: MyColor.mainColor,fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Container(
                child: SingleChildScrollView(
                  child: Consumer<PartsModel>(builder: (context, partsModel, child){
                      return Column(
                        children: partsModel.myParts.map((e) => PartsBox(parts: e)).toList(),
                      );
                    },
                  )
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColor.mainColor,
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddPartsScreen(isNew: true,)),
          );
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}

class PartsBox extends StatelessWidget {
  Parts parts;

  PartsBox({required this.parts});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddPartsScreen(
            isNew: false,
            idx: parts.idx ?? 0,
            name: parts.name,
          )),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 18),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(parts.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),

                  parts.durationPeriod != '' ?
                  Text('교환 주기 : ${parts.durationDistance} km 혹은 ${parts.durationPeriod} 개월',style: TextStyle(color: Colors.black87),) :
                  Text('교환 주기 : ${parts.durationDistance} km',style: TextStyle(color: Colors.black87)),
                ],
              ),
            ),
            IconButton(
                onPressed: (){
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('소모품 삭제'),
                        content: Text(
                            '${parts.name} 을 삭제 하시겠습니까?'
                        ),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('삭제하기'),
                            onPressed: () async{

                              final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
                              final partsDao = database.partsDao;

                              partsDao.deletePartsByIdx(parts.idx ?? 0);
                              Provider.of<PartsModel>(context,listen: false).getMyParts();
                              MyUtil.showToast('${parts.name} 삭제 완료');
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text('취소'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.remove_circle_outline,size: 24,color: Colors.grey.shade400,)
            )

          ],
        ),
      ),
    );
  }
}

