import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbieuser/core/utils/dimensions.dart';
import 'package:cabbieuser/core/utils/my_color.dart';
import 'package:cabbieuser/core/utils/my_strings.dart';
import 'package:cabbieuser/data/controller/faq/faq_controller.dart';
import 'package:cabbieuser/data/repo/faq/faq_repo.dart';
import 'package:cabbieuser/data/services/api_service.dart';
import 'package:cabbieuser/presentation/components/app-bar/custom_appbar.dart';
import 'package:cabbieuser/presentation/components/no_data.dart';
import 'package:cabbieuser/presentation/components/shimmer/faq_shimmer.dart';
import 'package:cabbieuser/presentation/screens/faq/widget/faq_widget.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FaqRepo(apiClient: Get.find()));
    final controller = Get.put(FaqController(faqRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getFaqList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.screenBgColor,
      appBar: CustomAppBar(
        title: MyStrings.faq,
        isTitleCenter: false,
        elevation: 0.01,
      ),
      body: GetBuilder<FaqController>(
        builder: (controller) {
          return controller.isLoading
              ? ListView.builder(
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return const FaqCardShimmer();
                  },
                )
              : controller.faqList.isEmpty
                  ? const NoDataWidget(fromRide: true)
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: Dimensions.screenPaddingHV,
                        child: Column(
                          children: List.generate(
                            controller.faqList.length,
                            (index) => FaqListItem(
                              press: () {
                                controller.changeSelectedIndex(index);
                              },
                              selectedIndex: controller.selectedIndex,
                              index: index,
                              question: controller
                                      .faqList[index].dataValues?.question
                                      .toString() ??
                                  "",
                              answer: controller
                                      .faqList[index].dataValues?.answer ??
                                  "",
                            ),
                          ),
                        ),
                      ),
                    );
        },
      ),
    );
  }
}
