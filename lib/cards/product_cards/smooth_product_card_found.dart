// ignore_for_file: non_constant_identifier_names, always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:openfoodfacts/model/Attribute.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/personalized_search/matched_product.dart';
import 'package:openfoodfacts/personalized_search/preference_importance.dart';
import 'package:provider/provider.dart';
import 'package:smooth_app/cards/data_cards/svg_icon_chip.dart';
import 'package:smooth_app/data_models/product_preferences.dart';
import 'package:smooth_app/database/product_query.dart';
import 'package:smooth_app/generic_lib/widgets/smooth_product_image.dart';
import 'package:smooth_app/helpers/product_cards_helper.dart';
import 'package:smooth_app/helpers/product_compatibility_helper.dart';
import 'package:smooth_app/helpers/ui_helpers.dart';
import 'package:smooth_app/language/language.dart';
import 'package:smooth_app/pages/product/new_product_page.dart';

class SmoothProductCardFound extends StatelessWidget {
  const SmoothProductCardFound({
    required this.product,
    required this.heroTag,
    this.elevation = 0.0,
    this.backgroundColor,
    this.handle,
    this.onLongPress,
    this.refresh,
    this.onTap,
  });

  final Product product;
  final String heroTag;
  final double elevation;
  final Color? backgroundColor;
  final Widget? handle;
  final VoidCallback? onLongPress;
  final VoidCallback? refresh;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    final Size screenSize = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    final List<Widget> scores = <Widget>[];
    final double iconSize = IconWidgetSizer.getIconSizeFromContext(context);
    final List<Attribute> attributes =
        getPopulatedAttributes(product, SCORE_ATTRIBUTE_IDS);
    for (final Attribute attribute in attributes) {
      scores.add(SvgIconChip(attribute.iconUrl!, height: iconSize));
    }
    return GestureDetector(
      onTap: onTap ??
          () async {
            await Navigator.push<Widget>(
              context,
              MaterialPageRoute<Widget>(
                builder: (BuildContext context) => ProductPage(product),
              ),
            );
            refresh?.call();
          },
      onLongPress: () {
        onLongPress?.call();
      },
      child: Hero(
        tag: heroTag,
        child: Material(
          elevation: elevation,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? themeData.colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            padding: const EdgeInsets.all(VERY_SMALL_SPACE),
            child: Row(
              children: <Widget>[
                SmoothProductImage(
                  product: product,
                  width: screenSize.width * 0.20,
                  height: screenSize.width * 0.20,
                ),
                const Padding(padding: EdgeInsets.only(left: VERY_SMALL_SPACE)),
                Expanded(
                  child: SizedBox(
                    height: screenSize.width * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.productName ??
                              appLocalizations.unknownProductName,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          product.brands ?? appLocalizations.unknownBrand,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      FutureBuilder<String?>(
                        future: OpenFoodAPIClient.getdescription(ProductQueryConfiguration( product.barcode!,language: ProductQuery.getLanguage(),country: ProductQuery.getCountry(),fields: <ProductField>[ProductField.KNOWLEDGE_PANELS],version: ProductQueryVersion.v2,)) ,
                        builder:(context, snapshot){
                          if (snapshot.hasData){ 
                            final List<Attribute> grp = get_grp(snapshot.data,context,appLocalizations.yes);
                            final MatchedProduct matchedProduct = MatchedProduct(
                             product,
                               context.watch<ProductPreferences>(),
                              grp
                             );
                            final ProductCompatibilityHelper helper =
                             ProductCompatibilityHelper(matchedProduct);
                            return Row(
                          children: <Widget>[
                            Icon(
                              Icons.circle,
                              size: 15,
                              color: helper.getBackgroundColor(),
                            ),
                            const Padding(
                                padding:
                                    EdgeInsets.only(left: VERY_SMALL_SPACE)),
                            Text(
                              helper.getSubtitle(appLocalizations),
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        );
                        } else {
                        return const CircularProgressIndicator();
                        }
                        }
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: VERY_SMALL_SPACE)),
                Column(
                  children: scores,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


    List<Attribute> get_grp(String? desc,BuildContext context,String languetest){
        final ProductPreferences productPreferences =
        context.watch<ProductPreferences>();
      final List<Attribute> grp = <Attribute>[];
      Language.build(context);
      final List<String> attributees =['allergens_no_Kiwi','allergens_no_Pêche','allergens_no_Pomme','allergens_no_Fraise','allergens_no_Amande','allergens_no_Noix','allergens_no_Noisettes','allergens_no_Fruits_de_mer'];
      if(desc != null){
        String? attributeName;
        for(final String attributeId in attributees ){
                   switch (attributeId){ 
      case 'allergens_no_Kiwi' : attributeName = Language.kiwi;break;
      case 'allergens_no_Pêche' : attributeName = Language.peach ;break;
      case 'allergens_no_Pomme' : attributeName = Language.apple ;break;
      case 'allergens_no_Fraise' : attributeName = Language.strawberry ;break;
      case 'allergens_no_Amande' : attributeName = Language.almond ;break;
      case 'allergens_no_Noix' : attributeName = Language.nut ;break;
      case 'allergens_no_Noisette' : attributeName = Language.hazelnut ;break;
      case 'allergens_no_Fruits_de_mer' : attributeName = Language.shellfish ;break;
        }

           final String importanceId = productPreferences.getImportanceIdForAttributeId(attributeId);
          if(PreferenceImportance.ID_MANDATORY == importanceId || PreferenceImportance.ID_IMPORTANT == importanceId ){
            final Attribute attributee = Attribute(id: attributeId,name: attributeName);
           if(languetest== 'Oui' || languetest=='Yes'){
                   if(desc.contains(attributeName!) ||  desc.contains(attributeName.toLowerCase()))
            {
              attributee.title ='contient : ${attributee.name}';
              attributee.status='known';
              attributee.match=0.0;
              grp.add(attributee);
            }else{
            attributee.title = 'Ne contient pas : ${attributee.name}';
             attributee.status='known';
             attributee.match=100.0;
             grp.add(attributee);
            }
          }else{
             if(desc.contains(attributeName!))
            {
              attributee.title ='contient : ${attributee.name}';
              attributee.status='known';
              attributee.match=0.0;
              grp.add(attributee);
            }else{
            attributee.title = 'Ne contient pas : ${attributee.name}';
             attributee.status='known';
             attributee.match=100.0;
             grp.add(attributee);
            }
          }
        }
        }
      }
    return grp;
  }
