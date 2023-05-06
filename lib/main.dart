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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {

    final Store<AppState> store=StoreProvider.of<AppState>(context);

    final double height = MediaQuery.of(context).size.height;
    final double offset = _scrollController.position.pixels;
    final double maxScroll = _scrollController.position.maxScrollExtent;
    if (store.state.hasMore && !store.state.isLoading && maxScroll - offset < 3 * height) {
      store.dispatch(GetImages.start(search: store.state.categorie, page: store.state.page));
    }
  }

  void _onText(){
    final Store<AppState> store=StoreProvider.of<AppState>(context);
    store.dispatch(GetImages.start(search: _textController.text, page: 1));
    print(store.state.categorie+" test ");
  }

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
                if (isLoading && images.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                              decoration: InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                                  hintText: 'Search',
                                  prefixIcon: const Icon(Icons.search)),
                              controller: _textController)),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _onText();
                            });
                          },
                          child: const Text('Search'))
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                        controller: _scrollController,
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
                                            height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 2,
                                            child: Column(
                                              children: <Widget>[
                                                ImageWidget(context: context, index: index, photo: images)
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
                                child: ImageWidget(context: context, index: index,photo: images)
                              ));
                        }),
                  )
                ]);
              },
            );
          },
        ));
  }
}
