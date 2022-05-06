import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:handyman_provider_flutter/components/back_widget.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/provider_subscription_model.dart';
import 'package:handyman_provider_flutter/networks/rest_apis.dart';
import 'package:handyman_provider_flutter/provider/dashboard/dashboard_screen.dart';
import 'package:handyman_provider_flutter/provider/payment/PaymentScreen.dart';
import 'package:handyman_provider_flutter/utils/colors.dart';
import 'package:handyman_provider_flutter/utils/common.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/extensions/context_ext.dart';
import 'package:handyman_provider_flutter/utils/model_keys.dart';
import 'package:handyman_provider_flutter/widgets/app_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class PricingPlanScreen extends StatefulWidget {
  const PricingPlanScreen({Key? key}) : super(key: key);

  @override
  _PricingPlanScreenState createState() => _PricingPlanScreenState();
}

class _PricingPlanScreenState extends State<PricingPlanScreen> {
  List<ProviderSubscriptionModel> pricingPlanList = [];

  ProviderSubscriptionModel? selectedPricingPlan;

  int currentSelectedPlan = -1;

  bool hasError = false;

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      init();
    });
  }

  void init() async {
    appStore.setLoading(true);

    await getPricingPlanList().then((value) {
      appStore.setLoading(false);
      hasError = false;

      pricingPlanList.addAll(value.data!);

      setState(() {});
    }).catchError((e) {
      appStore.setLoading(false);
      hasError = true;
      toast(e.toString(), print: true);
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context.translate.lblPricingPlan, backWidget: BackWidget(), elevation: 0, color: primaryColor, textColor: Colors.white),
      body: Stack(
        children: [
          Column(
            children: [
              42.height,
              Text(context.translate.lblSelectPlan, style: boldTextStyle(size: 18)),
              24.height,
              ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(8),
                itemCount: pricingPlanList.length,
                itemBuilder: (_, index) {
                  ProviderSubscriptionModel data = pricingPlanList[index];

                  return AnimatedContainer(
                    duration: 500.milliseconds,
                    decoration: boxDecorationWithRoundedCorners(
                      borderRadius: radius(),
                      backgroundColor: context.scaffoldBackgroundColor,
                      border: Border.all(color: currentSelectedPlan == index ? primaryColor : context.dividerColor, width: 1.5),
                    ),
                    margin: EdgeInsets.all(8),
                    width: context.width(),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            currentSelectedPlan == index
                                ? AnimatedContainer(
                                    duration: 500.milliseconds,
                                    decoration: BoxDecoration(
                                      color: context.primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    padding: EdgeInsets.all(2),
                                    child: Icon(Icons.check, color: Colors.white, size: 16),
                                  )
                                : AnimatedContainer(
                                    duration: 500.milliseconds,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey.shade300),
                                    ),
                                    padding: EdgeInsets.all(2),
                                    child: Icon(Icons.check, color: Colors.transparent, size: 16),
                                  ),
                            16.width,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('${data.identifier.capitalizeFirstLetter()}', style: boldTextStyle()),
                                    if (data.trialPeriod.validate() != 0 && data.identifier == FREE)
                                      RichText(
                                        text: TextSpan(
                                          text: ' (Trial for ',
                                          style: secondaryTextStyle(),
                                          children: <TextSpan>[
                                            TextSpan(text: '${data.trialPeriod.validate()}', style: boldTextStyle()),
                                            TextSpan(text: '  day(s))', style: secondaryTextStyle()),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                8.height,
                                Text(data.title.validate().capitalizeFirstLetter(), style: secondaryTextStyle()),
                              ],
                            ),
                          ],
                        ).flexible(),
                        Container(
                          decoration: BoxDecoration(color: context.primaryColor, borderRadius: radius()),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Text(
                            data.identifier == FREE
                                ? 'Free Trial'
                                : "${appStore.currencySymbol}${data.amount.validate().toStringAsFixed(decimalPoint).formatNumberWithComma()}/${data.type.validate()}",
                            style: boldTextStyle(color: white, size: 12),
                          ),
                        ),
                      ],
                    ).onTap(() {
                      selectedPricingPlan = data;
                      currentSelectedPlan = index;

                      setState(() {});
                    }),
                  );
                },
              ),
            ],
          ),
          if (selectedPricingPlan != null)
            Positioned(
              bottom: 32,
              left: 16,
              right: 16,
              child: AppButton(
                child: Text(selectedPricingPlan!.identifier == FREE ? context.translate.lblProceed.toUpperCase() : context.translate.lblMakePayment.toUpperCase(), style: boldTextStyle(color: white)),
                color: primaryColor,
                onTap: () async {
                  if (selectedPricingPlan!.identifier == FREE) {
                    Map req = {
                      Subscription.planId: selectedPricingPlan!.id.validate(),
                      Subscription.title: selectedPricingPlan!.title.validate(),
                      Subscription.identifier: selectedPricingPlan!.identifier.validate(),
                      Subscription.amount: selectedPricingPlan!.amount.validate(),
                      Subscription.type: selectedPricingPlan!.type.validate(),
                      Subscription.paymentType: '',
                      Subscription.paymentStatus: 'paid',
                    };

                    log('Request : $req');
                    appStore.setLoading(true);

                    await saveSubscription(req).then((value) {
                      appStore.setLoading(false);
                      toast("${selectedPricingPlan!.title.validate()} is successFully activated");

                      push(DashboardScreen(index: 0), isNewTask: true);
                    }).catchError((e) {
                      appStore.setLoading(false);
                      log(e.toString());
                    });
                  } else {
                    PaymentScreen(selectedPricingPlan!).launch(context);
                  }
                },
              ),
            ),
          Observer(builder: (_) => noDataFound(context).center().visible(!appStore.isLoading && pricingPlanList.isEmpty && !hasError)),
          Text(context.translate.lblWrongErr, style: secondaryTextStyle()).center().visible(hasError),
          Observer(builder: (_) => LoaderWidget().center().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
