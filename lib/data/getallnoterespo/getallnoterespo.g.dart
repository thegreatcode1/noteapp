// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getallnoterespo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getallnoterespo _$GetallnoterespoFromJson(Map<String, dynamic> json) =>
    Getallnoterespo(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Notedata.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GetallnoterespoToJson(Getallnoterespo instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
