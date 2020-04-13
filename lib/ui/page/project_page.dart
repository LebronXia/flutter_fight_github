import 'package:flutter/material.dart';


class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => new _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('项目'),
      ),
    );
  }
}