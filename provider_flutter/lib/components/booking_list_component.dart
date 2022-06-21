import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/components/price_widget.dart';
import 'package:handyman_provider_flutter/handyman/screen/handyman_booking_detail_screen.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/booking_list_response.dart';
import 'package:handyman_provider_flutter/networks/rest_apis.dart';
import 'package:handyman_provider_flutter/provider/booking/booking_summary_dialog.dart';
import 'package:handyman_provider_flutter/provider/booking/p_booking_detail_screen.dart';
import 'package:handyman_provider_flutter/provider/handyman/assign_handyman_Dialog.dart';
import 'package:handyman_provider_flutter/utils/app_common.dart';
import 'package:handyman_provider_flutter/utils/color_extension.dart';
import 'package:handyman_provider_flutter/utils/colors.dart';
import 'package:handyman_provider_flutter/utils/common.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/extensions/context_ext.dart';
import 'package:handyman_provider_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

import '../widgets/app_widgets.dart';

class BookingListComponent extends StatefulWidget {
  final String? status;
  final BookingData bookingData;
  final int? index;

  BookingListComponent({this.status, required this.bookingData, this.index});

  @override
  BookingListComponentState createState() => BookingListComponentState();
}

class BookingListComponentState extends State<BookingListComponent> {
  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      init();
    });
  }

  Future<void> init() async {
    //
  }

  Future<void> updateBooking(int bookingId, String updatedStatus, int index) async {
    appStore.setLoading(true);
    Map request = {
      CommonKeys.id: bookingId,
      BookingUpdateKeys.status: updatedStatus,
    };
    await bookingUpdate(request).then((res) async {
      LiveStream().emit(LiveStreamUpdateBookings);
      setState(() {});
      appStore.setLoading(false);
    }).catchError((e) {
      appStore.setLoading(false);
    });
  }

  Future<void> confirmationRequestDialog(BuildContext context, int index, String status) async {
    showConfirmDialogCustom(
      context,
      positiveText: context.translate.lblYes,
      negativeText: context.translate.lblNo,
      primaryColor: status == BookingStatusKeys.rejected ? Colors.redAccent : primaryColor,
      onAccept: (context) async {
        LiveStream().emit(LiveStreamUpdateBookings);
        updateBooking(widget.bookingData.id.validate(), status, index);
      },
      title: context.translate.confirmationRequestTxt,
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 16),
      width: context.width(),
      decoration: cardDecoration(context),

      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cachedImage(
                widget.bookingData.image_attchments!.isNotEmpty ? widget.bookingData.image_attchments!.first.validate() : '',
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              ).cornerRadiusWithClipRRect(defaultRadius),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.bookingData.status.validate().getPaymentStatusBackgroundColor.withOpacity(0.1),
                          borderRadius: radius(),
                        ),
                        child: Text(
                          widget.bookingData.status_label.validate(),
                          style: boldTextStyle(color: widget.bookingData.status.validate().getPaymentStatusBackgroundColor, size: 12),
                        ),
                      ),
                      Text(
                        '#${widget.bookingData.id.validate()}',
                        style: boldTextStyle(color: context.primaryColor, size: 16),
                      ),
                    ],
                  ),
                  8.height,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.bookingData.service_name.validate(),
                        style: boldTextStyle(size: 16),
                        overflow: TextOverflow.ellipsis,
                      ).expand(),
                    ],
                  ),
                  8.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PriceWidget(
                        price: widget.bookingData.type == ServiceTypeHourly
                            ? widget.bookingData.totalAmount.validate()
                            : calculateTotalAmount(
                                servicePrice: widget.bookingData.price.validate(),
                                qty: widget.bookingData.quantity.validate(),
                                couponData: widget.bookingData.couponData != null ? widget.bookingData.couponData : null,
                                taxes: widget.bookingData.taxes.validate(),
                                serviceDiscountPercent: widget.bookingData.discount.validate(),
                              ),
                        color: primaryColor,
                        isHourlyService: widget.bookingData.isHourlyService,
                        size: 18,
                      ),
                      if (widget.bookingData.type.toString().validate() == ServiceTypeHourly) 4.width else 8.width,
                      if (widget.bookingData.discount != null && widget.bookingData.discount != 0)
                        Row(
                          children: [
                            Text('(${widget.bookingData.discount}%', style: boldTextStyle(size: 14, color: Colors.green)),
                            Text(' ${context.translate.lblOff})', style: boldTextStyle(size: 14, color: Colors.green)),
                          ],
                        ),
                    ],
                  ),
                ],
              ).expand(),
            ],
          ).paddingAll(8),
          Container(
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: context.cardColor,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            margin: EdgeInsets.all(8),
            //decoration: cardDecoration(context),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.translate.lblAddress, style: secondaryTextStyle()),
                    8.width,
                    Marquee(
                      child: Text(
                        widget.bookingData.address != null ? widget.bookingData.address.validate() : context.translate.notAvailable,
                        style: boldTextStyle(size: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ).flexible(),
                  ],
                ).paddingAll(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${context.translate.lblDate} & ${context.translate.lblTime}', style: secondaryTextStyle()),
                    8.width,
                    Text(
                      "${formatDate(widget.bookingData.date.validate(), format: DATE_FORMAT_6)} At ${formatDate(widget.bookingData.date.validate(), format: DATE_FORMAT_3)}",
                      style: boldTextStyle(size: 14),
                      maxLines: 2,
                      textAlign: TextAlign.right,
                    ).expand(),
                  ],
                ).paddingAll(8),
                if (widget.bookingData.customer_name.validate().isNotEmpty)
                  Column(
                    children: [
                      Divider(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(context.translate.customer, style: secondaryTextStyle()),
                          8.width,
                          Text(widget.bookingData.customer_name.validate(), style: boldTextStyle(size: 14), textAlign: TextAlign.right).flexible(),
                        ],
                      ).paddingAll(8),
                    ],
                  ),
                if (isUserTypeHandyman && widget.bookingData.provider_name.validate().isNotEmpty)
                  Column(
                    children: [
                      Divider(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(context.translate.provider, style: secondaryTextStyle()),
                          8.width,
                          Text(widget.bookingData.provider_name.validate(), style: boldTextStyle(size: 14), textAlign: TextAlign.right).flexible(),
                        ],
                      ).paddingAll(8),
                    ],
                  ),
                if (widget.bookingData.handyman.validate().isNotEmpty && isUserTypeProvider)
                  Column(
                    children: [
                      Divider(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.translate.handyman, style: secondaryTextStyle()),
                          Text(widget.bookingData.handyman.validate().first.handyman!.displayName.validate(), style: boldTextStyle(size: 14)).flexible(),
                        ],
                      ).paddingAll(8),
                    ],
                  ),
                if (widget.bookingData.payment_status != null)
                  Column(
                    children: [
                      Divider(height: 0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.translate.paymentStatus, style: secondaryTextStyle()).expand(),
                          Text(
                            buildPaymentStatusWithMethod(widget.bookingData.payment_status.validate(), widget.bookingData.payment_method.validate()),
                            style: boldTextStyle(size: 14, color: widget.bookingData.payment_status.validate() == PAID ? Colors.green : Colors.red),
                          ),
                        ],
                      ).paddingAll(8),
                    ],
                  ),
                if (isUserTypeProvider && widget.bookingData.status == BookingStatusKeys.pending || (isUserTypeHandyman && widget.bookingData.status == BookingStatusKeys.accept))
                  Row(
                    children: [
                      if (isUserTypeProvider)
                        Row(
                          children: [
                            AppButton(
                              child: Text(context.translate.accept, style: boldTextStyle(color: white)),
                              width: context.width(),
                              color: primaryColor,
                              elevation: 0,
                              onTap: () async {
                                await showInDialog(
                                  context,
                                  backgroundColor: Colors.transparent,
                                  builder: (_) {
                                    return BookingSummaryDialog(
                                      bookingDataList: widget.bookingData,
                                      bookingId: widget.bookingData.id,
                                    );
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: radius()),
                                  contentPadding: EdgeInsets.zero,
                                );
                              },
                            ).expand(),
                            16.width,
                          ],
                        ).expand(),
                      AppButton(
                        child: Text(context.translate.decline, style: boldTextStyle()),
                        width: context.width(),
                        elevation: 0,
                        color: appStore.isDarkMode ? cardDarkColor : white,
                        onTap: () {
                          confirmationRequestDialog(context, widget.index!, BookingStatusKeys.rejected);
                        },
                      ).expand(),
                    ],
                  ).paddingOnly(bottom: 8, left: 8, right: 8, top: 16),
                if (isUserTypeProvider && widget.bookingData.handyman!.isEmpty && widget.bookingData.status == BookingStatusKeys.accept)
                  Column(
                    children: [
                      8.height,
                      AppButton(
                        width: context.width(),
                        child: Text(context.translate.lblAssignHandyman, style: boldTextStyle(color: white)),
                        color: primaryColor,
                        elevation: 0,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AssignHandymanDialog(
                                bookingId: widget.bookingData.id,
                                serviceAddressId: widget.bookingData.booking_address_id,
                                onUpdate: () {
                                  setState(() {});
                                  LiveStream().emit(LiveStreamUpdateBookings);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ).paddingAll(8),
              ],
            ).paddingAll(8),
          ),
        ],
      ), //booking card change
    ).onTap(() async {
      if (isUserTypeProvider) {
        BookingDetailScreen(bookingId: widget.bookingData.id).launch(context);
      } else {
        HBookingDetailScreen(bookingId: widget.bookingData.id).launch(context);
      }
    }, hoverColor: Colors.transparent, highlightColor: Colors.transparent, splashColor: Colors.transparent);
  }
}
