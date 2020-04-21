class ComResult {
  ComData data;
  int errorCoder;
  String errorMsg;

  ComResult.fromJson(Map<String, dynamic> json){
    errorCoder = json['errorCoder'];
    errorMsg = json['errorMsg'];
    data = json['data'] != null ? new ComData.fromJson(json['data']) : null;
  }

}

class ComData{

  int size;
  List datas;

  ComData.fromJson(Map<String, dynamic> json)
      : size = json['size'],
  datas = json['datas'];
}