import 'package:flutter/material.dart';
import '../view_model/authentication_view_model.dart';

class AuthenticationSelectionPage extends StatelessWidget {
  final AuthenticationViewModel _viewModel = AuthenticationViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registration');
              },
              child: Text('Registration'),
            ),
          ],
        ),
      ),
    );
  }
}
