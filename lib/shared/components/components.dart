import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget defaultButton({
  required Function()? function,
  required String text,
  required Color? backgroundColor,
  Color foregroundColor = Colors.white,
  double radius = 10.0,
  double height = 52.0,
  double horizontal = 20.0,
  double vertical = 0.0,
  double fontSize = 32.0,
}) => Padding(
  padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
  child: SizedBox(
    width: double.infinity,
    height: height,
    child: ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Text(text, style: TextStyle(fontSize: fontSize)),
    ),
  ),
);

PreferredSizeWidget? defaultAppBar({
  required BuildContext context,
  required Color? backgroundColor,
  String? label,
  List<Widget>? actions,
}) => AppBar(
  backgroundColor: backgroundColor,
  leading: IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Container(
      height: 30,
      width: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black,
        size: 18.0,
      ),
    ),
  ),
  titleSpacing: 5.0,
  title: Text(
    label ?? '',
  ),
  actions: actions,
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    border: const OutlineInputBorder(),
  ),
);

Widget myDivider({
  required Color? color
}) => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: color,
  ),
);

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
  (route) {
    return false;
  },
);

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}
