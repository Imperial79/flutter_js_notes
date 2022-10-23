// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_js_notes/providers/notesProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/noteModel.dart';

class NewNoteUI extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const NewNoteUI({super.key, required this.isUpdate, required this.note});

  @override
  State<NewNoteUI> createState() => _NewNoteUIState();
}

class _NewNoteUIState extends State<NewNoteUI> {
  final title = TextEditingController();
  final content = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      title.text = widget.note!.title!;
      content.text = widget.note!.content!;
    }
  }

  void updateNote() {
    Note updatedNote = Note(
      id: widget.note!.id!,
      uid: 'avi@mail',
      title: title.text,
      content: content.text,
      date: DateTime.now(),
    );
    Provider.of<NotesProvider>(context, listen: false).updateNote(updatedNote);
    Navigator.pop(context);
  }

  void newNote() {
    if (title.text.isNotEmpty || content.text.isNotEmpty) {
      Note newNote = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        uid: 'avi@mail',
        title: title.text,
        content: content.text,
        date: DateTime.now(),
      );

      Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  DateFormat('yMMMd').format(DateTime.now()),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              TextField(
                controller: title,
                maxLines: 2,
                minLines: 1,
                autofocus: widget.isUpdate ? false : true,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: TextField(
                    controller: content,
                    maxLines: 30,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                      hintText: 'Content',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.isUpdate) {
            updateNote();
          } else {
            newNote();
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
