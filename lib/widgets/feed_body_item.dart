import 'package:flutter/material.dart';
import 'package:funer_for_reddit/models/post_models/post_model.dart';

Widget feedBodyItem(BuildContext context, PostModel current) {
  return Card(
    child: Text(current.title),
  );
}
