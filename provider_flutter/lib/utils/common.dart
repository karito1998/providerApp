import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom_tabs;
import 'package:geocoding/geocoding.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/booking_detail_response.dart';
import 'package:handyman_provider_flutter/models/booking_list_response.dart';
import 'package:handyman_provider_flutter/models/dashboard_response.dart';
import 'package:handyman_provider_flutter/models/service_model.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/extensions/context_ext.dart';
import 'package:handyman_provider_flutter/utils/model_keys.dart';
import 'package:handyman_provider_flutter/widgets/app_widgets.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'colors.dart';
import 'images.dart';

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'Ingles', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'images/flag/ic_us.png'), //English
    LanguageDataModel(id: 2, name: 'Hindi', languageCode: 'hi', fullLanguageCode: 'hi-IN', flag: 'images/flag/ic_india.png'),
    LanguageDataModel(id: 3, name: 'Guyaratí', languageCode: 'gu', fullLanguageCode: 'gu-IN', flag: 'images/flag/ic_india.png'), //Gujarati
    LanguageDataModel(id: 4, name: 'Afrikáans', languageCode: 'af', fullLanguageCode: 'ar-AF', flag: 'images/flag/ic_ar.png'),//Afrikaans
    LanguageDataModel(id: 5, name: 'Árabe', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: 'images/flag/ic_ar.png'), //Arabic
    LanguageDataModel(id: 6, name: 'Neerlandés', languageCode: 'nl', fullLanguageCode: 'nl-NL', flag: 'images/flag/ic_nl.png'), //Dutch
    LanguageDataModel(id: 7, name: 'Francés', languageCode: 'fr', fullLanguageCode: 'fr-FR', flag: 'images/flag/ic_fr.png'), //French
    LanguageDataModel(id: 8, name: 'Alemán', languageCode: 'de', fullLanguageCode: 'de-DE', flag: 'images/flag/ic_de.png'), //German
    LanguageDataModel(id: 9, name: 'Indonesio', languageCode: 'id', fullLanguageCode: 'id-ID', flag: 'images/flag/ic_id.png'),//Indonesian
    LanguageDataModel(id: 10, name: 'Portugués', languageCode: 'pt', fullLanguageCode: 'pt-PT', flag: 'images/flag/ic_pt.png'),//Portugal
    LanguageDataModel(id: 11, name: 'Español ', languageCode: 'es', fullLanguageCode: 'es-ES', flag: 'images/flag/ic_es.png'),//Spanish
    LanguageDataModel(id: 12, name: 'Turco', languageCode: 'tr', fullLanguageCode: 'tr-TR', flag: 'images/flag/ic_tr.png'),//Turkish
    LanguageDataModel(id: 13, name: 'Vietnamita', languageCode: 'vi', fullLanguageCode: 'vi-VI', flag: 'images/flag/ic_vi.png'),//Vietnam
    LanguageDataModel(id: 14, name: 'Albanés', languageCode: 'sq', fullLanguageCode: 'sq-SQ', flag: 'images/flag/ic_arbanian.png'),//Albanian
  ];
}

InputDecoration inputDecoration(BuildContext context, {Widget? prefixIcon, String? hint, Color? fillColor, String? counterText}) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: hint,
    labelStyle: primaryTextStyle(),
    alignLabelWithHint: true,
    counterText: counterText,
    prefixIcon: prefixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(defaultRadius),
      borderSide: BorderSide(color: primaryColor, width: 0.0),
    ),
    filled: true,
    fillColor: fillColor ?? context.cardColor,
  );
}

void setCurrencies({required List<Configurations>? value, List<PaymentSetting>? paymentSetting}) {
  if (value != null) {
    Configurations data = value.firstWhere((element) => element.type == "CURRENCY");

    if (data.country != null) {
      if (data.country!.currencyCode.validate() != appStore.currencyCode) appStore.setCurrencyCode(data.country!.currencyCode.validate());
      if (data.country!.id.toString().validate() != appStore.countryId.toString()) appStore.setCurrencyCountryId(data.country!.id.toString().validate());
      if (data.country!.symbol.validate() != appStore.currencySymbol) appStore.setCurrencySymbol(data.country!.symbol.validate());
    }
    if (paymentSetting != null) {
      setValue(PAYMENT_LIST, PaymentSetting.encode(paymentSetting.validate()));
    }
  }
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

Widget noDataFound(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      cachedImage(notDataFoundImg, height: 200, width: 200),
      8.height,
      Text(context.translate.noDataFound, style: boldTextStyle()),
    ],
  );
}

