// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names, always_specify_types, avoid_void_async

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:openfoodfacts/model/Attribute.dart';
import 'package:openfoodfacts/model/AttributeGroup.dart';
import 'package:provider/provider.dart';
import 'package:smooth_app/Data_Base_Api/d_b_configuration.dart';
import 'package:smooth_app/data_models/product_preferences.dart';
import 'package:smooth_app/data_models/user_preferences.dart';
import 'package:smooth_app/pages/abstract_user_preferences.dart';
import 'package:smooth_app/pages/user_preferences_Allergy.dart';
import 'package:smooth_app/pages/user_preferences_attribute_group.dart';

/// Collapsed/expanded display of attribute groups for the preferences page.
class UserPreferencesFood extends AbstractUserPreferences {
  UserPreferencesFood({
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
 late bool  _connectionStatus;

  static const List<String> _ORDERED_ATTRIBUTE_GROUP_IDS = <String>[
     AttributeGroup.ATTRIBUTE_GROUP_ALLERGENS,
    AttributeGroup.ATTRIBUTE_GROUP_NUTRITIONAL_QUALITY,
    AttributeGroup.ATTRIBUTE_GROUP_INGREDIENT_ANALYSIS,
    AttributeGroup.ATTRIBUTE_GROUP_ENVIRONMENT,
    AttributeGroup.ATTRIBUTE_GROUP_PROCESSING,
    AttributeGroup.ATTRIBUTE_GROUP_LABELS,
   
  ];

  @override
  bool isCollapsedByDefault() => false;


  @override
  String getPreferenceFlagKey() => 'attributes';

  @override
  Widget getTitle() => Text(
        appLocalizations.myPreferences_food_title,
        style: themeData.textTheme.headline2,
      );

  @override
  Widget? getSubtitle() => Text(appLocalizations.myPreferences_food_subtitle);


Widget _build(BuildContext context,List<AttributeGroup> groups) {
  return  OfflineBuilder(
              connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                  ) {
                _connectionStatus = connectivity != ConnectivityResult.none;
                if(_connectionStatus){
                    update_server(groups);
                    // print(userPreferences.getImportance('allergens_no_gluten'));
                }
                return Stack() ;
              },
              builder: (BuildContext context) {
                return const SizedBox();
              }
              );
  
}


  @override
  List<Widget> getBody() {
    final List<AttributeGroup> groups =
        _reorderGroups(productPreferences.attributeGroups!);
        
    final List<Widget> result = <Widget>[
      // ListTile(
      //   leading: const Icon(Icons.rotate_left),
      //   title: Text(appLocalizations.reset_food_prefs),
      //   onTap: () => _confirmReset(context),
      // ),
    ];
     
    result.add(_build(context,groups));
    for (final AttributeGroup group in groups) {
     late AbstractUserPreferences abstractUserPreferences;
      if(group.id==AttributeGroup.ATTRIBUTE_GROUP_ALLERGENS){ 
       final AbstractUserPreferences abstractUserPreference = UserPreferencesAllergy(
          productPreferences: productPreferences,
        group: group,
        setState: setState,
        context: context,
        userPreferences: userPreferences,
        appLocalizations: appLocalizations,
        themeData: themeData,
      );
       result.addAll(abstractUserPreference.getContent());
      //  final List<Attribute> list_1 = [group.attributes!.where((e) => e.id=='allergens_no_gluten').single,group.attributes!.where((e) => e.id=='allergens_no_milk').single,group.attributes!.where((e) => e.id=='allergens_no_eggs').single,group.attributes!.where((e) => e.id=='allergens_no_sesame_seeds').single,group.attributes!.where((e) => e.id=='allergens_no_lupin').single,group.attributes!.where((e) => e.id=='allergens_no_soybeans').single,group.attributes!.where((e) => e.id=='allergens_no_mustard').single];
      //  final List<Attribute> list_2 = [group.attributes!.where((e) => e.id=='allergens_no_crustaceans').single,group.attributes!.where((e) => e.id=='allergens_no_fish').single,group.attributes!.where((e) => e.id=='allergens_no_molluscs').single,group.attributes!.where((e) => e.id=='allergens_no_Fruits de mer').single];        
      //  final List<Attribute> list_3 = [group.attributes!.where((e) => e.id=='allergens_no_nuts').single,group.attributes!.where((e) => e.id=='allergens_no_no_Amande').single,group.attributes!.where((e) => e.id=='allergens_no_Noix').single,group.attributes!.where((e) => e.id=='allergens_no_Noisettes').single,group.attributes!.where((e) => e.id=='allergens_no_peanuts').single];        
      //  final List<Attribute> list_4 = [group.attributes!.where((e) => e.id=='allergens_no_Kiwi').single,group.attributes!.where((e) => e.id=='allergens_no_Pêche').single,group.attributes!.where((e) => e.id=='allergens_no_Pomme').single,group.attributes!.where((e) => e.id=='allergens_no_Fraise').single,group.attributes!.where((e) => e.id=='allergens_no_celery').single];        
      //  final AttributeGroup grp1 = AttributeGroup(id: 'allergens_Diversed',name: 'Diversed',attributes: list_1);
      //  final AttributeGroup grp2 = AttributeGroup(id: 'allergens_Sea Food',name: 'Sea Food',attributes: list_2);
      //  final AttributeGroup grp3 = AttributeGroup(id: 'allergens_fruit a coque',name:  'fruit a coque',attributes: list_3);
      //  final AttributeGroup grp4 = AttributeGroup(id: 'allergens_fruit et legime',name: 'fruit et legime',attributes: list_4);
      //  final List<AttributeGroup> grp_list =[grp1,grp2,grp3,grp4];
    
      //   for(final AttributeGroup grp in grp_list){ 
      //   abstractUserPreferences   =   
      //   UserPreferencesAttributeGroup(
      //   productPreferences: productPreferences,
      //   group: grp,
      //   setState: setState,
      //   context: context,
      //   userPreferences: userPreferences,
      //   appLocalizations: appLocalizations,
      //   themeData: themeData,
      // );
      //  result.addAll(abstractUserPreferences.getContent());
      //    }
         }else{      
        abstractUserPreferences   =
        UserPreferencesAttributeGroup(
        productPreferences: productPreferences,
        group: group,
        setState: setState,
        context: context,
        userPreferences: userPreferences,
        appLocalizations: appLocalizations,
        themeData: themeData,
      );
       result.addAll(abstractUserPreferences.getContent());}

     
    }
   
    return result;
  }

  List<AttributeGroup> _reorderGroups(List<AttributeGroup> groups) {
    final List<AttributeGroup> result = <AttributeGroup>[];
    for (final String id in _ORDERED_ATTRIBUTE_GROUP_IDS) {
      result.addAll(groups.where((AttributeGroup g) => g.id == id));
    }
    result.addAll(groups.where(
        (AttributeGroup g) => !_ORDERED_ATTRIBUTE_GROUP_IDS.contains(g.id)));
    return result;
  }

  // void _confirmReset(BuildContext context) {
  //   final AppLocalizations localizations = AppLocalizations.of(context)!;
  //   showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(localizations.confirmResetPreferences),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text(localizations.yes),
  //             onPressed: () async {
  //               await context.read<ProductPreferences>().resetImportances();
  //               Navigator.pop(context);
  //             },
  //           ),
  //           TextButton(
  //             child: Text(localizations.no),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  void update_server(List<AttributeGroup> groups) async{
    final AttributeGroup group = (groups.where((AttributeGroup g) => g.id == 'allergens')).first;
              if(DataBaseConfiguration.user != null){
                final Map<String,dynamic> Data = await DataBaseConfiguration.getData();
                 final  Map<String,String> att_map={'user_id': Data['id'].toString()} ;
                  Attribute attributt;
                  for(attributt in group.attributes!){
                    att_map[attributt.id!] = userPreferences.getImportance(attributt.id!);
                    att_map['who_${attributt.id}'] = userPreferences.getWHO('who_${attributt.id}');
                  }
                  DataBaseConfiguration.updateDataAllergy(att_map); }
  }
}
