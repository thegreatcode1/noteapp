import 'package:json_annotation/json_annotation.dart';
import 'package:notes/data/notedata/notedata.dart';

part 'getallnoterespo.g.dart';

@JsonSerializable()
class Getallnoterespo {
  @JsonKey(name: 'data')
  List<Notedata> data;

  Getallnoterespo({this.data = const []});

  factory Getallnoterespo.fromJson(Map<String, dynamic> json) {
    return _$GetallnoterespoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetallnoterespoToJson(this);
}
