part of 'index.dart';

class ImagesContainer extends StatelessWidget {
  const ImagesContainer({super.key, required this.builder});

  final ViewModelBuilder<List<Photo>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Photo>>(
      builder: builder,
      converter: (Store<AppState> store) => store.state.images,
    );
  }
}
