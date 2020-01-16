import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/app_actions_manager.dart';
import 'package:funer_for_reddit/models/models_export.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

/*
  Header for the drawer when the user is logged in.
  Handles loading/no data/data statuses.
*/
class DrawerHeaderLoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserInformationModel user = Provider.of<UserProvider>(context).user;
    bool isLoadingUser = Provider.of<UserProvider>(context).loadingUser;

    // if loading user show progress icon.
    if (isLoadingUser) {
      return ListTile(
        leading: CircularProgressIndicator(),
        title: Text("Loading profile."),
      );
    }

    // if user is null then it was not load correctly. Show try again status.
    if (user == null) {
      return ListTile(
        leading: Icon(Icons.refresh),
        title: Text("Error when loading user profile."),
        subtitle: Text("Click to try again"),
        onTap: () => loadUserProfile(context),
      );
    }

    // success status : display widget with user name, icon & sign out action.
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: user.iconImg,
        imageBuilder: (context, imageProvider) => Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      title: Text(user.name),
      subtitle: Text("Click to sign out."),
      onTap: () => signout(context),
    );
  }
}
