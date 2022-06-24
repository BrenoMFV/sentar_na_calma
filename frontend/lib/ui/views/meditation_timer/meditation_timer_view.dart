import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:provider/provider.dart';

class MeditationTimerView extends StatelessWidget {
  const MeditationTimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Center(child: Container(child: Text("Olá ${user.username}")));
  }
}
