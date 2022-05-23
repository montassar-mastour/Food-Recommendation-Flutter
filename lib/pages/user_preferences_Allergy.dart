// ignore_for_file: always_specify_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:openfoodfacts/model/Attribute.dart';
import 'package:openfoodfacts/model/AttributeGroup.dart';
import 'package:smooth_app/data_models/product_preferences.dart';
import 'package:smooth_app/data_models/user_preferences.dart';
import 'package:smooth_app/language/language.dart';
import 'package:smooth_app/pages/abstract_user_preferences.dart';
import 'package:smooth_app/pages/user_preferences_attribute_group.dart';
 class UserPreferencesAllergy extends AbstractUserPreferences {
  UserPreferencesAllergy({
    required this.productPreferences,
    required this.group,
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
  bool isCollapsedByDefault() => false;

  @override
  String getPreferenceFlagKey() => 'attribute:${group.id}';
  final AttributeGroup group;

  @override
  Widget getTitle() => Text('Hassassia' , style: themeData.textTheme.headline6);
  @override
  Widget? getSubtitle() => null;

  @override
  bool isCompactTitle() => true;

  @override
  List<Widget> getBody() {
    final List<Widget> result = <Widget>[
      // ListTile(
      //   leading: const Icon(Icons.rotate_left),
      //   title: Text(appLocalizations.reset_food_prefs),
      //   onTap: () => _confirmReset(context),
      // ),
    ];
     late AbstractUserPreferences abstractUserPreferences;
      Language.build(context);
     final List<Attribute> list_1 = [group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_GLUTEN).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_MILK).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_EGGS).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_SESAME_SEEDS).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_LUPIN).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_SOYBEANS).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_MUSTARD).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_SULPHUR_DIOXIDE_AND_SULPHITES).single];
       final List<Attribute> list_2 = [group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_CRUSTACEANS).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_FISH).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_MOLLUSCS).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_Fruits_de_mer).single];        
       final List<Attribute> list_3 = [group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_NUTS).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_Amande).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_Noix).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_Noisettes).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_PEANUTS).single];        
       final List<Attribute> list_4 = [group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_Kiwi).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_Peche).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_Pomme).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_Fraise).single,group.attributes!.where((e) => e.id==Attribute.ATTRIBUTE_ALLERGENS_NO_CELERY).single];   
       final AttributeGroup grp1 = AttributeGroup(id: AttributeGroup.ATTRIBUTE_GROUP_ALLERGENS_Other,name: Language.Other,attributes: list_1);
       final AttributeGroup grp2 = AttributeGroup(id: AttributeGroup.ATTRIBUTE_GROUP_ALLERGENS_Sea_Food,name: Language.sea_food,attributes: list_2);
       final AttributeGroup grp3 = AttributeGroup(id: AttributeGroup.ATTRIBUTE_GROUP_ALLERGENS_Nuts,name:  Language.nuts,attributes: list_3);
       final AttributeGroup grp4 = AttributeGroup(id: AttributeGroup.ATTRIBUTE_GROUP_ALLERGENS_Fruit_and_vegetable,name: Language.fruit_and_vegetable,attributes: list_4);
     final List<AttributeGroup> grp_list =[grp2,grp3,grp4,grp1];
  

        for(final AttributeGroup grp in grp_list){ 
        abstractUserPreferences   =   
        UserPreferencesAttributeGroup(
        productPreferences: productPreferences,
        group: grp,
        setState: setState,
        context: context,
        userPreferences: userPreferences,
        appLocalizations: appLocalizations,
        themeData: themeData,
      );
       result.addAll(abstractUserPreferences.getContent());
         }
         return result;
  }



}