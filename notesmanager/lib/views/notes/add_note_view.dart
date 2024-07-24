import 'package:flutter/material.dart';
import 'package:notesmanager/services/auth/auth_service.dart';
import 'package:notesmanager/services/crud/notes_service.dart';
import 'package:sqflite/sqflite.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({super.key});

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  DatabaseNote? _note;
  late final NotesService _notesService;
  late final TextEditingController _textController;

  Future<DatabaseNote> createNewNote() async {
    final exisitingNote = _note;
    if (exisitingNote != null) {
      return exisitingNote;
    }

    final currentUser = AuthService.firebase().currentUser!;
    final email = currentUser.email;
    final owner = await _notesService.getUser(email: email);
    return await _notesService.createNote(owner: owner);
  }

  void _saveNote() async {
    final note = _note;
    final text = _textController.text;
    if (note != null && text.isNotEmpty) {
      await _notesService.updateNote(
        note: note,
        text: text,
      );
    }
  }

  @override
  void initState() {
    _notesService = NotesService();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListner() async {
    final note = _note;
    if (note == null) {
      return;
    }

    final text = _textController.text;
    await _notesService.updateNote(
      note: note,
      text: text,
    );
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListner);
    _textController.addListener(_textControllerListner);
  }

  @override
  void dispose() {
    _saveNote();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: FutureBuilder(
        future: createNewNote(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              //_note = snapshot.data as DatabaseNote;
              // _setupTextControllerListener();
              return TextField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLength: null,
                decoration: InputDecoration(hintText: 'Start typing your note'),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