String formatDate(String? dateTime, {String format = DATE_FORMAT_1}) {
  if (dateTime.validate().isNotEmpty) {
    return DateFormat(format).format(DateTime.parse(dateTime.validate()));
  } else {
    return '';
  }
}

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')} :${parts[1].padLeft(2, '0')} min';
}

String getFirstWord(String inputString) {
  List<String> wordList = inputString.split(" ");
  if (wordList.isNotEmpty) {
    return wordList[0];
  } else {
    return ' ';
  }
}

Widget confirmationButton(BuildContext context, String btnTxt, IconData iconData, {Function? onTap}) {
  return AppButton(
    elevation: 0,
    padding: EdgeInsets.zero,
    color: Colors.transparent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, color: context.iconColor, size: 24),
        8.width,
        Text(btnTxt, style: primaryTextStyle()),
      ],
    ),
    onTap: onTap,
  );
}

Widget statusButton(double width, String btnTxt, Color color, Color txtcolor, {Function? onTap}) {
  return AppButton(
    width: width,
    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
    elevation: 0,
    color: color,
    shapeBorder: RoundedRectangleBorder(
      borderRadius: radius(defaultAppButtonRadius),
      side: BorderSide(color: primaryColor),
    ),
    child: Text(
      btnTxt,
      style: boldTextStyle(color: txtcolor),
      textAlign: TextAlign.justify,
    ),
    onTap: onTap,
  );
}

Future<void> commonLaunchUrl(String address, {LaunchMode launchMode = LaunchMode.inAppWebView}) async {
  await launchUrl(Uri.parse(address), mode: launchMode).catchError((e) {
    toast('Invalid URL: $address');
  });
}

void launchCall(String? url) {
  if (url.validate().isNotEmpty) {
    commonLaunchUrl('tel:' + url!, launchMode: LaunchMode.externalApplication);
  }
}

void launchMail(String? url) {
  if (url.validate().isNotEmpty) {
    commonLaunchUrl('mailto:' + url!, launchMode: LaunchMode.externalApplication);
  }
}

Future<void> saveOneSignalPlayerId() async {
  await OneSignal.shared.getDeviceState().then((value) async {
    if (value!.userId.validate().isNotEmpty) await setValue(PLAYERID, value.userId.validate());
  });
}

calculateLatLong(String address) async {
  try {
    List<Location> destinationPlacemark = await locationFromAddress(address);
    double? destinationLatitude = destinationPlacemark[0].latitude;
    double? destinationLongitude = destinationPlacemark[0].longitude;
    List<double?> destinationCoordinatesString = [destinationLatitude, destinationLongitude];
    return destinationCoordinatesString;
  } catch (e) {
    throw errorSomethingWentWrong;
  }
}

bool get isRTL => RTLLanguage.contains(appStore.selectedLanguageCode);

num calculateTotalAmount({
  required num servicePrice,
  required int qty,
  required num? serviceDiscountPercent,
  CouponData? couponData,
  Service? detail,
  required List<Taxes>? taxes,
}) {
  double totalAmount = 0.0;
  double discountPrice = 0.0;
  double taxAmount = 0.0;
  double couponDiscountAmount = 0.0;

  if (couponData != null) {
    if (detail != null) {
      detail.couponId = couponData.id.toString();
      detail.appliedCouponData = couponData;
    }
    if (couponData.discount_type == DiscountTypeFixed) {
      totalAmount = totalAmount - couponData.discount.validate();
      couponDiscountAmount = couponData.discount.validate().toDouble();
    } else {
      totalAmount = totalAmount - ((totalAmount * couponData.discount.validate()) / 100);
      couponDiscountAmount = (couponDiscountAmount);
    }
  }

  taxes.validate().forEach((element) {
    if (isCommissionTypePercent(element.type)) {
      element.totalCalculatedValue = ((servicePrice * qty) * element.value.validate()) / 100;
    } else {
      element.totalCalculatedValue = element.value.validate();
    }
    taxAmount += element.totalCalculatedValue.validate().toDouble();
  });

  if (serviceDiscountPercent.validate() != 0) {
    totalAmount = (servicePrice * qty) - (((servicePrice * qty) * (serviceDiscountPercent!)) / 100);
    discountPrice = servicePrice * qty - totalAmount;
    totalAmount = (servicePrice * qty) - discountPrice - couponDiscountAmount + taxAmount;
  } else {
    totalAmount = (servicePrice * qty) - couponDiscountAmount + taxAmount;
  }

  if (detail != null) {
    detail.totalAmount = totalAmount.validate();
    detail.qty = qty.validate();
    detail.discountPrice = discountPrice.validate();
    detail.taxAmount = taxAmount.validate();
    detail.couponDiscountAmount = couponDiscountAmount.validate();
  }

  return totalAmount;
}

