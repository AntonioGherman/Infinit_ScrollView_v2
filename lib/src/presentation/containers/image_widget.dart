import 'package:flutter/cupertino.dart';

import '../../models/index.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.context, required this.index, required this.photo});

  final BuildContext context;
  final int index;
  final List<Photo> photo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(photo[index].urls.small, fit: BoxFit.cover),
    );
  }
}
