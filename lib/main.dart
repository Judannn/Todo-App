import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/models/todo_list.dart';
import 'package:test_app/services/api_datasource.dart';
import 'package:test_app/widgets/add_form.dart';
import 'package:test_app/widgets/filter_bar.dart';
// import 'package:test_app/services/sql_datasource.dart';
import 'package:test_app/widgets/todo_card.dart';
import 'package:provider/provider.dart';
import 'package:test_app/services/datasource.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DataSource dataSource;

  dataSource = DataSource();

  GetIt.I.registerSingleton<DataSource>(dataSource);

  runApp(ChangeNotifierProvider(
      create: (context) => TodoList(), child: const TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodoHomePage(title: 'ToDos'),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   // Load todos from Hive when the app starts
  //   Provider.of<TodoList>(context, listen: false).browse(ListFilter.all);
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the TodoHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          children: [
            Text(widget.title),
          ],
        ),
      ),
      body: Consumer<TodoList>(builder: (context, stateModel, child) {
        return RefreshIndicator(
          onRefresh: () {
            return stateModel.browse(ListFilter.all);
          },
          child: SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                FilterBar(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: stateModel.todos
                          .map((item) => TodoCard(toDo: item))
                          .toList()),
                ),
              ],
            ),
          )),
        );
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (builder) {
                return const AddForm();
              });
        },
        tooltip: 'Add To Do',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
