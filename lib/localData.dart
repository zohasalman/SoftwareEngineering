import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
//import 'user.dart';

Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
}

Future<File> get _localFile async{
  final path = await _localPath;
  return File('$path/userdata.txt');
}

void writeContent(dynamic data) async {
  final file = await _localFile;
  var sink = file.openWrite();
  print(data);
  sink.write(jsonEncode(data));
  sink.close();
}

Future<String> readContent() async{
  try{
    final file = await _localFile;
    String content = await file.readAsString();

    //print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    //print(content);
    //print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    return content;
  }catch(e){
    return e.toString();
  }
}
