import 'package:dio/dio.dart';
import 'package:notes/data/getallnoterespo/getallnoterespo.dart';
import 'package:notes/data/notedata/notedata.dart';
import 'package:notes/data/uri.dart';

abstract class Apicalls {
  Future<Notedata?> createnote(Notedata value);
  Future<List<Notedata>> getallnote();
  Future<Notedata?> updatenote(Notedata value);
  Future<void> deletenote(String id);
}

final dio = Dio();
final url = Url();

class Notedb extends Apicalls {
  @override
  Future<Notedata?> createnote(Notedata value) async {
    final _result = await dio.post<Notedata>(url.baseurl + url.createnote);
    return _result.data;
  }

  @override
  Future<void> deletenote(String id) async {
    // TODO: implement deletenote
    throw UnimplementedError();
  }

  @override
  Future<List<Notedata>> getallnote() async {
    final _result = await dio.get<Getallnoterespo>(url.baseurl + url.getnote);
    if (_result.data == null) {
      return [];
    } else {
      return _result.data!.data;
    }
  }

  @override
  Future<Notedata?> updatenote(Notedata value) async {
    // TODO: implement updatenote
    throw UnimplementedError();
  }
}
