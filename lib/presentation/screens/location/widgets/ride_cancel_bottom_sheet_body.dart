import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cabbieuser/core/utils/dimensions.dart';
import 'package:cabbieuser/core/utils/my_color.dart';
import 'package:cabbieuser/core/utils/my_strings.dart';
import 'package:cabbieuser/core/utils/style.dart';
import 'package:cabbieuser/data/controller/ride/ride_details/ride_details_controller.dart';
import 'package:cabbieuser/presentation/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:cabbieuser/presentation/components/buttons/rounded_button.dart';
import 'package:cabbieuser/presentation/components/snack_bar/show_custom_snackbar.dart';
import 'package:cabbieuser/presentation/components/text-form-field/custom_text_field.dart';

class RideCancelBottomSheetBody extends StatelessWidget {
  const RideCancelBottomSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideDetailsController>(builder: (controller) {
      return Column(
        children: [
          const BottomSheetHeaderRow(),
          const SizedBox(height: Dimensions.space10),
          CustomTextField(
            labelTextStyle: boldDefault.copyWith(),
            animatedLabel: false,
            needOutlineBorder: true,
            fillColor: MyColor.colorGrey.withValues(alpha: 0.1),
            labelText: MyStrings.cancelReason.tr,
            hintText: MyStrings.cancelationReason,
            maxLines: 6,
            controller: controller.cancelReasonController,
            onChanged: (c) {},
          ),
          const SizedBox(height: Dimensions.space20),
          RoundedButton(
              text: MyStrings.cancel,
              isLoading: controller.isCancelLoading,
              press: () {
                if (controller.cancelReasonController.text.isNotEmpty) {
                  controller.cancelRide();
                } else {
                  CustomSnackBar.error(
                      errorList: ['Please Write your cancel reason']);
                }
              }),
          const SizedBox(height: Dimensions.space10),
        ],
      );
    });
  }
}
