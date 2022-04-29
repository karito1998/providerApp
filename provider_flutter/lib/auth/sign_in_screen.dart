import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:handyman_provider_flutter/auth/forgot_password_dialog.dart';
import 'package:handyman_provider_flutter/auth/sign_up_screen.dart';
import 'package:handyman_provider_flutter/components/selected_item_widget.dart';
import 'package:handyman_provider_flutter/handyman/screen/dashboard/handyman_dashboard_screen.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/networks/network_utils.dart';
import 'package:handyman_provider_flutter/networks/rest_apis.dart';
import 'package:handyman_provider_flutter/provider/dashboard/dashboard_screen.dart';
import 'package:handyman_provider_flutter/utils/colors.dart';
import 'package:handyman_provider_flutter/utils/common.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/extensions/context_ext.dart';
import 'package:handyman_provider_flutter/utils/extensions/string_extension.dart';
import 'package:handyman_provider_flutter/utils/images.dart';
import 'package:handyman_provider_flutter/utils/model_keys.dart';
import 'package:handyman_provider_flutter/widgets/app_widgets.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailCont = TextEditingController(text: kReleaseMode ? '' : '');
  TextEditingController passwordCont = TextEditingController(text: kReleaseMode ? '' : '');

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool isRemember = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    isRemember = getBoolAsync(IS_REMEMBERED);
    if (isRemember) {
      emailCont.text = getStringAsync(USER_EMAIL);
      passwordCont.text = getStringAsync(USER_PASSWORD);
    }
    afterBuildCreated(() {
      setStatusBarColor(appStore.isDarkMode ? scaffoldColorDark : white);
    });
  }

  @override
  void dispose() {
    super.dispose();
    setStatusBarColor(appStore.isDarkMode ? scaffoldColorDark : white);
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);
      //
      var request = {
        UserKeys.email: emailCont.text,
        UserKeys.password: passwordCont.text,
        UserKeys.playerId: getStringAsync(PLAYERID),
      };

      if (isRemember) {
        await setValue(USER_EMAIL, emailCont.text);
        await setValue(USER_PASSWORD, passwordCont.text);
        await setValue(IS_REMEMBERED, isRemember);
      }

      appStore.setLoading(true);
      await loginUser(request).then((res) async {
        if (res.data!.uid.validate().isNotEmpty) {
          authService.signInWithEmailPassword(context, email: emailCont.text, password: passwordCont.text).then((value) {
            if (res.data!.email == DEFAULT_PROVIDER_EMAIL || res.data!.email == DEFAULT_HANDYMAN_EMAIL) {
              appStore.setTester(true);
            }
            if (res.data!.status.validate() != 0) {
              appStore.setLoading(false);
              if (res.data!.userType == UserTypeProvider) {
                toast(context.translate.loginSuccessfully);
                DashboardScreen(index: 0).launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
              } else if (res.data!.userType == UserTypeHandyman) {
                toast(context.translate.loginSuccessfully);
                HandyDashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
              } else {
                toast(context.translate.cantLogin, print: true);
              }
            } else {
              toast(context.translate.lblWaitForAcceptReq);
            }
          });
        } else {
          ///TODO : Register...
          authService.signInWithEmailPassword(context, email: emailCont.text, password: passwordCont.text).then((value) async {
            if (res.data!.status.validate() != 0) {
              MultipartRequest multiPartRequest = await getMultiPartRequest('update-profile');
              multiPartRequest.fields[UserKeys.uid] = getStringAsync(UID);

              multiPartRequest.headers.addAll(buildHeaderTokens());
              appStore.setLoading(true);
              sendMultiPartRequest(
                multiPartRequest,
                onSuccess: (data) async {
                  appStore.setLoading(false);
                  if (data != null) {
                    if (res.data!.status.validate() != 0) {
                      if (res.data!.email == DEFAULT_PROVIDER_EMAIL || res.data!.email == DEFAULT_HANDYMAN_EMAIL) {
                        appStore.setTester(true);
                      }

                      if (res.data!.userType == UserTypeProvider) {
                        toast(context.translate.loginSuccessfully);
                        saveUserData(res.data!);

                        DashboardScreen(index: 0).launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
                      } else if (res.data!.userType == UserTypeHandyman) {
                        toast(context.translate.loginSuccessfully);
                        saveUserData(res.data!);

                        HandyDashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
                      } else {
                        toast(context.translate.cantLogin, print: true);
                      }
                      finish(context);
                    }
                  }
                },
                onError: (error) {
                  toast(error.toString(), print: true);
                  appStore.setLoading(false);
                },
              );
            } else {
              appStore.setLoading(false);
              toast(context.translate.lblWaitForAcceptReq);
            }
          });
        }
      }).catchError((e) {
        if(e.toString() == "These credentials do not match our records." )
          toast("No pudimos encontrar un usuario con estas credenciales", print: true);
        else
        toast(e.toString(), print: true);
        appStore.setLoading(false);
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        "",
        elevation: 0,
        showBack: false,
        color: context.scaffoldBackgroundColor,
        systemUiOverlayStyle:
            SystemUiOverlayStyle(statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.dark, statusBarColor: context.scaffoldBackgroundColor),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset(
                      //"images/app_images/logo.svg",
                      "images/setting_icon/ic_splash_logo.png",
                      height: 100.0,
                      alignment: Alignment.center,
                    )),
                    16.height,
                    Text(context.translate.lbllogintitle, style: boldTextStyle(size: 22)).center(),
                    16.height,
                    Text(
                      context.translate.lblloginsubtitle,
                      style: secondaryTextStyle(size: 16),
                      textAlign: TextAlign.center,
                    ).center().paddingSymmetric(horizontal: 32),
                    64.height,
                    AppTextField(
                      textFieldType: TextFieldType.EMAIL,
                      controller: emailCont,
                      focus: emailFocus,
                      nextFocus: passwordFocus,
                      errorThisFieldRequired: context.translate.hintRequired,
                      errorInvalidEmail: context.translate.lblInvalidEmail,
                      decoration: inputDecoration(context, hint: context.translate.hintEmailAddress),

                      autoFillHints: [AutofillHints.email],
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.PASSWORD,
                      controller: passwordCont,
                      focus: passwordFocus,
                      errorThisFieldRequired: context.translate.hintRequired,
                      errorMinimumPasswordLength: "${context.translate.errorPasswordLength} $passwordLengthGlobal caracteres",
                      decoration: inputDecoration(context, hint: context.translate.hintPassword),
                      autoFillHints: [AutofillHints.password],
                      onFieldSubmitted: (s) {
                        login();
                      },
                    ),
                    8.height,

                        Row(
                          children: [
                            2.width,
                            SelectedItemWidget(isSelected: isRemember).onTap(() async {
                              await setValue(IS_REMEMBERED, isRemember);
                              isRemember = !isRemember;
                              setState(() {});
                            }),
                            TextButton(
                              onPressed: () async {
                                await setValue(IS_REMEMBERED, isRemember);
                                isRemember = !isRemember;
                                setState(() {});
                              },
                              child: Text(context.translate.rememberMe, style: secondaryTextStyle()),
                            ),
                          ],
                        ),
                    Row(
                      children: [
                        Expanded(child:SizedBox(height: 1,)),
                        TextButton(
                          child: Text(
                            context.translate.forgotPassword,
                            style: boldTextStyle(color: primaryColor, fontStyle: FontStyle.italic),
                          ),
                          onPressed: () {
                            showInDialog(
                              context,
                              contentPadding: EdgeInsets.zero,
                              dialogAnimation: DialogAnimation.SLIDE_TOP_BOTTOM,
                              builder: (_) => ForgotPasswordScreen(),
                            );
                          },
                        )
                      ],
                    ),
                    32.height,
                    AppButton(
                      text: context.translate.lblLogin,
                      height: 40,
                      color: primaryColor,
                      textStyle: primaryTextStyle(color: white),
                      width: context.width() - context.navigationBarHeight,
                      onTap: () {
                        login();
                      },
                    ),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.translate.doNotHaveAccount, style: secondaryTextStyle()),
                        TextButton(
                          onPressed: () {
                            SignUpScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                          },
                          child: Text(
                            context.translate.signUp,
                            style: boldTextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      ],
                    ),
                    16.height,
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      children: [
                      /*
                        OutlinedButton(
                          onPressed: () {
                            emailCont.text = DEFAULT_PROVIDER_EMAIL;
                            passwordCont.text = DEFAULT_PASS;
                          },
                          child: Text("Demo Provider", style: boldTextStyle(color: primaryColor, size: 14)),
                        ).withWidth(context.width() / 2 - 24),
                        OutlinedButton(
                          onPressed: () {
                            emailCont.text = DEFAULT_HANDYMAN_EMAIL;
                            passwordCont.text = DEFAULT_PASS;
                          },
                          child: Text("Demo Handyman", style: boldTextStyle(color: primaryColor, size: 14)),
                        ).withWidth(context.width() / 2 - 24),*/
                        Center (child:TextButton(
                          child: Text("Reset", style: secondaryTextStyle()),
                          onPressed: () {
                            emailCont.clear();
                            passwordCont.clear();
                          },
                        ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Observer(
              builder: (_) => LoaderWidget().center().visible(appStore.isLoading),
            ),
          ],
        ),
      ),
    );
  }
}
