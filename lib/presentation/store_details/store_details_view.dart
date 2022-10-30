
import 'package:clean_architecture_with_mvvm/domain/model/model.dart';
import 'package:clean_architecture_with_mvvm/presentation/store_details/store_details_view_model.dart';
import 'package:flutter/material.dart';
import '../../app/di.dart';
import '../common/state_renderer/state_render_impl.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _bind() {
    _viewModel.getId(int.parse(widget.id));
    _viewModel.start();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Details"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidgets(), () {
                    _viewModel.start();
                  }) ??
                  Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _getContentWidgets() {
    return StreamBuilder<RestaurantDetailsResult>(
        stream: _viewModel.outputRestaurantDetails,
        builder: (context, snapshot) {
          return Column(
            // shrinkWrap: true,
            children: [
              Text("${snapshot.data?.restaurant?.address}"),
            ],
          );
        });
  }
}
