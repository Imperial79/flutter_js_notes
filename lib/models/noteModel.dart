class Note {
  String? id;
  String? uid;
  String? title;
  String? content;
  DateTime? date;

  Note({this.id, this.uid, this.title, this.content, this.date});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      uid: map['uid'],
      title: map['title'],
      content: map['content'],
      date: DateTime.tryParse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'title': title,
      'content': content,
      'date': date!.toIso8601String(),
    };
  }
}
