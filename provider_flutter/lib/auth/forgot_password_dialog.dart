import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/networks/rest_apis.dart';
import 'package:handyman_provider_flutter/utils/colors.dart';
import 'package:handyman_provider_flutter/utils/common.dart';
import 'package:handyman_provider_flutter/utils/extensions/context_ext.dart';
import 'package:handyman_provider_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailCont = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  Future<void> forgotPwd() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map req = {UserKeys.email: emailCont.text.validate()};
      appStore.setLoading(true);

      forgotPassword(req).then((value) {
        appStore.setLoading(false);
        toast(value.message.toString());

        pop();
      }).catchError((e) {
        appStore.setLoading(false);
        if(e.toString() == "We can't find a user with that email address." )
        toast("No pudimos encontrar un usuario con este correo electronico", print: true);
        else
          toast(e.toString(), print: true);
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            decoration: boxDecorationDefault(
              color: context.scaffoldBackgroundColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: context.width(),
                    decoration: boxDecorationWithRoundedCorners(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                      backgroundColor: primaryColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child:
                        Row( children: [
                          Expanded(child: Text(context.translate.forgotPassword, style: boldTextStyle(color: white)).paddingOnly(left: 10),),
                          CloseButton(color: Colors.white),
                        ]),




                  ),
                  16.height,
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.bottomCenter,
                    decoration: boxDecorationRoundedWithShadow(defaultRadius.toInt(), blurRadius: 0, backgroundColor: context.scaffoldBackgroundColor),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.translate.forgotPasswordTitleTxt, style: primaryTextStyle(color: primaryColor).copyWith(height: 1.5)),
                          24.height,
                          AppTextField(

                            textFieldType: TextFieldType.EMAIL,
                            controller: emailCont,
                            autoFocus: true,
                            validator: (s) {
                              if (s!.isEmpty)
                                return context.translate.lblRequired;
                              else
                                return null;
                            },
                            errorThisFieldRequired: context.translate.hintRequired,
                            decoration: inputDecoration(context, hint: context.translate.hintEmail, fillColor: context.cardColor),
                            onFieldSubmitted: (s) {
                              forgotPwd();
                            },
                          ),
                          24.height,
                          AppButton(
                            text: context.translate.resetPassword,
                            color: primaryColor,
                            textStyle: primaryTextStyle(color: white),
                            width: context.width() - context.navigationBarHeight,
                            onTap: () {
                              forgotPwd();
                            },
                          ),
                          8.height,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
