// ignore_for_file: non_constant_identifier_names, always_put_control_body_on_new_line, prefer_const_constructors, avoid_field_initializers_in_const_classes, always_specify_types, avoid_void_async, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/Attribute.dart';
import 'package:openfoodfacts/model/AttributeGroup.dart';
import 'package:openfoodfacts/personalized_search/preference_importance.dart';
import 'package:smooth_app/data_models/product_preferences.dart';
import 'package:smooth_app/data_models/user_preferences.dart';
import 'package:smooth_app/helpers/ui_helpers.dart';
import 'package:smooth_app/language/language.dart';

/// Colored button for attribute importance, with corresponding action
class AttributeButton extends StatelessWidget {
   AttributeButton(
    this.attribute,
    this.productPreferences,
    this.userPreferences
  );
  final Attribute attribute;
  final ProductPreferences productPreferences;
  final UserPreferences userPreferences;
  static const Map<String, String> _nextValues = <String, String>{
    PreferenceImportance.ID_NOT_IMPORTANT: PreferenceImportance.ID_IMPORTANT,
    PreferenceImportance.ID_IMPORTANT: PreferenceImportance.ID_MANDATORY,
    PreferenceImportance.ID_MANDATORY: PreferenceImportance.ID_NOT_IMPORTANT,
  };
   final List<String> HowVal = ['ME','Member_of_my_family','Both'];
  static const Map<String, Color> _colors = <String, Color>{
    PreferenceImportance.ID_NOT_IMPORTANT: Color(0xFF666666),
    PreferenceImportance.ID_IMPORTANT: Colors.blue,
    PreferenceImportance.ID_MANDATORY: Colors.red,
  };
  

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    String importanceId =
        productPreferences.getImportanceIdForAttributeId(attribute.id!);
    // We switch from 4 to 3 choices: very important is downgraded to important
    if (importanceId == PreferenceImportance.ID_VERY_IMPORTANT) {
      importanceId = PreferenceImportance.ID_IMPORTANT;
    }
    const double horizontalPadding = LARGE_SPACE;
    final double screenWidth =
        MediaQuery.of(context).size.width - 2 * horizontalPadding;
    final TextStyle style = themeData.textTheme.headline3!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: screenWidth * .45,
            child: Text(attribute.name!, style: style),
          ),
          SizedBox(
            width: screenWidth * .45,
            child: ElevatedButton(
              child: Text(
                productPreferences
                    .getPreferenceImportanceFromImportanceId(importanceId)!
                    .name!,
                style: style.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: _colors[importanceId],
                onPrimary: Colors.white,
              ),
              onPressed: () async {
               
               final List<AttributeGroup> groups= productPreferences.attributeGroups!;
               final AttributeGroup group = (groups.where((AttributeGroup g) => g.id == 'allergens')).first;
                if(group.attributes!.contains(attribute)){
                   if(_nextValues[importanceId] == PreferenceImportance.ID_IMPORTANT){_confirm_who(context, importanceId);  }
                else{
                  if(_nextValues[importanceId] == PreferenceImportance.ID_NOT_IMPORTANT){  userPreferences.setWHO('who_${attribute.id!}','');   }
                }
                }
                return productPreferences.setImportance(
                  attribute.id!, _nextValues[importanceId]!);
              },
            ),
          ),
        ],
      ),
    );
  }
void _confirm_who(BuildContext context,String importanceId) {
  Language.build(context);
      final String how_id= 'who_${attribute.id!}';
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Language.who_have_this_allergy!),
          actions: <Widget>[
            TextButton(
              child: Text(Language.me!),
              onPressed: () {
               final String get =  userPreferences.getWHO(how_id);
                if(get != HowVal[0]) userPreferences.setWHO(how_id,HowVal[0]);
                // update_server(group,importanceId);
               Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(Language.Member_of_my_family!),
              onPressed: () {
                final String get =  userPreferences.getWHO(how_id);
                if(get != HowVal[1]) userPreferences.setWHO(how_id,HowVal[1]);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(Language.both!),
              onPressed: () {
                final String get =  userPreferences.getWHO(how_id);
                if(get != HowVal[2]) userPreferences.setWHO(how_id,HowVal[2]);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(Language.close!),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );

  }

}
