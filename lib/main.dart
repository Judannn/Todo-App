import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/models/todo_list.dart';
import 'package:test_app/widgets/add_form.dart';
import 'package:test_app/widgets/filter_bar.dart';
import 'package:test_app/widgets/todo_card.dart';
import 'package:provider/provider.dart';
import 'package:test_app/services/datasource.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<DataSource>(DataSource());

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
        textTheme: const TextTheme(
          titleMedium: TextStyle(color: Color(0xffffb86c)),
          labelSmall: TextStyle(
            color: Colors.grey,
          ),
          headlineLarge: TextStyle(color: Color(0xffff79c6)),
        ),
        colorScheme: ColorScheme.fromSeed(
            surfaceTint: Colors.transparent,
            surface: const Color(0xff44475a),
            onSurface: const Color(0xfff8f8f2),
            seedColor: Colors.white,
            primary: const Color(0xff8be9fd),
            secondary: const Color(0xff44475a),
            inversePrimary: const Color(0xff44475a),
            primaryContainer: const Color(0xff8be9fd),
            outline: const Color(0xff8be9fd),
            secondaryContainer: const Color(0xff8be9fd),
            background: const Color(0xff282a36)),
        dialogBackgroundColor: const Color(0xff282a36),
        useMaterial3: true,
      ),
      home: const TodoHomePage(title: 'Todos'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key, required this.title});

  final String title;

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
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
                          .map((item) => TodoCard(todo: item))
                          .toList()),
                ),
              ],
            ),
          )),
        );
      }),

      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add todo'),
        onPressed: () {
          showDialog(
              context: context,
              builder: (builder) {
                return const AddForm();
              });
        },
        tooltip: 'Add To Do',
        icon: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
