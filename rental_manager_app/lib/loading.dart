import 'package:flutter/material.dart';

class Loading extends StatelessWidget {

  Widget _loadingGif() {
    return Icon(Icons.cloud_circle_sharp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rental Manager'),
      ),
      body: Text("Loading")
    );
  }
}