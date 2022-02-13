import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/database_tables_models/database_tables_models.dart';
import 'package:notes/models/models.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as PdfWidget;
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as AppDirectory;

class SavePdfGeneralDialog extends StatefulWidget {
  final Notes note;

  SavePdfGeneralDialog({@required this.note});

  @override
  _SavePdfGeneralDialogState createState() => _SavePdfGeneralDialogState();
}

class _SavePdfGeneralDialogState extends State<SavePdfGeneralDialog> {
  List<PdfPageFormatModel> pdfPageFormat;
  List<PdfPageOrientation> pdfPageOrientation;
  TextEditingController textEditingController;
  PdfWidget.PageOrientation orientation;
  PdfPageFormat format;

  @override
  void initState() {
    super.initState();
    pdfPageFormat = [
      PdfPageFormatModel("A4", PdfPageFormat.a4),
      PdfPageFormatModel("A3", PdfPageFormat.a3),
      PdfPageFormatModel("A5", PdfPageFormat.a5),
      PdfPageFormatModel("LEGAL", PdfPageFormat.legal),
      PdfPageFormatModel("LETTER", PdfPageFormat.letter)
    ];

    pdfPageOrientation = [
      PdfPageOrientation("LANDSCAPE", PdfWidget.PageOrientation.landscape),
      PdfPageOrientation("PORTRAIT", PdfWidget.PageOrientation.portrait),
    ];
    textEditingController = TextEditingController(text: widget.note.title.replaceAll(" ", "_"));
    orientation = PdfWidget.PageOrientation.portrait;
    format = PdfPageFormat.a4;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: mediaQuery.viewInsets + EdgeInsets.symmetric(vertical: 110.00, horizontal: 30.00),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.00))),
          child: Material(
            borderRadius: BorderRadius.all(
              Radius.circular(5.00),
            ),
            color: theme.backgroundColor,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.00, horizontal: 15.00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.00),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(child: Text("Save PDF", style: theme.textTheme.headline6)),
                      Container(
                        child: CloseButton(
                            color: Colors.grey,
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      )
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 10.00),
                  Container(
                      padding: EdgeInsets.only(bottom: 5.00),
                      child: Text("Enter File Name", style: theme.textTheme.headline6.copyWith(fontSize: 18.00))),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.00)),
                          boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 1.00, blurRadius: 1.00, offset: Offset(0.0, 0.1))]),
                      child: TextField(
                        controller: textEditingController,
                        textAlign: TextAlign.left,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.00)), borderSide: BorderSide(color: Colors.transparent)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.00)), borderSide: BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.00)), borderSide: BorderSide(color: Colors.transparent)),
                          contentPadding: EdgeInsets.all(5.00),
                          fillColor: theme.backgroundColor.withOpacity(0.8),
                          filled: true,
                        ),
                      )),
                  SizedBox(height: 10.00),
                  Container(
                      padding: EdgeInsets.only(bottom: 5.00),
                      child: Text("Paper Size", style: theme.textTheme.headline6.copyWith(fontSize: 18.00))),
                  Container(
                      height: 40.00,
                      padding: EdgeInsets.only(left: 5.00, right: 5.00),
                      decoration: BoxDecoration(
                          color: theme.backgroundColor.withOpacity(0.8),
                          borderRadius: BorderRadius.all(Radius.circular(5.00)),
                          boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 1.00, blurRadius: 1.00, offset: Offset(0.0, 0.1))]),
                      child: DropdownButton(
                          underline: Container(),
                          isExpanded: true,
                          value: format,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: pdfPageFormat
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      e.name,
                                      style: theme.textTheme.headline6.copyWith(fontSize: 16.00),
                                    ),
                                    value: e.format,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              format = value;
                            });
                          })),
                  SizedBox(height: 10.00),
                  Container(
                      padding: EdgeInsets.only(bottom: 5.00),
                      child: Text("Paper Orientation", style: theme.textTheme.headline6.copyWith(fontSize: 18.00))),
                  Container(
                      height: 40.00,
                      padding: EdgeInsets.only(left: 5.00, right: 5.00),
                      decoration: BoxDecoration(
                          color: theme.backgroundColor.withOpacity(0.8),
                          borderRadius: BorderRadius.all(Radius.circular(5.00)),
                          boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 1.00, blurRadius: 1.00, offset: Offset(0.0, 0.1))]),
                      child: DropdownButton(
                          underline: Container(),
                          isExpanded: true,
                          icon: Icon(Icons.keyboard_arrow_down),
                          value: orientation,
                          items: pdfPageOrientation
                              .map((e) => DropdownMenuItem(
                                    child: Text(e.name),
                                    value: e.orientation,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              orientation = value;
                            });
                          })),
                  SizedBox(height: 20.00),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(onPressed: () {}, icon: Icon(Icons.insert_drive_file), label: Text("Preview")),
                      SizedBox(width: 20.00),
                      TextButton.icon(
                          onPressed: () async {
                            await Permission.storage.request().then((value) async {
                              if (value.isGranted) {
                                Navigator.pop(
                                    context,
                                    await saveFileAsPDF(textEditingController.text.isEmpty ? "No_Name" : textEditingController.text,
                                        widget.note, format, orientation));
                              } else if (value.isDenied) {
                                Navigator.of(context).pop();
                              } else if (value.isPermanentlyDenied) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Permission", style: TextStyle(color: Colors.red)),
                                        content: Text("Please goto settings and give storage permission manually to save the files."),
                                      );
                                    });
                              }
                            });
                          },
                          icon: Icon(Icons.file_download),
                          label: Text("Save"))
                    ],
                  ),
                  SizedBox(height: 10.00)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FutureOr<File> saveFileAsPDF(String fileName, Notes note, PdfPageFormat pageFormat, PdfWidget.PageOrientation pageOrientation) async {
    PdfWidget.Font font = PdfWidget.Font.ttf(await rootBundle.load("fonts/Raleway-Medium.ttf"));
    File savedFile;
    try {
      Directory directory = await AppDirectory.getExternalStorageDirectory();
      String path = directory.path;
      final pdf = PdfWidget.Document();
      pdf.addPage(PdfWidget.Page(
          pageFormat: pageFormat,
          margin: PdfWidget.EdgeInsets.all(15.00),
          orientation: pageOrientation,
          theme: PdfWidget.ThemeData.withFont(
            base: PdfWidget.Font.ttf(await rootBundle.load("fonts/Raleway-Medium.ttf")),
            bold: PdfWidget.Font.ttf(await rootBundle.load("fonts/Raleway-Medium.ttf")),
            italic: PdfWidget.Font.ttf(await rootBundle.load("fonts/Raleway-Medium.ttf")),
            boldItalic: PdfWidget.Font.ttf(await rootBundle.load("fonts/Raleway-Medium.ttf")),
          ),
          build: (PdfWidget.Context context) {
            return PdfWidget.Column(
                mainAxisAlignment: PdfWidget.MainAxisAlignment.start,
                crossAxisAlignment: PdfWidget.CrossAxisAlignment.start,
                children: [
                  PdfWidget.Container(
                      padding: PdfWidget.EdgeInsets.all(10.00),
                      child: PdfWidget.Text('${note.title}',
                          style: PdfWidget.TextStyle(fontSize: 25.00, fontWeight: PdfWidget.FontWeight.normal, font: font))),
                  PdfWidget.Container(
                      alignment: PdfWidget.Alignment.centerLeft,
                      padding: PdfWidget.EdgeInsets.all(20.00),
                      child: PdfWidget.Text('${note.content}',
                          style: PdfWidget.TextStyle(fontSize: 18.00, fontWeight: PdfWidget.FontWeight.normal, font: font))),
                  PdfWidget.Expanded(child: PdfWidget.Container()),
                  PdfWidget.Divider(),
                  PdfWidget.Footer(
                      padding: PdfWidget.EdgeInsets.all(10.00),
                      trailing: PdfWidget.Text('${note.dateModified}',
                          style: PdfWidget.TextStyle(
                              fontSize: 15.00, color: PdfColor.fromHex("808080"), fontWeight: PdfWidget.FontWeight.normal, font: font))),
                ]);
          }));
      bool exist = await Directory('${path.split("Android")[0]}MyNotes/').exists();
      if (exist) {
        File pdfFile = File("${path.split("Android")[0]}MyNotes/$fileName.pdf");
        savedFile = await pdfFile.writeAsBytes(pdf.save());
        return (savedFile);
      } else {
        File pdfFile = File("${path.split("Android")[0]}MyNotes/$fileName.pdf");
        savedFile = await pdfFile.writeAsBytes(pdf.save()).catchError((onError) {
          Directory("${path.split("Android")[0]}MyNotes").create(recursive: true);
          pdfFile.writeAsBytes(pdf.save());
          return (savedFile);
        });
      }
    } on Exception catch (e, stackTrace) {
      log("Error", error: e, stackTrace: stackTrace);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Action Can not be Done.")));
    }
  }
}
