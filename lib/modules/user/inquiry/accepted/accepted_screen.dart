import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/states.dart';
import 'package:untitled1/models/inquiry/requests_model.dart';
import 'package:untitled1/shared/components/components.dart';

class AcceptedScreen extends StatelessWidget {
  const AcceptedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      builder: (BuildContext context, MainStates state) {
        final cubit = MainCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            backgroundColor: const Color(0xffF2EFEA),
            label: 'Accepted',
          ),
          body:
              cubit.acceptedList.isEmpty
                  ? const Center(child: Text('No accepted requests found'))
                  : ListView.builder(
                    itemBuilder:
                        (context, index) => buildAcceptedItem(
                          cubit.acceptedList[index],
                          context,
                          index,
                        ),
                    itemCount: cubit.acceptedList.length,
                  ),
        );
      },
      bloc: MainCubit.get(context)..acceptedRequest(),
    );
  }

  Widget buildAcceptedItem(
    RequestsModel model,
    BuildContext context,
    int index,
  ) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: const Color(0xffDED5C4),
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
                  ).changeInProgress(index, 'accepted'),
              child: CircleAvatar(
                radius: 15.0,
                backgroundColor: const Color(0xff6C2C2C),
                child:
                    MainCubit.get(context).isCollapse['accepted']! &&
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
        if (MainCubit.get(context).isCollapse['accepted']! &&
            MainCubit.get(context).currentIndexCollapse == index) ...[
          const Divider(color: Colors.white,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Street Address:',
                style: TextStyle(
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
                'Requested in: ${model.submissionTime}',
                style: const TextStyle(
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
