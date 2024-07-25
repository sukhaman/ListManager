import 'package:flutter/material.dart';
import 'package:notesmanager/services/auth/auth_exceptions.dart';
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
    try {
      final existingNote = _note;
      if (existingNote != null) {
        return existingNote;
      }

      final currentUser = AuthService.firebase().currentUser;
      if (currentUser == null) {
        throw UserNotFoundAuthException();
      }

      final email = currentUser.email;
      print('Creating note for user with email: $email');
      final owner = await _notesService.getUser(email: email);
      print('User found: $owner');

      final newNote = await _notesService.createNote(owner: owner);
      print('Note created: $newNote');
      return newNote;
    } catch (e, stackTrace) {
      print('Error in creating new note: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  void initState() {
    _notesService = NotesService();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
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

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      _notesService.deleteNote(id: note.id);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    final text = _textController.text;
    if (note != null && text.isNotEmpty) {
      await _notesService.updateNote(
        note: note,
        text: text,
      );
    }
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextNotEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: FutureBuilder<DatabaseNote>(
        future: createNewNote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              _note = snapshot.data;
              _setupTextControllerListener();
              return TextField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration:
                    const InputDecoration(hintText: 'Start typing your note'),
              );
            } else {
              return const Text('Error creating note');
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
