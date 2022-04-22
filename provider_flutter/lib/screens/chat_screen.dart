import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/components/back_widget.dart';
import 'package:handyman_provider_flutter/components/background_component.dart';
import 'package:handyman_provider_flutter/components/last_messege_chat.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/contact_model.dart';
import 'package:handyman_provider_flutter/models/user_data.dart';
import 'package:handyman_provider_flutter/screens/chatting_screen.dart';
import 'package:handyman_provider_flutter/utils/colors.dart';
import 'package:handyman_provider_flutter/utils/common.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/extensions/context_ext.dart';
import 'package:handyman_provider_flutter/widgets/app_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String id = '';
  UserData? currentFirebaseUser;

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      if (appStore.isLoggedIn) {
        setStatusBarColor(context.primaryColor);
      }
    });

    init();
  }

  init() async {
    currentFirebaseUser = await userService.getUser(email: appStore.userEmail.validate());
    setState(() {});
  }

  Widget _buildChatItemListView({required List<QueryDocumentSnapshot> docList}) {
    return ListView.separated(
      itemCount: docList.length,
      itemBuilder: (context, index) {
        ContactModel contact = ContactModel.fromJson(docList[index].data() as Map<String, dynamic>);
        return _buildChatItemWidget(contact: contact);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(indent: 80, height: 0);
      },
    );
  }

  StreamBuilder<UserData> _buildChatItemWidget({ContactModel? contact}) {
    return StreamBuilder(
      stream: chatMessageService.getUserDetailsById(id: contact!.uid.validate()),
      builder: (context, snap) {
        if (snap.hasData) {
          UserData data = snap.data!;

          return InkWell(
            onTap: () async {
              if (id != data.uid) {
                hideKeyboard(context);
                ChattingScreen(userData: data, currentFirebaseUser: currentFirebaseUser).launch(context);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Hero(
                    tag: data.uid.validate(),
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(10),
                      color: primaryColor,
                      child: Text(
                        data.displayName![0].validate().toUpperCase(),
                        style: secondaryTextStyle(color: Colors.white),
                      ).center().fit(),
                    ).cornerRadiusWithClipRRect(50),
                  ),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            data.displayName.validate(),
                            style: primaryTextStyle(size: 18),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ).expand(),
                          StreamBuilder<int>(
                            stream: chatMessageService.getUnReadCount(senderId: currentFirebaseUser!.uid.validate(), receiverId: data.uid!),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                if (snap.data != 0) {
                                  return Container(
                                    height: 18,
                                    width: 18,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: primaryColor),
                                    child: Text(
                                      snap.data.validate().toString(),
                                      style: secondaryTextStyle(size: 12, color: white),
                                    ).fit().center(),
                                  );
                                }
                              }
                              return Offstage();
                            },
                          ),
                        ],
                      ),
                      4.height,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LastMessageChat(
                            stream: chatMessageService.fetchLastMessageBetween(senderId: currentFirebaseUser!.uid.validate(), receiverId: contact.uid!),
                          ),
                        ],
                      ),
                    ],
                  ).expand(),
                ],
              ),
            ),
          );
        }
        return snapWidgetHelper(snap, errorWidget: Offstage(), loadingWidget: Offstage());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context.translate.lblChat,
        textColor: white,
        showBack: Navigator.canPop(context),
        elevation: 3.0,
        backWidget: BackWidget(),
        color: context.primaryColor,
      ),
      body: (currentFirebaseUser != null)
          ? StreamBuilder<QuerySnapshot>(
        stream: chatMessageService.fetchContacts(userId: currentFirebaseUser?.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error.toString(), style: boldTextStyle()).center();

          if (snapshot.hasData) {
            if (snapshot.data!.docs.length == 0) {
              return BackgroundComponent();
            }
            return _buildChatItemListView(docList: snapshot.data!.docs);
          }
          return snapWidgetHelper(snapshot, errorWidget: LoaderWidget());
        },
      )
          : LoaderWidget(),
    );
  }
}