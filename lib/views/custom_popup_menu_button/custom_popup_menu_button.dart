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
  int _value;


  @override
  void initState() {
    super.initState();
    _customPopupMenuModel = [
      CustomPopupMenuModel(Icons.date_range, "Date Ascending", 1),
      CustomPopupMenuModel(Icons.date_range, "Date Descending", 2),
      CustomPopupMenuModel(Icons.sort, "Name Ascending", 3),
      CustomPopupMenuModel(Icons.sort, "Name Descending", 4)
    ];
    _value = 2;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context){
        return _customPopupMenuModel.map((e) {
          return PopupMenuItem(
              child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 5.00),
                      Icon(e.icon, color: Theme.of(context).primaryColor),
                      SizedBox(width: 10.00),
                      Text(e.text)
                    ]
                  )
              ),
            value: e.value,
          );
        }).toList();
      },
      initialValue: _value,
      elevation: 5.00,
      color: Colors.white,
      padding: EdgeInsets.all(10.00),
      onSelected: (value) async{
        if(value == 1) {
          BlocProvider.of<NotesBloc>(context).add(SortNotes(columnName: Notes.columnDateModified, order: Order.ascending));
          setState(() {
            _value = value;
          });
        } else if(value == 2 ) {
          BlocProvider.of<NotesBloc>(context).add(SortNotes(columnName: Notes.columnDateModified, order: Order.descending));
          setState(() {
            _value = value;
          });
        } else if(value == 3 ) {
          BlocProvider.of<NotesBloc>(context).add(SortNotes(columnName: Notes.columnTitle, order: Order.ascending));
          setState(() {
            _value = value;
          });
        } else if(value == 4 ) {
          BlocProvider.of<NotesBloc>(context).add(SortNotes(columnName: Notes.columnTitle, order: Order.descending));
          setState(() {
            _value = value;
          });
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
