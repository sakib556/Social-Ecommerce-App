import 'package:flutter/material.dart';
import 'package:protibeshi_app/views/custom_widgets/text_with_button.dart';

class AcceptTermsAndConditionsTextButton extends StatelessWidget {
  const AcceptTermsAndConditionsTextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextWithButton(
      buttonText: "Terms and Conditions",
      normalText: "By signing up I agree to the ",
      onPressed: () {
        //TODO: Go to the terms and conditions page
      },
    );
  }
}
