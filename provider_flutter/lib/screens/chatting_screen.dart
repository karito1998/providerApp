import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/chat_services/chat_messages_service.dart';
import 'package:handyman_provider_flutter/components/back_widget.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/chat_message_model.dart';
import 'package:handyman_provider_flutter/models/file_model.dart';
import 'package:handyman_provider_flutter/models/user_data.dart';
import 'package:handyman_provider_flutter/utils/colors.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/extensions/context_ext.dart';
import 'package:handyman_provider_flutter/widgets/chat_item_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ChattingScreen extends StatefulWidget {
  final UserData? userData;

  final UserData? currentFirebaseUser;

  ChattingScreen({this.userData, this.currentFirebaseUser});

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  String id = '';
  var messageCont = TextEditingController();
  var messageFocus = FocusNode();
  bool isMe = false;
  late UserData sender = UserData();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    id = widget.currentFirebaseUser!.uid.validate();
    mIsEnterKey = getBoolAsync(IS_ENTER_KEY, defaultValue: false);
    mSelectedImage = getStringAsync(SELECTED_WALLPAPER, defaultValue: "assets/default_wallpaper.png");
    sender = UserData(
      displayName: widget.currentFirebaseUser!.displayName.validate(),
      profileImage: widget.currentFirebaseUser!.profileImage.validate(),
      uid: widget.currentFirebaseUser!.uid.validate(),
      playerId: getStringAsync(PLAYERID),
    );
   // chatMessageService = ChatMessageService();
    chatMessageService.setUnReadStatusToTrue(senderId: sender.uid.validate(), receiverId: widget.userData!.uid!);
    setState(() {});
  }

  sendMessage({FilePickerResult? result}) async {
    if (result == null) {
      if (messageCont.text.trim().isEmpty) {
        messageFocus.requestFocus();
        return;
      }
    }
    ChatMessageModel data = ChatMessageModel();
    data.receiverId = widget.userData!.uid;
    data.senderId = sender.uid;
    data.message = messageCont.text;
    data.isMessageRead = false;
    data.createdAt = DateTime.now().millisecondsSinceEpoch;

    if (result != null) {
      if (result.files.single.path.isImage) {
        data.messageType = MessageType.IMAGE.name;
      } else {
        data.messageType = MessageType.TEXT.name;
      }
    } else {
      data.messageType = MessageType.TEXT.name;
    }

    notificationService.sendPushNotifications(getStringAsync(DISPLAY_NAME), messageCont.text, receiverPlayerId: widget.userData!.playerId).catchError(log);
    messageCont.clear();
    setState(() {});
   /* return await chatMessageService.addMessage(data).then((value) async {
      if (result != null) {
        FileModel fileModel = FileModel();
        fileModel.id = value.id;
        fileModel.file = File(result.files.single.path!);
        fileList.add(fileModel);

        setState(() {});
      }

      await chatMessageService.addMessageToDb(value, data, sender, widget.userData, image: result != null ? File(result.files.single.path!) : null).then((value) {

      });

      userService.fireStore
          .collection(USER_COLLECTION)
          .doc(getIntAsync(USER_ID).toString())
          .collection(CONTACT_COLLECTION)
          .doc(widget.userData!.uid)
          .update({'lastMessageTime': DateTime.now().millisecondsSinceEpoch}).catchError((e) {});
      userService.fireStore
          .collection(USER_COLLECTION)
          .doc(widget.userData!.uid)
          .collection(CONTACT_COLLECTION)
          .doc(getIntAsync(USER_ID).toString())
          .update({'lastMessageTime': DateTime.now().millisecondsSinceEpoch}).catchError((e) {
        log(e);
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        "",
        color: context.primaryColor,
        backWidget: BackWidget(),
        titleWidget: Text(widget.userData!.displayName.validate(), style: TextStyle(color: whiteColor)),
      ),
      body: Container(
        height: context.height(),
        width: context.width(),
        child: Stack(
          children: [
            Container(
              height: context.height(),
              width: context.width(),
              child: PaginateFirestore(
                reverse: true,
                isLive: true,
                padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 0),
                physics: BouncingScrollPhysics(),
                query: chatMessageService.chatMessagesWithPagination(
                  //currentUserId: widget.currentFirebaseUser!.uid.validate(),
                  receiverUserId: widget.userData!.uid.validate(),
                ),
                itemsPerPage: PER_PAGE_CHAT_COUNT,
                shrinkWrap: true,
                itemBuilderType: PaginateBuilderType.listView,
                itemBuilder: (context, snap, index) {
                  ChatMessageModel data = ChatMessageModel.fromJson(snap[index].data() as Map<String, dynamic>);
                  data.isMe = data.senderId == sender.uid;
                  return ChatItemWidget(data: data);
                },
              ).paddingBottom(76),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                decoration: boxDecorationWithShadow(
                  borderRadius: radius(30),
                  spreadRadius: 1,
                  blurRadius: 1,
                  backgroundColor: context.cardColor,
                ),
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    TextField(
                      controller: messageCont,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: context.translate.lblWriteMsg,
                        hintStyle: primaryTextStyle(),
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                      ),
                      cursorColor: appStore.isDarkMode ? Colors.white : Colors.black,
                      focusNode: messageFocus,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      style: primaryTextStyle(),
                      textInputAction: mIsEnterKey ? TextInputAction.send : TextInputAction.newline,
                      onSubmitted: (s) {
                        sendMessage();
                      },
                      cursorHeight: 20,
                      maxLines: 5,
                    ).expand(),
                    IconButton(
                      icon: Icon(Icons.send, color: primaryColor),
                      onPressed: () {
                        sendMessage();
                      },
                    )
                  ],
                ),
                width: context.width(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
