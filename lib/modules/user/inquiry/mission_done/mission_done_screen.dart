import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/models/inquiry/requests_model.dart';
import 'package:untitled1/shared/components/components.dart';

class MissionDoneScreen extends StatelessWidget {
  const MissionDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            backgroundColor: const Color(0xffF2EFEA),
            label: 'Mission Done',
          ),
          body:
              cubit.doneList.isEmpty
                  ? const Center(child: Text('No Mission Done requests found'))
                  : ListView.builder(
                    itemBuilder:
                        (context, index) => buildMissionDoneItem(
                          cubit.doneList[index],
                          context,
                          index,
                        ),
                    itemCount: cubit.doneList.length,
                  ),
        );
      },
      bloc: MainCubit.get(context)..doneRequest(),
    );
  }

  Widget buildMissionDoneItem(
    RequestsModel model,
    BuildContext context,
    int index,
  ) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: const Color(0xffB8BB84),
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
                  ).changeInProgress(index, 'missionDone'),
              child: CircleAvatar(
                radius: 15.0,
                backgroundColor: const Color(0xff6C2C2C),
                child:
                    MainCubit.get(context).isCollapse['missionDone']! &&
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
        if (MainCubit.get(context).isCollapse['missionDone']! &&
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
                'Mission Done By: ${model.missionDoneNgo}',
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
              Text(
                'Done in: ${model.missionDoneDate?.substring(0, 10)}',
                style: const TextStyle(
                  color: Color(0xff6C2C2C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Thanks for solving a problem ❤️🐶',
                style: TextStyle(
                  color: Color(0xff6C2C2C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ],
    ),
  );
}
