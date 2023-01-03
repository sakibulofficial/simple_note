import 'package:flutter/material.dart';
import '../data/note_db.dart';
import '../models/notes.dart';
import '../values/app_colors.dart';
import '../values/app_style.dart';
import '../widgets/custom_appbar.dart';
import 'home_screen.dart';

typedef OnCompose = void Function(
  String title,
  String description,
  int backgroundColor,
);

class CreateUpdate extends StatefulWidget {
  final bool isUpdateScreen;
  final OnCompose? onCompose;
  final Note note;
  final NoteDB? store;
  const CreateUpdate({
    this.onCompose,
    required this.note,
    this.store,
    required this.isUpdateScreen,
    super.key,
  });

  @override
  State<CreateUpdate> createState() => _CreateUpdateState();
}

class _CreateUpdateState extends State<CreateUpdate> {
  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _descriptionController =
      TextEditingController();
  int selectedColor = 0;
  late bool isGrid;

  @override
  void initState() {
    if (widget.isUpdateScreen) {
      _titleController.text = widget.note.title;
      _descriptionController.text = widget.note.description;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onCreate() {
    final title = _titleController.text;
    final description = _descriptionController.text;

    if (title == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Title can't be empty....."),
        ),
      );
    } else {
      widget.onCompose!(
        title,
        description,
        AppColors.cardBackBackgroundColors[selectedColor],
      );
      _titleController.text = '';
      _descriptionController.text = '';
      Navigator.of(context).pop();
    }
  }

  void onUpdate(context) {
    if (_titleController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Title can't be empty....."),
        ),
      );
    } else {
      final editednote = Note(
        id: widget.note.id,
        title: _titleController.text,
        description: _descriptionController.text,
        backgroundColor: AppColors.cardBackBackgroundColors[selectedColor],
      );
      widget.store!.update(editednote);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        backgroundColor: Color(
          widget.isUpdateScreen == true
              ? widget.note.backgroundColor
              : AppColors.cardBackBackgroundColors[selectedColor],
        ).withOpacity(.30),
        isSearchBar: false,
        appBarTitle: const Text(
          '',
        ),
        actions: [
          IconButton(
            onPressed: () => widget.isUpdateScreen == true
                ? widget.store!.delete(widget.note).then(
                      (value) => Navigator.of(context).pop(),
                    )
                : Navigator.of(context).pop(),
            icon: const Icon(Icons.delete_outlined),
          ),
          IconButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Under Development"),
              ),
            ),
            icon: const Icon(Icons.push_pin_outlined),
          ),
          TextButton(
            onPressed: () {
              widget.isUpdateScreen == false ? onCreate() : onUpdate(context);
            },
            child: Text(
              widget.isUpdateScreen == false ? 'Done' : 'Update',
            ),
          )
        ],
      ),
      body: Container(
        color: Color(
          widget.isUpdateScreen == true
              ? widget.note.backgroundColor
              : AppColors.cardBackBackgroundColors[selectedColor],
        ).withOpacity(.30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      style: hintTitleTextStyle,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: hintTitleTextStyle,
                        border: InputBorder.none,
                      ),
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      style: hintBodyTextStyle,
                      keyboardType: TextInputType.multiline,
                      minLines: 100,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Note your things.....',
                        hintStyle: hintBodyTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(color: Colors.white),
              child: Container(
                color: Color(
                  widget.isUpdateScreen == true
                      ? widget.note.backgroundColor
                      : AppColors.cardBackBackgroundColors[selectedColor],
                ).withOpacity(0.10),
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: AppColors.cardBackBackgroundColors.length,
                  itemBuilder: ((context, index) => InkWell(
                        onTap: () {
                          setState(() {
                            selectedColor = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(13),
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: index == selectedColor
                                ? Color(AppColors
                                        .cardBackBackgroundColors[index])
                                    .withOpacity(0.70)
                                : Color(AppColors
                                        .cardBackBackgroundColors[index])
                                    .withOpacity(0.20),
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
