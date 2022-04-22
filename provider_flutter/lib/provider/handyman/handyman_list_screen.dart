import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:handyman_provider_flutter/components/register_user_form_component.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/dashboard_response.dart';
import 'package:handyman_provider_flutter/models/user_list_response.dart';
import 'package:handyman_provider_flutter/networks/rest_apis.dart';
import 'package:handyman_provider_flutter/provider/dashboard/widgets/handyman_widget.dart';
import 'package:handyman_provider_flutter/utils/colors.dart';
import 'package:handyman_provider_flutter/utils/common.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:handyman_provider_flutter/utils/extensions/context_ext.dart';
import 'package:handyman_provider_flutter/widgets/app_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class HandymanListScreen extends StatefulWidget {
  final List<Handyman>? list;

  HandymanListScreen({this.list});

  @override
  HandymanListScreenState createState() => HandymanListScreenState();
}

class HandymanListScreenState extends State<HandymanListScreen> {
  ScrollController scrollController = ScrollController();
  List<UserListData> userData = [];
  bool afterInit = false;

  int totalPage = 0;
  int currentPage = 1;
  int totalItems = 0;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();

    afterBuildCreated(() {
      setStatusBarColor(context.primaryColor);
      appStore.setLoading(true);
      init();
    });
  }

  Future<void> init() async {
    scrollController.addListener(() {
      scrollHandler();
    });
    getHandymanList();
  }

  scrollHandler() {
    if (currentPage <= totalPage) {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !appStore.isLoading) {
        currentPage++;
        appStore.setLoading(true);
        getHandymanList();
      }
    }
  }

  Future<void> getHandymanList() async {
    appStore.setLoading(true);
    await getHandyman(page: currentPage, isPagination: true, providerId: appStore.userId).then((value) {
      totalItems = value.pagination!.totalItems;
      if (!mounted) return;
      if (currentPage == 1) {
        userData.clear();
      }
      if (totalItems != 0) {
        userData.addAll(value.data!);
        print(value);
        totalPage = value.pagination!.totalPages!;
        currentPage = value.pagination!.currentPage!;
      }
      afterInit = true;
      setState(() {});
      appStore.setLoading(false);
    }).catchError((e) {
      if (!mounted) return;
      toast(e.toString(), print: true);
      appStore.setLoading(false);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          currentPage = 1;
          getHandymanList();
          await 2.seconds.delay;
        },
        child: Scaffold(
          backgroundColor: appStore.isDarkMode ? blackColor : cardColor,
          appBar: appBarWidget(
            context.translate.lblAllHandyman,
            textColor: white,
            color: context.primaryColor,
            actions: [
              IconButton(
                  onPressed: () async {
                    bool? res = await RegisterUserFormComponent(user_type: UserTypeHandyman).launch(context);
                    if (res ?? true) {
                      userData.clear();
                      currentPage = 1;
                      appStore.setLoading(true);
                      getHandymanList();
                      setState(() {});
                    }
                  },
                  icon: Icon(Icons.add, size: 28, color: white),
                  tooltip: context.translate.lblAddHandyman),
            ],
          ),
          body: Observer(
            builder: (_) => Stack(
              children: [
                SingleChildScrollView(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(
                      widget.list!.length,
                      (index) {
                        return HandymanWidget(data: widget.list![index], width: context.width() * 0.5 - 26);
                      },
                    ),
                  ).paddingAll(16),
                ),
                noDataFound(context).center().visible(userData.isEmpty && afterInit),
                LoaderWidget().center().visible(appStore.isLoading && !afterInit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
