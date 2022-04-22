import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:handyman_provider_flutter/auth/sign_in_screen.dart';
import 'package:handyman_provider_flutter/components/back_widget.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/networks/rest_apis.dart';
import 'package:handyman_provider_flutter/utils/colors.dart';
import 'package:handyman_provider_flutter/utils/common.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/extensions/context_ext.dart';
import 'package:handyman_provider_flutter/utils/extensions/string_extension.dart';
import 'package:handyman_provider_flutter/utils/images.dart';
import 'package:handyman_provider_flutter/widgets/app_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/model_keys.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController userNameCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController cPasswordCont = TextEditingController();

  FocusNode fNameFocus = FocusNode();
  FocusNode lNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode cPasswordFocus = FocusNode();

  String selectedUserTypeValue = UserTypeProvider;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    afterBuildCreated(() {
      setStatusBarColor(appStore.isDarkMode ? scaffoldColorDark : white);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);
      appStore.setLoading(true);

      var request = {
        UserKeys.firstName: fNameCont.text.trim(),
        UserKeys.lastName: lNameCont.text.trim(),
        UserKeys.userName: userNameCont.text.trim(),
        UserKeys.userType: selectedUserTypeValue,
        UserKeys.contactNumber: mobileCont.text.trim(),
        UserKeys.email: emailCont.text.trim(),
        UserKeys.password: DEFAULT_PASS,
      };

      await registerUser(request).then((value) async {
        value.data!.password = passwordCont.text.trim();
        value.data!.user_type = UserTypeProvider;
        // After successful entry in the mysql database it will login into firebase.
        await authService.signUpWithEmailPassword(context, registerData: value.data!).then((value) {
          //
        }).catchError((e) {
          if (e.toString() == USER_CANNOT_LOGIN) {
            toast("Please Login Again");
            SignInScreen().launch(context, isNewTask: true);
          } else if (e.toString() == USER_NOT_CREATED) {
            toast("Please Login Again");
            SignInScreen().launch(context, isNewTask: true);
          }
        });

        appStore.setLoading(false);
      }).catchError((e) {
        log(e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        "",
        elevation: 0,
        color: context.scaffoldBackgroundColor,
        backWidget: BackWidget(color: context.iconColor),
        systemUiOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.dark,
          statusBarColor: context.scaffoldBackgroundColor,
        ),
      ),
      body: SizedBox(
        width: context.width(),
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    16.height,
                    Container(
                      width: 85,
                      height: 85,
                      decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, backgroundColor: primaryColor),
                      child: Image.asset(profile, height: 45, width: 45, color: white).center(),
                    ),
                    16.height,
                    Text(context.translate.lblsignuptitle, style: boldTextStyle(size: 22)).center(),
                    16.height,
                    Text(
                      context.translate.lblsignupsubtitle,
                      style: secondaryTextStyle(size: 16),
                      textAlign: TextAlign.center,
                    ).center().paddingSymmetric(horizontal: 32),
                    32.height,
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: fNameCont,
                      focus: fNameFocus,
                      nextFocus: lNameFocus,
                      errorThisFieldRequired: context.translate.hintRequired,
                      decoration: inputDecoration(context, hint: context.translate.hintFirstNm),
                      suffix: profile.iconImage(size: 10).paddingAll(14),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: lNameCont,
                      focus: lNameFocus,
                      nextFocus: userNameFocus,
                      errorThisFieldRequired: context.translate.hintRequired,
                      decoration: inputDecoration(context, hint: context.translate.hintLastNm),
                      suffix: profile.iconImage(size: 10).paddingAll(14),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.USERNAME,
                      controller: userNameCont,
                      focus: userNameFocus,
                      nextFocus: emailFocus,
                      errorThisFieldRequired: context.translate.hintRequired,
                      decoration: inputDecoration(context, hint: context.translate.hintUserNm),
                      suffix: profile.iconImage(size: 10).paddingAll(14),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.EMAIL,
                      controller: emailCont,
                      focus: emailFocus,
                      nextFocus: mobileFocus,
                      errorThisFieldRequired: context.translate.hintRequired,
                      decoration: inputDecoration(context, hint: context.translate.hintEmailAddress),
                      suffix: ic_message.iconImage(size: 10).paddingAll(14),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      controller: mobileCont,
                      focus: mobileFocus,
                      nextFocus: passwordFocus,
                      errorThisFieldRequired: context.translate.hintRequired,
                      decoration: inputDecoration(context, hint: context.translate.hintContactNumber),
                      suffix: calling.iconImage(size: 10).paddingAll(14),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.PASSWORD,
                      controller: passwordCont,
                      focus: passwordFocus,
                      errorThisFieldRequired: context.translate.hintRequired,
                      decoration: inputDecoration(context, hint: context.translate.hintPassword),
                      onFieldSubmitted: (s) {
                        register();
                      },
                    ),
                    16.height,
                    DropdownButtonFormField<String>(
                      items: [
                        DropdownMenuItem(
                          child: Text(context.translate.provider, style: primaryTextStyle()),
                          value: UserTypeProvider,
                        ),
                        DropdownMenuItem(
                          child: Text(context.translate.handyman, style: primaryTextStyle()),
                          value: UserTypeHandyman,
                        ),
                      ],
                      decoration: inputDecoration(context, hint: context.translate.lblUserType),
                      value: selectedUserTypeValue,
                      onChanged: (c) {
                        hideKeyboard(context);
                        selectedUserTypeValue = c.validate();
                        setState(() {});
                      },
                    ),
                    32.height,
                    AppButton(
                      text: context.translate.lblsignup,
                      height: 40,
                      color: primaryColor,
                      textStyle: primaryTextStyle(color: white),
                      width: context.width() - context.navigationBarHeight,
                      onTap: () {
                        register();
                      },
                    ),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${context.translate.alreadyHaveAccountTxt}?", style: secondaryTextStyle()),
                        TextButton(
                          onPressed: () {
                            finish(context);
                          },
                          child: Text(
                            context.translate.signIn,
                            style: boldTextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Observer(
              builder: (context) => LoaderWidget().center().visible(appStore.isLoading),
            )
          ],
        ),
      ),
    );
  }
}
