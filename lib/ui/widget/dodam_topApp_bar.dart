import 'package:flutter/material.dart';

class DodamTopAppBar extends StatelessWidget {
  final String title;
  final String? description;

  const DodamTopAppBar({
    super.key,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.fromLTRB(16, statusBarHeight, 16, 12),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          if (description != null) ...[
            SizedBox(height: 4),
            Text(
              description!,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF5D5F60),
              ),
            ),
          ],
        ],
      ),
      color: Colors.white,
    );
  }
}
