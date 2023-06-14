import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: const Center(
        child: SpinKitChasingDots(
          size: 50.0,
          color: Colors.brown,
        ),
      ),
    );
  }
}
