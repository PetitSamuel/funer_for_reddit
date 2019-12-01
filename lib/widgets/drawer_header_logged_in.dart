import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funer_for_reddit/app_state_manager.dart';
import 'package:funer_for_reddit/models/user_models/user_information_model.dart';
import 'package:funer_for_reddit/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

// The card for a single section. Displays the section's gradient and background image.
class DrawerHeaderLoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserInformationModel user = Provider.of<UserProvider>(context).user;
    bool isLoadingUser = Provider.of<UserProvider>(context).loadingUser;
    if (isLoadingUser) {
      return ListTile(
        leading: CircularProgressIndicator(),
        title: Text("Loading profile."),
      );
    }
    if (user == null) {
      return ListTile(
        leading: Icon(Icons.refresh),
        title: Text("Error when loading user profile."),
        subtitle: Text("Click to try again"),
        onTap: () => loadUserProfile(context),
      );
    }
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
