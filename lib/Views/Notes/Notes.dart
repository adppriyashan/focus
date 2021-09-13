import 'package:attrativenesstest/Controllers/NotesController.dart';
import 'package:attrativenesstest/Models/Colors.dart';
import 'package:attrativenesstest/Models/Strings.dart';
import 'package:attrativenesstest/Models/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Notes extends StatefulWidget {
  Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  double fieldspacesmid = 20.0;

  TextEditingController _messageController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            UtilStrings.notesTitle,
            style: GoogleFonts.roboto(color: UtilColors.whiteColor),
          ),
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          height: Utils.displaySize.height,
          width: Utils.displaySize.width,
          padding:
              EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _messageController,
                              decoration: Utils.getDefaultTextInputDecoration(
                                  'Please type your notes ',
                                  Icon(Icons.date_range,
                                      color: UtilColors.greyColor
                                          .withOpacity(0.6))),
                              cursorColor: UtilColors.primaryColor,
                              minLines: 5,
                              maxLines: 50,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.datetime,
                              style: Utils.getprimaryFieldTextStyle(
                                  UtilColors.blackColor),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Type Your Note Here';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              child: TextButton(
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      Utils.showLoader(context);
                                      NotesController()
                                          .saveNote(_messageController.text)
                                          .then((value) {
                                        Utils.hideLoaderCurrrent(context);
                                        _messageController.text = "";
                                        Utils.showToast('Note Saved');
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          UtilColors.secondaryColor,
                                      side: BorderSide(
                                          color: UtilColors.whiteColor,
                                          width: 1),
                                      primary: UtilColors.whiteColor),
                                  child: Text(
                                    "Save",
                                    style:
                                        TextStyle(color: UtilColors.whiteColor),
                                  )),
                              width: Utils.displaySize.width,
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              Expanded(
                  child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text('Previous Notes',
                          style: GoogleFonts.roboto(
                              color: UtilColors.primaryColor, fontSize: 15.0)),
                      SizedBox(
                        height: 30.0,
                      ),
                      Flexible(
                          child: FutureBuilder<List<dynamic>>(
                              future: NotesController().getNotes(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.data!.length > 0) {
                                    return ListView(
                                        children: snapshot.data!
                                            .map((note) => deleteFunction(note))
                                            .toList());
                                  } else {
                                    return Center(
                                      child: Text('No records Found.'),
                                    );
                                  }
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              })),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget deleteFunction(Map<dynamic, dynamic> note) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timeline,
              color: UtilColors.primaryColor,
            )
          ],
        ),
        title: Text(note['date'].toString()),
        subtitle: Text(note['message']),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: UtilColors.redColor,
          icon: Icons.delete,
          onTap: () {
            NotesController().deleteNote(note['id']).then((value) {
              setState(() {
                Utils.showToast('Note Deleted');
              });
            });
          },
        ),
      ],
    );
  }
}
