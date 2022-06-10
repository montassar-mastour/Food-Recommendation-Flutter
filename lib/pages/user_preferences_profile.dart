// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:openfoodfacts/model/Attribute.dart';
import 'package:openfoodfacts/model/AttributeGroup.dart';
import 'package:provider/provider.dart';
import 'package:smooth_app/Data_Base_Api/d_b_configuration.dart';
import 'package:smooth_app/data_models/product_preferences.dart';
import 'package:smooth_app/data_models/user_preferences.dart';
import 'package:smooth_app/generic_lib/buttons/smooth_action_button.dart';
import 'package:smooth_app/generic_lib/dialogs/smooth_alert_dialog.dart';
import 'package:smooth_app/helpers/user_management_helper.dart';
import 'package:smooth_app/pages/abstract_user_preferences.dart';
import 'package:smooth_app/pages/profil_pages/profil.dart';
import 'package:smooth_app/pages/user_management/login_page.dart';

/// Collapsed/expanded display of profile for the preferences page.
class UserPreferencesProfile extends AbstractUserPreferences {
  UserPreferencesProfile({
    required this.productPreferences,
    required final Function(Function()) setState,
    required final BuildContext context,
    required final UserPreferences userPreferences,
    required final AppLocalizations appLocalizations,
    required final ThemeData themeData,
  }) : super(
          setState: setState,
          context: context,
          userPreferences: userPreferences,
          appLocalizations: appLocalizations,
          themeData: themeData,
        );
        final ProductPreferences productPreferences;

  @override
  bool isCollapsedByDefault() => true;

  @override
  String getPreferenceFlagKey() => 'profile';

  @override
  Widget getTitle() => Text(
        appLocalizations.myPreferences_profile_title,
        style: themeData.textTheme.headline2,
      );

  @override
  Widget? getSubtitle() =>
      Text(appLocalizations.myPreferences_profile_subtitle);

  @override
  List<Widget> getBody() {
    
    final ThemeData theme = Theme.of(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;

    final List<Widget> result = <Widget>[];
        
    //Credentials exist
      result.add(
        FutureBuilder<bool>(  
                 future:UserManagementHelper.credentialsInStorage(),
        builder:(context,snapshot){
       // ignore: always_put_control_body_on_new_line, avoid_print
       if(snapshot.hasError) print(snapshot.error);
        if( snapshot.hasData) 
        {
          if(DataBaseConfiguration.user != null){
          return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () =>   Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) =>
                              const ProfilPage(),
                        ),
                      ),
              label: Text(
                appLocalizations.view_profile,
                style: theme.textTheme.bodyText2?.copyWith(
                  fontSize: 18.0,
                  color: theme.colorScheme.surface,
                ),
              ),
              icon: const Icon(Icons.open_in_new),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(size.width * 0.33, theme.buttonTheme.height + 10),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(300.0),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _confirmLogout(context),
              child: Text(
                appLocalizations.sign_out,
                style: theme.textTheme.bodyText2?.copyWith(
                  fontSize: 18.0,
                  color: theme.colorScheme.surface,
                ),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(size.width * 0.33, theme.buttonTheme.height + 10),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(300.0),
                  ),
                ),
              ),
            ),
          ],
        );
}
else{
return Center(
          child: ElevatedButton(
            onPressed: () async {
              await Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>  LoginPage(userPreferences: userPreferences,productPreferences:productPreferences),
                ),
              );
              setState(() {});
            },
            child: Text(
              appLocalizations.sign_in,
              style: theme.textTheme.bodyText2?.copyWith(
                fontSize: 18.0,
                color: theme.colorScheme.surface,
              ),
            ),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(
                Size(size.width * 0.5, theme.buttonTheme.height + 10),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(300.0),
                ),
              ),
            ),
          ),
        );
}
        }else{
          return const CircularProgressIndicator();}
        }));
        
    return result;
  }

  void _confirmLogout(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SmoothAlertDialog(
          close: false,
          title: localizations.sign_out,
          body: Text(
            localizations.sign_out_confirmation,
          ),
          actions: <SmoothActionButton>[
            SmoothActionButton(
              text: localizations.yes,
              onPressed: () async {
                UserManagementHelper.logout();
                await context.read<ProductPreferences>().resetImportances();
               List<AttributeGroup> lis= productPreferences.attributeGroups!;
               for(AttributeGroup Attgrp in lis){
                 List<Attribute> lis2 = Attgrp.attributes!;
                 for(Attribute att in lis2){
                   String ch='who_'+ att.id.toString();
                userPreferences.setWHO(ch,'');
                 }
               }
                
                Navigator.pop(context);
                setState(() {});
              },
            ),
            SmoothActionButton(
              text: localizations.no,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
