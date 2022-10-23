import 'dart:convert';
import 'dart:developer';

import '../models/noteModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String _baseUrl = "https://shrouded-tundra-36957.herokuapp.com/notes";

  static Future<void> addNotetoDB(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + '/add');
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded);
    log(decoded.toString());
  }

  static Future<void> deleteNoteDB(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + '/delete');
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    print(decoded);
    log(decoded.toString());
  }

  static Future<List<Note>> fetchNotesDB(String uid) async {
    Uri requestUri = Uri.parse(_baseUrl + '/list');
    var response = await http.post(requestUri, body: {"uid": uid});
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
    List<Note> notes = [];
    for (var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  }
}
