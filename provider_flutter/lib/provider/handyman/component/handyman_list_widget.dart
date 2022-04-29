import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/components/register_user_form_component.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/user_list_response.dart';
import 'package:handyman_provider_flutter/networks/rest_apis.dart';
import 'package:handyman_provider_flutter/utils/common.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/extensions/context_ext.dart';
import 'package:handyman_provider_flutter/utils/extensions/string_extension.dart';
import 'package:handyman_provider_flutter/utils/images.dart';
import 'package:handyman_provider_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class HandymanListWidget extends StatefulWidget {
  final UserListData data;
  final Function? onUpdate;

  HandymanListWidget({required this.data, this.onUpdate});

  @override
  State<HandymanListWidget> createState() => _HandymanListWidgetState();
}

class _HandymanListWidgetState extends State<HandymanListWidget> {
  //
  Future<void> changeStatus(int status) async {
    appStore.setLoading(true);
    Map request = {CommonKeys.id: widget.data.id, UserKeys.status: status};

    await updateHandymanStatus(request).then((value) {
      appStore.setLoading(false);
      toast(value.message.toString(), print: true);
      setState(() {});
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
      widget.data.isActive = !widget.data.isActive;
    });
  }

  Color getStatusBackgroundColor(bool status) {
    if (status) {
      return context.primaryColor;
    } else {
      return context.scaffoldBackgroundColor;
    }
  }

  Color getStatusTextColor(bool status) {
    if (status) {
      return Colors.white;
    } else {
      return context.primaryColor;
    }
  }

