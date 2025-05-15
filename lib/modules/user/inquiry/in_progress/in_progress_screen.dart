import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/models/inquiry/requests_model.dart';
import 'package:untitled1/shared/components/components.dart';

class InProgressScreen extends StatelessWidget {
  const InProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (BuildContext context, MainStates state) {
        if (state is MainDeleteRequestErrorState) {
          MainCubit.get(context).snackBar(
              context: context,
              title: 'Error',
              message: state.error,
              type: ContentType.failure
          );
        }
      },
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            backgroundColor: const Color(0xffF2EFEA),
            label: 'In Progress',
          ),
          body:
              cubit.inProgressList.isEmpty
                  ? const Center(child: Text('No in-progress requests found'))
                  : ListView.builder(
                    itemBuilder:
                        (context, index) => buildInProgressItem(
                          cubit.inProgressList[index],
                          context,
                          index,
                        ),
                    itemCount: cubit.inProgressList.length,
                  ),
        );
      },
      bloc: MainCubit.get(context)..inProgressRequest(),
    );
  }

  Widget buildInProgressItem(
    RequestsModel model,
    BuildContext context,
    int index,
  ) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: const Color(0xffC79E9E),
    ),
    child: Column(
      children: [
        Row(
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
                  () => MainCubit.get(
                    context,
                  ).changeInProgress(index, 'inProgress'),
              child: CircleAvatar(
                radius: 15.0,
                backgroundColor: const Color(0xff6C2C2C),
                child:
                    MainCubit.get(context).isCollapse['inProgress']! &&
                            MainCubit.get(context).currentIndexCollapse == index
                        ? const Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white,
                        )
                        : const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
              ),
            ),
          ],
        ),
        if (MainCubit.get(context).isCollapse['inProgress']! &&
            MainCubit.get(context).currentIndexCollapse == index) ...[
          const Divider(color: Colors.white),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Street Address: ${model.streetAddress}',
                style: const TextStyle(
                  color: Color(0xff6C2C2C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Status: ${model.status}',
                style: const TextStyle(
                  color: Color(0xff6C2C2C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Requested in: ${model.submissionTime?.substring(0, 10)}',
                style: const TextStyle(
                  color: Color(0xff6C2C2C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              defaultButton(
                function:
                    () => showDialog<void>(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            content: const Text(
                              'Are you sure you want to cancel this request?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff6C2C2C),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            actions: <Widget>[
                              Row(
                                spacing: 15.0,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                        const Color(0xffB8BB84),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        MainCubit.get(context).deleteRequest(requestId: model.requestId!);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('yes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                        const Color(0xffAF6B58),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      child: const Text('cancel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    ),
                text: 'Cancel Request',
                height: 40,
                horizontal: 0,
                fontSize: 25,
                vertical: 10,
                backgroundColor: const Color(0xff6C2C2C),
              ),
            ],
          ),
        ],
      ],
    ),
  );
}
