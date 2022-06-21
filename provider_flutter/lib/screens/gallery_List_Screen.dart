import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/components/back_widget.dart';
import 'package:handyman_provider_flutter/screens/zoom_image_screen.dart';
import 'package:handyman_provider_flutter/utils/extensions/context_ext.dart';
import 'package:handyman_provider_flutter/widgets/app_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class GalleryListScreen extends StatelessWidget {
  final List<String>? galleryImages;
  final String? serviceName;

  GalleryListScreen({this.galleryImages, this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        "${context.translate.lblGallery} ${'- ${serviceName.validate()}'}",
        textColor: white,
        color: context.primaryColor,
        backWidget: BackWidget(),
      ),
      body: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: List.generate(
          galleryImages!.length,
          (index) {
            return cachedImage(
              galleryImages![index],
              height: 110,
              width: context.width() * 0.33 - 20,
              fit: BoxFit.cover,
            ).cornerRadiusWithClipRRect(8).onTap(() {
              ZoomImageScreen(galleryImages: galleryImages, index: index).launch(context);
            });
          },
        ),
      ).paddingAll(16),
    );
  }
}