String calculateExperience() {
  int exp = 0;

  return exp.toString();
}

bool isCommissionTypePercent(String? type) => type.validate() == CommissionTypePercent;

bool get isUserTypeHandyman => appStore.userType == UserTypeHandyman;

bool get isUserTypeProvider => appStore.userType == UserTypeProvider;

Widget circleImage({required String image, double size = 24}) {
  return cachedImage(image, width: size, height: size, fit: BoxFit.cover).cornerRadiusWithClipRRect(90);
}

void launchUrlCustomTab(String? url) {
  if (url.validate().isNotEmpty) {
    custom_tabs.launch(
      url!,
      customTabsOption: custom_tabs.CustomTabsOption(
        enableDefaultShare: true,
        enableInstantApps: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        toolbarColor: primaryColor,
      ),
    );
  }
}

// Logic For Calculate Time
String calculateTimer(int secTime) {
  int hour = 0, minute = 0, seconds = 0;

  hour = secTime ~/ 3600;

  minute = ((secTime - hour * 3600)) ~/ 60;

  seconds = secTime - (hour * 3600) - (minute * 60);

  String hourLeft = hour.toString().length < 2 ? "0" + hour.toString() : hour.toString();

  String minuteLeft = minute.toString().length < 2 ? "0" + minute.toString() : minute.toString();

  String minutes = minuteLeft == '00' ? '01' : minuteLeft;

  String result = "$hourLeft:$minutes";

  return result;
}

num hourlyCalculation({required int secTime, required num price}) {
  num result = 0;

  String time = calculateTimer(secTime);
  String perMinuteCharge = (price / 60).toStringAsFixed(2);

  if (time == "01:00") {
    String value = (price * 1).toStringAsFixed(2);
    result = value.toDouble();
  } else {
    List<String> data = time.split(":");
    if (data.first == "00") {
      String value;
      if (secTime < 60) {
        value = (perMinuteCharge.toDouble() * 1).toStringAsFixed(2);
      } else {
        value = (perMinuteCharge.toDouble() * data.last.toDouble()).toStringAsFixed(2);
      }
      result = value.toDouble();
    } else {
      if (data.first.toInt() > 01 && data.last.toInt() == 00) {
        String value = (price * data.first.toInt()).toStringAsFixed(2);
        result = value.toDouble();
      } else {
        String value = (price * data.first.toInt()).toStringAsFixed(2);
        String extraMinuteCharge = (data.last.toDouble() * perMinuteCharge.toDouble()).toStringAsFixed(2);
        String finalPrice = (value.toDouble() + extraMinuteCharge.toDouble()).toStringAsFixed(2);
        result = finalPrice.toDouble();
      }
    }
  }

  return result.toDouble();
}

Widget subSubscriptionPlanWidget({Color? planBgColor, String? planTitle, String? planSubtitle, String? planButtonTxt, Function? onTap, Color? btnColor}) {
  return Container(
    color: planBgColor,
    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 24),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(planTitle.validate(), style: boldTextStyle()),
            8.height,
            Text(planSubtitle.validate(), style: secondaryTextStyle()),
          ],
        ).flexible(),
        AppButton(
          child: Text(planButtonTxt.validate(), style: boldTextStyle(color: white)),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: btnColor,
          elevation: 0,
          onTap: () {
            onTap?.call();
          },
        ),
      ],
    ),
  );
}

Brightness getStatusBrightness({required bool val}) {
  return val ? Brightness.light : Brightness.dark;
}

String getPaymentStatusText(String? status) {
  if (status == SERVICE_PAYMENT_STATUS_PAID) {
    return 'Paid';
  } else if (status == SERVICE_PAYMENT_STATUS_PENDING) {
    return 'Pending';
  } else if (status != null) {
    return 'Pending Approval';
  } else {
    return "";
  }
}

String getReasonText(BuildContext context, String val) {
  if (val == BookingStatusKeys.cancelled) {
    return context.translate.lblReasonCancelling;
  } else if (val == BookingStatusKeys.rejected) {
    return context.translate.lblReasonRejecting;
  } else if (val == BookingStatusKeys.failed) {
    return context.translate.lblFailed;
  }
  return '';
}
