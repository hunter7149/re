import 'package:flutter/material.dart';

class CustomImageVal extends StatelessWidget {
  const CustomImageVal(
      {Key? key,
      this.label})
      : super(key: key);
  final String? label;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child:Column(
        children: [
          Container(
      width: 400,
      decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.rectangle),

      child: Card(
        child: Wrap(
          children: <Widget>[
            Image.asset(label ?? '',
                height: 700,
                width:400,
                fit:BoxFit.fill),
            // ListTile(
            //   title: Text(text ?? ''),
            //   subtitle: Text("Sub Image"),
            // )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(4),
        ),
      ),
    )
  ]));
  }
}
