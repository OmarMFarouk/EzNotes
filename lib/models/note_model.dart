class NoteModel {
  String? noteTitle;
  String? noteBody;
  String? noteStatus;
  int? noteId;
  DateTime? dateCreated;
  DateTime? dateModified;
  int? fontSize;
  NoteModel(
      {this.dateCreated,
      this.dateModified,
      this.fontSize,
      this.noteBody,
      this.noteId,
      this.noteStatus,
      this.noteTitle});

  Map<String, dynamic> toJson() => {
        'note_title': noteTitle,
        'note_body': noteBody,
        'note_fontSize': fontSize,
        'note_dateCreated': dateCreated,
        'note_status': noteStatus,
        'note_dateModified': dateModified
      };
  NoteModel.fromJson(Map<String, dynamic> data) {
    noteId = data['note_id'];
    noteTitle = data['note_title'];
    noteBody = data['note_body'];
    noteStatus = data['note_status'];
    fontSize = data['note_fontSize'];
    dateCreated = DateTime.parse(data['note_dateCreated']);
    dateModified = DateTime.parse(data['note_dateModified']);
  }
  dateFormatter(DateTime date) {
    DateTime currentDate = DateTime.now();
    if (date.day == currentDate.day) {
      return '${date.hour}:${date.minute} ${date.hour >= 12 ? 'PM' : 'AM'}';
    } else if (date.year == currentDate.year) {
      return '${date.day}/${date.month}';
    } else {
      return date.toString().split(' ').first;
    }
  }
}
