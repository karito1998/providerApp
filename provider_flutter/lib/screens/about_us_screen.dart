import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/about_model.dart';
import 'package:handyman_provider_flutter/utils/common.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/data_provider.dart';
import 'package:handyman_provider_flutter/utils/extensions/context_ext.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  AboutUsScreenState createState() => AboutUsScreenState();
}

class AboutUsScreenState extends State<AboutUsScreen> {
  int? index;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    List<AboutModel> aboutList = getAboutDataModel(context: context);

    return Scaffold(
      appBar: appBarWidget(
        context.translate.lblAbout,
        textColor: white,
        elevation: 0.0,
        backWidget: Icon(Icons.chevron_left, color: white, size: 32).onTap(() {
          finish(context);
        }),
        color: context.primaryColor,
      ),
      body: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: List.generate(
          aboutList.length,
          (index) {
            return Container(
              width: context.width() * 0.5 - 26,
              height: 130,
              padding: EdgeInsets.all(16),
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radius(),
                backgroundColor: context.cardColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(aboutList[index].image.toString(), height: 28, width: 28, color: context.iconColor),
                  16.height,
                  Text(aboutList[index].title.toString(), style: boldTextStyle(size: 18)),
                ],
              ),
            ).onTap(
              () async {
                if (index == 0) {
                  launchUrlCustomTab(appStore.termConditions.isNotEmpty ? appStore.termConditions.validate() : termsConditionUrl);
                } else if (index == 1) {
                  launchUrlCustomTab(appStore.privacyPolicy.isNotEmpty ? appStore.privacyPolicy.validate() : privacyPolicyUrl);
                } else if (index == 2) {
                  if (appStore.inquiryEmail.isNotEmpty) {
                    launchUri(MAIL_TO + appStore.inquiryEmail.validate());
                  } else {
                    launchUrlCustomTab(helpSupportUrl);
                  }
                } else if (index == 3) {
                  if (appStore.helplineNumber.isNotEmpty) {
                    launchUri(TEL + appStore.helplineNumber.validate());
                  } else {
                    //TODO Translate
                    toast("Not Available Helpline Number");
                  }
                } else if (index == 4) {
                  {
                    PackageInfo.fromPlatform().then((value) {
                      String package = '';
                      if (isAndroid) package = value.packageName;
                      launch('${isAndroid ? playStoreBaseURL : appStoreBaseURL}$package');
                    });
                  }
                }
              },
            );
          },
        ),
      ).paddingAll(16),
    );
  }
}
