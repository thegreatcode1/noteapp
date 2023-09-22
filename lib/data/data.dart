import 'dart:convert';

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
      // ignore: no_leading_underscores_for_local_identifiers
      final _result = await dio.post(
        url.createnote,
        data: value.toJson(),
      );
      // ignore: no_leading_underscores_for_local_identifiers
      final _resultAsfronjson = jsonDecode(_result.data);
      // ignore: avoid_print
      print(_resultAsfronjson);
      return Notedata.fromJson(_resultAsfronjson as Map<String, dynamic>);
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.response?.data);
      // ignore: avoid_print
      print(e);
      return null;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  @override
  Future<void> deletenote(String id) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _result = await dio.delete(url.deletenote.replaceFirst('{id}', id));
    if (_result.data == null) {
      return;
    }
    // ignore: no_leading_underscores_for_local_identifiers
    final _index = notelistnotifier.value.indexWhere((note) => note.id == id);
    if (_index == -1) {
      return;
    }
    notelistnotifier.value.removeAt(_index);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    notelistnotifier.notifyListeners();
  }

  @override
  Future<List<Notedata>> getallnote() async {
    final completeUrl = '${url.baseurl}${url.getnote}';
    // ignore: no_leading_underscores_for_local_identifiers
    final _result = await dio.get(completeUrl);

    if (_result.data != null) {
      if (_result.data is String) {
        // If data is a string, parse it as JSON
        final getallnoteresp =
            Getallnoterespo.fromJson(jsonDecode(_result.data));
        notelistnotifier.value.clear();
        notelistnotifier.value.addAll(getallnoteresp.data.reversed);
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        notelistnotifier.notifyListeners();
        return getallnoteresp.data;
      } else if (_result.data is Map<String, dynamic>) {
        // If data is already a map, proceed as usual
        final getallnoteresp = Getallnoterespo.fromJson(_result.data);
        notelistnotifier.value.clear();
        notelistnotifier.value.addAll(getallnoteresp.data.reversed);
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        notelistnotifier.notifyListeners();
        return getallnoteresp.data;
      }
    }

    notelistnotifier.value.clear();
    return [];
  }

  @override
  Future<Notedata?> updatenote(Notedata value) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _result = await dio.put(url.updatenote, data: value.toJson());
    // ignore: unnecessary_null_comparison
    if (_result == null) {
      return null;
    }
    //find index
    final index =
        notelistnotifier.value.indexWhere((note) => note.id == value.id);
    if (index == -1) {
      return null;
    }
    //remove from index
    notelistnotifier.value.removeAt(index);
    //add note in that index
    notelistnotifier.value.insert(index, value);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    notelistnotifier.notifyListeners();
    return value;
  }

  Notedata? getnoteid(String id) {
    try {
      return notelistnotifier.value.firstWhere((note) => note.id == id);
    } catch (_) {
      return null;
    }
  }
}
