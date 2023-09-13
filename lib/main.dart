import 'package:flutter/material.dart';
import 'package:notes/data/data.dart';
import 'package:notes/data/notedata/notedata.dart';
import 'package:notes/itemadd.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Notedata> notelist = [];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final _notes = await Notedb().getallnote();
        notelist.clear();
        setState(() {
          notelist.addAll(_notes.reversed);
        });
        //print(_notes);
      },
    );
    return Scaffold(
      backgroundColor: const Color(0xff2999AD), //#38ADAE
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(notelist.length, (index) {
                final note = notelist[index];
                if (note.id == null) {
                  const SizedBox();
                }
                return NoteItem(
                  id: note.id,
                  title: note.title ?? 'ni title',
                  content: note.content ?? 'no content',
                );
              })),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) {
                return Itemadd(type: Actiontype.addnote);
              },
            ),
          );
        },
        label: const Text(
          "ADD NOTE",
          style: TextStyle(color: Colors.white70),
        ),
        elevation: 100,
        backgroundColor: Colors.black45,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}

class NoteItem extends StatelessWidget {
  final String? id;
  final String? title;
  final String? content;

  const NoteItem({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) {
                return Itemadd(type: Actiontype.editnote);
              },
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Text(
                content ?? "",
                maxLines: 10,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
