// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_app/helpers/ui_helpers.dart';
// ignore: avoid_classes_with_only_static_members
class Language {
  static String? email ;
  static String? first_name ;
   static String? last_name ;   
   static String? age;
   static String? length ;
   static String? weight;
   static String? food_restriction;
   static String? allergy;
   static String? another_allergy;
   static String? who_have_this_allergy;
   static String? me ;  
   static String?  both;
   static String?  close;
   static String? Member_of_my_family;
   static String? kiwi;
   static String? peach ;
   static String? apple;
   static String? strawberry;
   static String? almond;
   static String? nut;
   static String? hazelnut;
   static String? peanut;
   static String? fishes;
   static String? shellfish;
   static String? welcome;
 static Widget build(BuildContext context) {
  final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
  
if( appLocalizations.yes=='Oui'){
email='email';
first_name='Prénom';
last_name='nom';
age='âge';
length='longueur';
weight='poids';
food_restriction='restrictions alimentaires';
allergy='Allergie';
another_allergy='Une autre allergie';
who_have_this_allergy ='Qui a cette allergie ?';
Member_of_my_family='Membre de ma famille';
both='Tous les deux';
close='fermer';
kiwi='Kiwi';
peach='Pêche';
apple='Pomme';
strawberry='Fraise';
almond='Amande';
nut='Noix';
hazelnut='Noisette';
shellfish='Fruits de mer';
me='Moi';
welcome='Bienvenue';
}
else if( appLocalizations.yes=='Yes'){
email='email';
first_name='First Name';
last_name='Last Name';
age='Age';
length='Length';
weight='Weight';
food_restriction='Food Restriction';
allergy='Allergy';
another_allergy='Another Allergy';
who_have_this_allergy ='Who have this allergy?';
Member_of_my_family='Member of my family';
both='Both';
close='Close';
kiwi='Kiwi';
peach='Peach';
apple='Apple';
strawberry='Strawberry';
almond='Almond';
nut='Nut';
hazelnut='Hazelnut';
shellfish='Shellfish';
me='Me';
welcome='Welcome';
}
else if( appLocalizations.yes=='نعم'){
email='بريد الالكتروني';
first_name='الإ سم';
last_name='اللقب';
length='الطول';
weight='الوزن';
food_restriction='تقييد الطعام';
allergy='الحساسية';
another_allergy='حساسية أخرى';
who_have_this_allergy ='من لديه هذه الحساسية؟';
Member_of_my_family='فرد من عائلتي';
both='كلاهما';
close='اغلاق';
kiwi='كيوي';
peach='خوخ';
apple='تفاح';
strawberry='الفراولة';
almond='لوز';
nut='جوز';
hazelnut='بندق';
shellfish='المحار';
me='أنا';
welcome='مرحبا';
}
return EMPTY_WIDGET;
  }
}