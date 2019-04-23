import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import './service/service_method.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String barcode = null;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('反盗版商品'),
          
        ),
        body: Container(
          margin: EdgeInsets.only(top: 0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FutureBuilder(
                future: request(barcode),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    Map projectItem=snapshot.data;

                    return projectMessage(projectItem:projectItem);

                  }else{
                      return Center(
                        child:Text('请扫描相关的条形码')
                      );
                    }
                },
              ),
              //Text(barcode),
              MaterialButton(
                onPressed: scan,
                child: Text("Scan"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await scanner.scan();
      setState(() => this.barcode = barcode);
    } on Exception catch (e) {
      if (e == scanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}

 class projectMessage extends StatelessWidget {
    final Map projectItem;

    const projectMessage({Key key,this.projectItem}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return Container(
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title:new Text('商品名字',style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: new Text(projectItem['goodsName']),
                leading: new Icon(Icons.account_box,color: Colors.lightBlue,),
              ),
              new Divider(),
              ListTile(
                title:new Text('商品价格',style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: new Text(projectItem['price']),
                leading: new Icon(Icons.account_box,color: Colors.lightBlue,),
              ),
              new Divider(),
              ListTile(
                title:new Text('商标名称',style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: new Text(projectItem['brand']),
                leading: new Icon(Icons.account_box,color: Colors.lightBlue,),
              ),
              new Divider(),
              ListTile(
                title:new Text('生产公司',style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: new Text(projectItem['supplier']),
                leading: new Icon(Icons.account_box,color: Colors.lightBlue,),
              ),
            ],
          ),
        ),
      );
    }
  }

class Qrscan {
}