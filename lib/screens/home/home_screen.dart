import 'package:flutter/material.dart';
import 'package:passwd/services/authentication/authentication_service.dart';
import 'package:passwd/services/locator.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
