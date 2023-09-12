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
    //error for missing a dynamic missing data
    try {
      final _result = await dio.post<Notedata>(
        url.baseurl + url.createnote,
        data: value.toJson(),
      );
      return _result.data;
    } on DioError catch (e) {
      print(e.response?.data);
      print(e);
    } catch (e) {
      print(e.toString());
    }
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
