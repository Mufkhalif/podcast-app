import 'package:flutter/material.dart';
import 'package:podcast_app/theme/theme.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Color(0xffECFBFF),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Text(
        'Productivity',
        style: regularText.copyWith(
          fontSize: 12,
          color: Color(0xFF72DDFF),
        ),
      ),
    );
  }
}
