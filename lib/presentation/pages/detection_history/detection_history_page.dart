import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/injection_container.dart';
import 'package:flutter_application_prgrado/presentation/bloc/detection_history/detection_history_bloc.dart';
import 'package:flutter_application_prgrado/presentation/pages/detection_history/widgets/button_widget.dart';
import 'package:flutter_application_prgrado/presentation/pages/detection_history/widgets/item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/detection_history/cubit/detection_history_cubit.dart';
import '../../widgets/inputs/custom_input_field.dart';

class DetectionHistoryPage extends StatelessWidget {
  const DetectionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetectionHistoryCubit>(
      create: (context) => sl<DetectionHistoryCubit>()..init(),
      child: DetectionHistoryView(),
    );
  }
}

class DetectionHistoryView extends StatelessWidget {
  DetectionHistoryView({super.key});
  Future<void> _refreshList(BuildContext context) async {
    context.read<DetectionHistoryCubit>().loadDataReload();
    textEditingController.clear();
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<DetectionHistoryCubit, DetectionHistoryState>(
          builder: (context, state) {
        if (state is DetectionHistoryDone) {
          final list = state.listMemberEntity;
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomInputFieldPlus(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      colorText: Colors.white,
                      colorLabel: Color.fromARGB(255, 97, 97, 97),
                      label: 'Buscar en la descripción',
                      onChanged: (v, ed) {
                        context.read<DetectionHistoryCubit>().searchMember(v);

                        textEditingController = ed;
                      },
                    ),
                  ),
                  /*SizedBox(
                    width: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () async {},
                      icon: const Icon(
                        Icons.replay_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),*/
                ],
              ),
              BlocSelector<DetectionHistoryCubit, DetectionHistoryState, int?>(
                //bloc: bloc,
                selector: (state) => state.index,
                builder: (context, index) {
                  return Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonOptionWidget(
                        text: 'Todo',
                        isSelected: 0 == index,
                        ontap: () {
                          context
                              .read<DetectionHistoryCubit>()
                              .onIndexChanged(0);
                          textEditingController.clear();
                        },
                        borderRadiusGeometry: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          bottomLeft: Radius.circular(7),
                        ),
                      ),
                      ButtonOptionWidget(
                        text: 'Somnolencia',
                        isSelected: 1 == index,
                        ontap: () {
                          context
                              .read<DetectionHistoryCubit>()
                              .onIndexChanged(1);
                          textEditingController.clear();
                        },
                      ),
                      ButtonOptionWidget(
                        text: 'Distracción',
                        isSelected: 2 == index,
                        ontap: () {
                          context
                              .read<DetectionHistoryCubit>()
                              .onIndexChanged(2);
                          textEditingController.clear();
                        },
                        borderRadiusGeometry: BorderRadius.only(
                          topRight: Radius.circular(7),
                          bottomRight: Radius.circular(7),
                        ),
                      ),
                    ],
                  ));
                },
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => _refreshList(context),
                  child: ListView.builder(
                    itemCount: list!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemWidget(detectionHistoryEntity: list[index]);
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (state is DetectionHistoryLoading) {
          return Center(
            child: Lottie.asset(
              'assets/lottie/animation_lny3vsqg.json',
              width: 200,
              height: 200,
            ),
          );
          //return Text('Error al obtener la información');
        } else if (state is DetectionHistoryDisconnection) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/animation_lny44lqi.json',
                  width: 150,
                  height: 150,
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "¡Ups al parecer te desconectaste",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                /*CustomButton(
                        textButton: "Volver a conectar",
                        width: 200,
                        onPressed: () {
                          /*context
                              .read<SplashBloc>()
                              .add(ReloadConnectionEvent());*/
                        },
                      )*/
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
