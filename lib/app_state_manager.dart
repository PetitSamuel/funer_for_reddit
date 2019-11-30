import 'package:flutter/cupertino.dart';
import 'package:funer_for_reddit/providers/auth_provider.dart';
import 'package:provider/provider.dart';

bool loggedIn(BuildContext context) {
  return Provider.of<AuthProvider>(context).signedIn;
}

login(BuildContext context) async {
  bool status = await Provider.of<AuthProvider>(context).authenticateUser(context);
  // todo : if success then load user info
  if(!status) return;

}

signout(BuildContext context) {
  Provider.of<AuthProvider>(context).signout();
}

bool isAuthLoading(BuildContext context) {
  return Provider.of<AuthProvider>(context).loading;
}