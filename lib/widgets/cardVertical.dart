import 'package:flutter/material.dart';
import 'package:podcast_app/theme/theme.dart';
import 'badge.dart';

class CardVertical extends StatelessWidget {
  const CardVertical({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity - 100,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 7,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://images.unsplash.com/photo-1625909244134-2e2412edd4cd?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                  width: 83,
                  height: 83,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 83,
                height: 83,
                child: Center(
                  child: Icon(Icons.play_circle_filled,
                      color: primaryColor.withOpacity(
                        0.6,
                      ),
                      size: 34),
                ),
              )
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Mengatur waktu belajar agar lebih produktir',
                  style: boldText.copyWith(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Badge(),
                    Text(
                      '12 Des 2021 - 46 menit',
                      style: regularText.copyWith(
                        fontSize: 12,
                        color: Color(0xffA0A9B5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
