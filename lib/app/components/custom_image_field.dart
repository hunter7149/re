import 'package:flutter/material.dart';

class CustomImageField extends StatelessWidget {
  const CustomImageField(
      {Key? key,
      this.label})
      : super(key: key);
  final String? label;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.rectangle),
      child: Card(
        child: Wrap(
          children: <Widget>[
            Image.network(label ?? '',
                height: 174,
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
    );
  }
}
