import 'package:flutter/material.dart';
import 'package:notes/data/data.dart';
import 'package:notes/data/notedata/notedata.dart';
import 'package:notes/main.dart';

enum Actiontype {
  addnote,
  editnote;
}

// ignore: must_be_immutable
class Itemadd extends StatelessWidget {
  final Actiontype type;
  String? id;
  Itemadd({
    Key? key,
    required this.type,
    this.id,
  }) : super(key: key);

  Widget get savebutton => TextButton.icon(
      onPressed: () {
        switch (type) {
          case Actiontype.addnote:
            savenote();
            //add note
            break;
          case Actiontype.editnote:
            //updete note
            break;
          default:
        }
      },
      icon: const Icon(Icons.save),
      label: const Text("save"));

  final _titlecontroller = TextEditingController();
  final _contentcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2999AD),
      appBar: AppBar(
        title: Text(type.name.toUpperCase()),
        actions: [
          savebutton,
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titlecontroller,
                decoration: const InputDecoration(
                  hintText: "title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(20, 20),
                    ),
                  ),
                  fillColor: Colors.black38,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _contentcontroller,
                maxLines: 10,
                maxLength: 100,
                decoration: const InputDecoration(
                  hintText: "content",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(30, 30),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return const MyHomePage(title: "");
                      },
                    ),
                  );
                },
                child: const Text("back"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> savenote() async {
    final title = _titlecontroller.text;
    final content = _contentcontroller.text;

    final newnote = Notedata.create(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      content: content,
    );
    Notedb().createnote(newnote);
  }
}
