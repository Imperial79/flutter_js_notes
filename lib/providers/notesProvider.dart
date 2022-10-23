import 'package:flutter/cupertino.dart';

import '../models/noteModel.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];

  addNote(Note note) {
    notes.add(note);
    notifyListeners();
  }

  updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;

    notifyListeners();
  }

  deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));

    notes.removeAt(indexOfNote);
    notifyListeners();
  }
}
