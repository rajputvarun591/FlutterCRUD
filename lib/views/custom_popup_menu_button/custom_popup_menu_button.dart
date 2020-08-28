import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/blocs/notes/notes.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';
import 'package:notes/models/models.dart';

class CustomPopupMenuButton extends StatefulWidget {
  @override
  _CustomPopupMenuButtonState createState() => _CustomPopupMenuButtonState();
}

class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {

  List<CustomPopupMenuModel> _customPopupMenuModel;


  @override
  void initState() {
    super.initState();
    _customPopupMenuModel = [
      CustomPopupMenuModel(Icons.date_range, "Date Ascending", 1),
      CustomPopupMenuModel(Icons.date_range, "Date Descending", 2),
      CustomPopupMenuModel(Icons.sort, "Name Ascending", 3),
      CustomPopupMenuModel(Icons.sort, "Name Descending", 4)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context){
        return _customPopupMenuModel.map((e) {
          return PopupMenuItem(
              child: Container(
                  height:20.00,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10.00),
                      Icon(e.icon, color: Colors.blue),
                      SizedBox(width: 10.00),
                      Text(e.text)
                    ]
                  )
              ),
            value: e.value,
          );
        }).toList();
      },
      color: Colors.white,
      onSelected: (value) async{
        if(value == 1) {
          BlocProvider.of<NotesBloc>(context).add(SortNotes(columnName: Notes.columnDateModified, order: Order.ascending));
        } else if(value == 2 ) {
          BlocProvider.of<NotesBloc>(context).add(SortNotes(columnName: Notes.columnDateModified, order: Order.descending));
        } else if(value == 3 ) {
          BlocProvider.of<NotesBloc>(context).add(SortNotes(columnName: Notes.columnTitle, order: Order.ascending));
        } else if(value == 4 ) {
          BlocProvider.of<NotesBloc>(context).add(SortNotes(columnName: Notes.columnTitle, order: Order.descending));
        }
        //bloc.close();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    final bloc = BlocProvider.of<NotesBloc>(context);
    bloc.close();
  }
}
