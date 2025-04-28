import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/models/org/org_request/org_request_model.dart';
import 'package:untitled1/modules/org/cubit/cubit.dart';
import 'package:untitled1/modules/org/cubit/states.dart';
import 'package:untitled1/modules/org/home/request_info/request_info_screen.dart';
import 'package:untitled1/shared/components/components.dart';

class OrgHome extends StatelessWidget {
  const OrgHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrgCubit, OrgStates>(
      builder: (BuildContext context, OrgStates state) {
        final cubit = OrgCubit.get(context);
        if (state is OrgGetRequestLoadingState) {
          const Center(child: CircularProgressIndicator());
        }
        return Column(
          spacing: 10.0,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 20.0,
                    bottom: 10.0,
                    start: 10.0,
                    end: 10.0,
                  ),
                  child: Text(
                    'Requests',
                    style: GoogleFonts.aclonica(
                      fontSize: 40.0,
                      color: const Color(0xff6C2C2C),
                    ),
                  ),
                ),
                myDivider(color: const Color(0xff6C2C2C)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder:
                    (context, index) =>
                        buildRequestItem(cubit.requestList[index], context),
                itemCount: cubit.requestList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              ),
            ),
          ],
        );
      },
      bloc: OrgCubit.get(context)..getRequest(),
    );
  }

  Widget buildRequestItem(OrgRequestModel model, BuildContext context) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xffDED5C4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Req:${model.requestId}',
              style: const TextStyle(
                color: Color(0xff6C2C2C),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap:
                  () => navigateTo(
                    context,
                    RequestInfoScreen(requestId: model.requestId!, assignmentId: model.assignmentId!,),
                  ),
              child: const Text(
                'Info',
                style: TextStyle(
                  color: Color(0xff6C2C2C),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
}
