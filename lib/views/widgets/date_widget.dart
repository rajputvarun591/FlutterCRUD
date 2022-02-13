import 'package:flutter/material.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';

class DateWidget extends StatelessWidget {
  final int index;
  final List<Notes> notes;
  const DateWidget({Key key, @required this.index, @required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // First we find the date of the current placed item in the list
    DateTime ccDate = DateTime.parse(notes[index].dateModified);
    // Then we try to find out next item date in the list
    DateTime previousDate;

    if (!(index - 1).isNegative) {
      previousDate = DateTime.parse(notes[index - 1].dateModified);
    }

    if (previousDate != null && previousDate.day == ccDate.day) {
      return Padding(
        padding: const EdgeInsets.only(left: 100.0),
        child: Divider(
          height: 1,
          color: theme.dividerColor,
        ),
      );
    } else {
      return Center(
        child: Row(
          children: [
            Flexible(child: Divider()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ccDate.day == DateTime.now().day
                  ? Text(
                      "Today",
                      style: theme.textTheme.headline6.copyWith(fontSize: 14.00),
                    )
                  : Text(
                      MaterialLocalizations.of(context).formatShortDate(ccDate),
                      style: theme.textTheme.headline6.copyWith(fontSize: 14.00),
                    ),
            ),
            Flexible(child: Divider()),
          ],
        ),
      );
    }
  }
}
