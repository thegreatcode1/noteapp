import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
// singleton ctration start
  Notedb._internal();
  static Notedb instance = Notedb._internal();
  Notedb factory() {
    return instance;
  }
// singleton end

  Notedb() {
    dio.options = BaseOptions(
      baseUrl: url.baseurl,
      responseType: ResponseType.plain,
    );
  }

  ValueNotifier<List<Notedata>> notelistnotifier = ValueNotifier([]);

  @override
  Future<Notedata?> createnote(Notedata value) async {
    //error for missing a dynamic missing data
    try {
      final _result = await dio.post(
        url.createnote,
        data: value.toJson(),
      );
      final _resultAsfronjson = jsonDecode(_result.data);
      print(_resultAsfronjson);
      return Notedata.fromJson(_resultAsfronjson as Map<String, dynamic>);
    } on DioError catch (e) {
      print(e.response?.data);
      print(e);
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Future<void> deletenote(String id) async {
    // TODO: implement deletenote
    throw UnimplementedError();
  }

  @override
  Future<List<Notedata>> getallnote() async {
    final completeUrl = '${url.baseurl}${url.getnote}';
    final _result = await dio.get(completeUrl);

    if (_result.data != null) {
      if (_result.data is String) {
        // If data is a string, parse it as JSON
        final getallnoteresp =
            Getallnoterespo.fromJson(jsonDecode(_result.data));
        notelistnotifier.value.clear();
        notelistnotifier.value.addAll(getallnoteresp.data.reversed);
        notelistnotifier.notifyListeners();
        return getallnoteresp.data;
      } else if (_result.data is Map<String, dynamic>) {
        // If data is already a map, proceed as usual
        final getallnoteresp = Getallnoterespo.fromJson(_result.data);
        notelistnotifier.value.clear();
        notelistnotifier.value.addAll(getallnoteresp.data.reversed);
        notelistnotifier.notifyListeners();
        return getallnoteresp.data;
      }
    }

    notelistnotifier.value.clear();
    return [];
  }



  @override
  Future<Notedata?> updatenote(Notedata value) async {
    // TODO: implement updatenote
    throw UnimplementedError();
  }

  Notedata? getnoteid(String id) {
    try {
      return notelistnotifier.value.firstWhere((note) => note.id == id);
    } catch (_) {
      return null;
    }
  }
}
