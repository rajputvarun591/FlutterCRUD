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

  NotesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _customPopupMenuModel = [
      CustomPopupMenuModel(Icons.date_range, "Date Ascending", 1),
      CustomPopupMenuModel(Icons.date_range, "Date Descending", 2),
      CustomPopupMenuModel(Icons.sort, "Name Ascending", 3),
      CustomPopupMenuModel(Icons.sort, "Name Descending", 4),
      CustomPopupMenuModel(Icons.favorite, "Favorite First", 5),
      CustomPopupMenuModel(Icons.favorite_border, "UnFavorite", 6)
    ];
    _value = 2;
    _bloc = BlocProvider.of<NotesBloc>(context);
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
      padding: EdgeInsets.all(10.00),
      onSelected: (value) async{
        if(value == 1) {
          _bloc.add(ShowNotes(sortBy: Notes.columnDateModified, orderBy: Order.ascending));
          setState(() {
            _value = value;
          });
        } else if(value == 2 ) {
          _bloc.add(ShowNotes(sortBy: Notes.columnDateModified, orderBy: Order.descending));
          setState(() {
            _value = value;
          });
        } else if(value == 3 ) {
          _bloc.add(ShowNotes(sortBy: Notes.columnTitle, orderBy: Order.ascending));
          setState(() {
            _value = value;
          });
        } else if(value == 4 ) {
          _bloc.add(ShowNotes(sortBy: Notes.columnTitle, orderBy: Order.descending));
          setState(() {
            _value = value;
          });
        } else if(value == 5 ) {
          _bloc.add(ShowNotes(sortBy: Notes.columnFavorite, orderBy: Order.descending));
          setState(() {
            _value = value;
          });
        } else if(value == 6 ) {
          _bloc.add(ShowNotes(sortBy: Notes.columnFavorite, orderBy: Order.ascending));
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
    _bloc.close();
  }
}
