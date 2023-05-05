import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'src/actions/index.dart';
import 'src/data/api_call.dart';
import 'src/epics/app_epics.dart';
import 'src/models/index.dart';
import 'src/presentation/containers/image_widget.dart';
import 'src/presentation/containers/index.dart';
import 'src/reducer/app_reducer.dart';

void main() {
  const String apiKey = '2CMxxZJ5e6lez4zIPjhIpHRgezq49MNJfSLgGnMXlf0';
  final Client client = Client();
  final ApiCall apiCall = ApiCall(client, apiKey);
  final AppEpics epic = AppEpics(apiCall);
  final Store<AppState> store = Store<AppState>(reducer,
      initialState: const AppState(), middleware: <Middleware<AppState>>[EpicMiddleware<AppState>(epic.call).call]);

  store.dispatch(GetImages.start(search: store.state.categorie, page: store.state.page));

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.store});

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Photo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('App Photo'),
        ),
        body: IsLoadingContainer(
          builder: (BuildContext context, bool isLoading) {
            return ImagesContainer(
              builder: (BuildContext context, List<Photo> images) {
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 155),
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 2,
                                        child: Column(
                                          children: <Widget>[
                                            ImageWidget(context: context, index: index, photo: images),
                                            //  _imageWidget(context, index, images),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ImageWidget(context: context, index: index, photo: images),
                          ));
                    });
              },
            );
          },
        ));
  }
}
