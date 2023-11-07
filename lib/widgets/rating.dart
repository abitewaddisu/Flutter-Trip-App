import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final int total;
  final int rating;
  const Rating({super.key, required this.total, required this.rating});

  List<Widget> stars() {
    final List<Widget> s = [];
    for (var i=0; i<5; i++) {
      s.add(i+1 <= rating ? Star(filled: true) : Star());
    }
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...stars(),
        SizedBox(width: 20),
        Text('$rating.0', style: TextStyle(color: Colors.white, fontSize: 20)),
        Text('($total)', style: TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );
  }
}

class Star extends StatelessWidget {
  final bool filled;
  const Star({super.key, this.filled=false});

  @override
  Widget build(BuildContext context) {
    return Icon(filled ? Icons.star : Icons.star_border, color: Colors.yellowAccent,);
  }
}