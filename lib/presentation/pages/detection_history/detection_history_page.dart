import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/injection_container.dart';
import 'package:flutter_application_prgrado/presentation/bloc/detection_history/detection_history_bloc.dart';
import 'package:flutter_application_prgrado/presentation/pages/detection_history/widgets/item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DetectionHistoryPage extends StatelessWidget {
  const DetectionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetectionHistoryBloc>(
      create: (context) => sl<DetectionHistoryBloc>()..add(InitialEvent()),
      child: DetectionHistoryView(),
    );
  }
}

class DetectionHistoryView extends StatefulWidget {
  const DetectionHistoryView({super.key});

  @override
  State<DetectionHistoryView> createState() => _DetectionHistoryViewState();
}

class _DetectionHistoryViewState extends State<DetectionHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<DetectionHistoryBloc, DetectionHistoryState>(
          builder: (context, state) {
        if (state is DetectionHistoryDone) {
          final list = state.listDetectionHistory;
          return ListView.builder(
            itemCount: list!.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemWidget(detectionHistoryEntity: list[index]);
            },
          );
        } else {
          return Text("asd");
        }
      }),
    );
  }
}
