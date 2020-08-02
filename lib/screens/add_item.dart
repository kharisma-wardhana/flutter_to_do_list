import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Title",
                    style: TextStyle(
                        color: Color(0xFF4E4187),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.5),
                  ),
                  TextField()
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Color(0xFF4E4187),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.5),
                  ),
                  TextField()
                ]),
            Row(children: <Widget>[
              Expanded(
                child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFF55D3E))),
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2000, 1, 1),
                          maxTime: DateTime(2022, 12, 31), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Text(
                      'Set Date Time',
                      style: TextStyle(color: Color(0xFFF55D3E)),
                    )),
              ),
            ]),
            Center(
                child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Color(0xFFF55D3E),
              child: Text(
                "Add",
                style: TextStyle(color: Color(0xFFFFFFFF)),
              ),
              onPressed: () {},
            )),
          ],
        ),
      ),
    );
  }
}
