// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:simple_note/screens/search_screen.dart';
import '../data/note_db.dart';
import '../models/notes.dart';
import '../values/app_colors.dart';
import '../values/app_style.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/grid_notes.dart';
import '../widgets/list_notes.dart';
import 'create_update.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final bool? isGrid;
  const HomePage({
    this.isGrid,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isGrid;
  late final NoteDB _store;
  late String search = '';
  bool isSelectedSearchBar = false;

  List<Note> notes = [];

  Widget searchResult(String search) {
    if (search == '') {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () => debugPrint('taped'),
          title: Text(search),
        ),
      );
    }
  }

  @override
  void initState() {
    isGrid = widget.isGrid!;
    _store = NoteDB(dbName: 'db.sqlite');
    _store.open();
    super.initState();
  }

  @override
  void dispose() {
    _store.close();
    super.dispose();
  }

  Future<void> _createSelectedTile(bool boolValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getBool('isTure');
    if (value == null) {
      // isGrid = true;
      await prefs.setBool('isTure', true);
    } else {
      await prefs.setBool('isTure', boolValue);
      isGrid = prefs.getBool('isTure')!;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        isSearchBar: true,
        leading: const Icon(Icons.search),
        appBarTitle: TextField(
          onChanged: (value) {
            setState(() {
              search = value;
            });
          },
          onTap: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => SearchScreen(
                        noteDB: _store,
                      )),
                ),
              );
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search notes',
          ),
        ),
        isBackButtonEnabled: false,
        actions: [
          changeTile(),
        ],
      ),
      body: SafeArea(
        child: isSelectedSearchBar == true
            ? searchResult(search)
            : Container(
                margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
                height: height,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Notes',
                      style: higlitTextStyle,
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    StreamBuilder(
                      stream: _store.all(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            if (snapshot.data == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            notes = snapshot.data!;

                            if (notes.isEmpty) {
                              return emptyNote();
                            } else {
                              return isGrid == true
                                  ? GridNotes(
                                      notes: notes,
                                      store: _store,
                                    )
                                  : ListNotes(
                                      notes: notes,
                                      store: _store,
                                    );
                            }
                          default:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                        }
                      },
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: floatingActionButton(context),
    );
  }

  Padding changeTile() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(
        icon: Icon(
            isGrid == false ? Icons.grid_view : Icons.view_agenda_outlined),
        onPressed: () {
          setState(() {
            _createSelectedTile(!isGrid);
            isGrid = !isGrid;
          });
        },
      ),
    );
  }

  Widget floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateUpdate(
                isUpdateScreen: false,
                note: Note(
                  backgroundColor: 1,
                  description: '',
                  id: 2,
                  title: '',
                ),
                onCompose: (title, description, backgroundColor) async {
                  await _store.create(title, description, backgroundColor);
                },
              ),
            ));
      },
      child: const Icon(Icons.add),
    );
  }

  Expanded emptyNote() {
    return Expanded(
      child: Center(
        child: Text(
          'Please create some notes.',
          textAlign: TextAlign.center,
          style: backgroundTextStyle,
        ),
      ),
    );
  }
}