  Future<void> removeHandyman(int? id) async {
    appStore.setLoading(true);
    await deleteHandyman(id.validate()).then((value) {
      appStore.setLoading(false);
      widget.onUpdate?.call();

      toast(context.translate.lblTrashHandyman, print: true);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }

  Future<void> restoreHandymanData() async {
    appStore.setLoading(true);
    var req = {
      CommonKeys.id: widget.data.id,
      type: RESTORE,
    };

    await restoreHandyman(req).then((value) {
      appStore.setLoading(false);
      toast(value.message);
      widget.onUpdate?.call();
      setState(() {});
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }

  Future<void> forceDeleteHandymanData() async {
    appStore.setLoading(true);
    var req = {
      CommonKeys.id: widget.data.id,
      type: FORCE_DELETE,
    };

    await restoreHandyman(req).then((value) {
      appStore.setLoading(false);
      widget.onUpdate?.call();
      toast(value.message);
      setState(() {});
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.height,
              circleImage(image: widget.data.profileImage!.isNotEmpty ? widget.data.profileImage.validate() : '', size: 80),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.data.displayName.validate(),
                        style: boldTextStyle(size: 18),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ).expand(),
                      PopupMenuButton(
                        icon: Icon(Icons.more_horiz, size: 24),
                        onSelected: (selection) async {
                          if (selection == 1) {
                            bool? res = await RegisterUserFormComponent(
                              user_type: UserTypeHandyman,
                              data: UserListData(
                                id: widget.data.id,
                                firstName: widget.data.firstName,
                                lastName: widget.data.lastName,
                                username: widget.data.username,
                                providerId: widget.data.providerId,
                                status: widget.data.status,
                                description: widget.data.description,
                                userType: widget.data.userType,
                                email: widget.data.email,
                                contactNumber: widget.data.contactNumber,
                                countryId: widget.data.countryId,
                                stateId: widget.data.stateId,
                                cityId: widget.data.cityId,
                                cityName: widget.data.cityName,
                                address: widget.data.address,
                                providertypeId: widget.data.providertypeId,
                                providertype: widget.data.providertype,
                                isFeatured: widget.data.isFeatured,
                                displayName: widget.data.displayName,
                                createdAt: widget.data.createdAt,
                                updatedAt: widget.data.updatedAt,
                                profileImage: widget.data.profileImage,
                                timeZone: widget.data.timeZone,
                                lastNotificationSeen: widget.data.lastNotificationSeen,
                                serviceAddressId: widget.data.serviceAddressId,
                              ),
                              isUpdate: true,
                            ).launch(context, pageRouteAnimation: PageRouteAnimation.Slide);

                            if (res ?? false) widget.onUpdate?.call();
                          } else if (selection == 2) {
                            showConfirmDialogCustom(
                              context,
                              dialogType: DialogType.DELETE,
                              onAccept: (_) {
                                if (getStringAsync(USER_EMAIL) != DEFAULT_PROVIDER_EMAIL) {
                                  removeHandyman(widget.data.id.validate());
                                } else {
                                  toast(context.translate.lblUnAuthorized);
                                }
                              },
                            );
                          } else if (selection == 3) {
                            showConfirmDialogCustom(
                              context,
                              dialogType: DialogType.DELETE,
                              onAccept: (_) {
                                if (getStringAsync(USER_EMAIL) != DEFAULT_PROVIDER_EMAIL) {
                                  restoreHandymanData();
                                } else {
                                  toast(context.translate.lblUnAuthorized);
                                }
                              },
                            );
                          } else if (selection == 4) {
                            showConfirmDialogCustom(
                              context,
                              dialogType: DialogType.DELETE,
                              onAccept: (_) {
                                if (getStringAsync(USER_EMAIL) != DEFAULT_PROVIDER_EMAIL) {
                                  forceDeleteHandymanData();
                                } else {
                                  toast(context.translate.lblUnAuthorized);
                                }
                              },
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text(context.translate.lblEdit, style: boldTextStyle()),
                            value: 1,
                          ),
                          if (widget.data.deletedAt.validate().isEmpty)
                            PopupMenuItem(
                              child: Text(context.translate.lblDelete, style: boldTextStyle()),
                              value: 2,
                            ),
                          if (widget.data.deletedAt != null)
                            PopupMenuItem(
                              child: Text(context.translate.lblRestore, style: boldTextStyle()),
                              value: 3,
                            ),
                          if (widget.data.deletedAt != null)
                            PopupMenuItem(
                              child: Text(context.translate.lblForceDelete, style: boldTextStyle()),
                              value: 4,
                            ),
                        ],
                      ),
                    ],
                  ),
                  4.height,
                  if (widget.data.email.validate().isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ic_message.iconImage(color: context.iconColor, size: 20),
                            8.width,
                            Text(
                              '${widget.data.email.validate()}',
                              style: primaryTextStyle(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ).flexible()
                          ],
                        ).onTap(() {
                          launchUri('mailto:' + widget.data.email.validate());
                        }),
                        12.height,
                      ],
                    ),
                  if (widget.data.address.validate().isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            servicesAddress.iconImage(color: context.iconColor, size: 20),
                            8.width,
                            Text(
                              '${widget.data.address.validate()}',
                              style: primaryTextStyle(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ).flexible()
                          ],
                        ).onTap(() {
                          launchMap(widget.data.address.validate());
                        }),
                        12.height,
                      ],
                    ),
                  if (widget.data.contactNumber.validate().isNotEmpty)
                    Row(
                      children: [
                        calling.iconImage(color: context.iconColor, size: 20),
                        8.width,
                        Text(
                          '${widget.data.contactNumber.validate()}',
                          style: primaryTextStyle(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ).flexible()
                      ],
                    ).onTap(() {
                      launchUri(TEL + widget.data.contactNumber.validate());
                    }),
                ],
              ).expand(),
            ],
          ),
          28.height,
          Row(
            children: [
              AppButton(
                child: Text(
                  widget.data.isActive.validate() ? context.translate.lblActivated : context.translate.lblActivate,
                  style: boldTextStyle(color: getStatusTextColor(widget.data.isActive.validate())),
                ),
                width: context.width(),
                color: getStatusBackgroundColor(widget.data.isActive.validate()),
                elevation: 0,
                onTap: () {
                  if (getStringAsync(USER_EMAIL) != DEFAULT_PROVIDER_EMAIL) {
                    changeStatus(1);
                    widget.data.isActive = true;
                  } else {
                    toast(context.translate.lblUnAuthorized);
                  }
                },
              ).expand(),
              16.width,
              AppButton(
                child: Text(
                  !widget.data.isActive.validate() ? context.translate.lblDeactivated : context.translate.lblDeactivate,
                  style: boldTextStyle(color: getStatusTextColor(!widget.data.isActive.validate())),
                ),
                width: context.width(),
                elevation: 0,
                color: getStatusBackgroundColor(!widget.data.isActive.validate()),
                onTap: () {
                  if (getStringAsync(USER_EMAIL) != DEFAULT_PROVIDER_EMAIL) {
                    changeStatus(0);
                    widget.data.isActive = false;
                  } else {
                    toast(context.translate.lblUnAuthorized);
                  }
                },
              ).expand(),
            ],
          )
        ],
      ),
    );
  }
}
