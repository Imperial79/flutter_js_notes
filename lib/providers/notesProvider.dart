import 'package:flutter/cupertino.dart';
import 'package:flutter_js_notes/services/api_serice.dart';

import '../models/noteModel.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];
  bool isLoading = true;

  // its like initstate for provider
  NotesProvider() {
    fetchNotes();
  }

  List<Note> getFilteredNotes(String searchQuery) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            element.content!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  sortNotes() {
    notes.sort((a, b) => b.date!.compareTo(a.date!));
  }

  addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNotetoDB(note);
  }

  updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNotetoDB(note);
  }

  deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));

    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNoteDB(note);
  }

  fetchNotes() async {
    notes = await ApiService.fetchNotesDB('avi@mail');
    isLoading = false;
    sortNotes();
    notifyListeners();
  }
}
