import 'package:flutter/material.dart';
import 'package:passwd/services/authentication/authentication_service.dart';
import 'package:passwd/services/locator.dart';
import 'package:passwd/widgets/title.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings_outlined),
          onPressed: () {},
          tooltip: "Settings",
        ),
        centerTitle: true,
        title: TitleWidget(
          textSize: 20,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
            tooltip: "Add an entry",
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: locator<AuthenticationService>().readEncryptionKey(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data);
            }

            return Text("Hmmmm");
          },
        ),
      ),
    );
  }
}
