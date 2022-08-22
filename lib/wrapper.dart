import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/controllers/user_controller.dart';
import 'package:top_admin/views/log_in.dart';
import 'package:top_admin/views/page_selector.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserController>(context);

    return FutureBuilder<bool?>(
      future: userController.isAdmin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data != null && !snapshot.data!) {
          userController.signOut();
        }

        return (snapshot.data == null || !snapshot.data!) ? LogIn() : PageSelector();
      },
    );
  }
}
