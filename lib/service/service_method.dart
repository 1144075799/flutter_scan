import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';

// 获取商品的信息
Future request(barcode) async{
  try {
    print('开始获取信息');
    Response response;
    Dio dio=new Dio();
    String barCode=barcode.toString();
    var data={"barcode":barCode};
    print(data);
    response=await dio.get("http://www.mxnzp.com/api/barcode/goods/details",queryParameters: data);
    print(response.data['code']);
    if(response.data['code']==1){
      print(response.data['data']);
      return response.data['data'];
    }else{
      throw Exception('后端端口异常');
    }
  } catch (e) {
    return print('ERROR:=========>${e}');
  }
}

