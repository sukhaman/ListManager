import 'package:flutter/material.dart';
import 'package:notesmanager/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEMptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You cannot share an empty note!',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
