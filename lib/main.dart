import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './screens/front/frontPage.dart';

void main() {
//  Future main() async {
//    await DotEnv().load('.env');
//  }

  runApp(
      MaterialApp(
        title: 'Navigation Basics',
        home: FrontPage(),
    )
  );
}
