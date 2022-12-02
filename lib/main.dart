import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_pr4/color_schemes.g.dart';
import 'package:state_management_pr4/cubit/click_cubit/click_cubit.dart';
import 'package:state_management_pr4/cubit/theme_cubit/theme_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ClickCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'State management',
          themeMode: context.read<ThemeCubit>().themeMode,
          theme: ThemeData(
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(colorScheme: darkColorScheme),
          home: const CounterPage(),
        );
      }),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<ClickCubit, ClickState>(
              builder: (context, state) {
                if (state is ClickError) {
                  return Text(
                    state.message,
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
                if (state is Click) {
                  return Text(
                    state.count.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
                return Text(
                  '0',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Container()),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<ClickCubit>()
                          .onIncClick(context.read<ThemeCubit>().themeMode);
                    },
                    child: const Text('+'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<ClickCubit>()
                          .onDecClick(context.read<ThemeCubit>().themeMode);
                    },
                    child: const Text('-'),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            SizedBox(
              width: 300,
              height: 400,
              child: Card(
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  children: [
                    Text(
                      'Logger',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ClickCubit>().clearLog();
                        },
                        child: const Text('Clear'),
                      ),
                    ),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    Expanded(
                      child: BlocBuilder<ClickCubit, ClickState>(
                        builder: (context, state) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Center(
                                child: Text(context
                                    .read<ClickCubit>()
                                    .widgetsList[index]),
                              );
                            },
                            itemCount:
                                context.read<ClickCubit>().widgetsList.length,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<ThemeCubit>().switchTheme();
              context.read<ClickCubit>().getThemeName(context);
            },
            tooltip: 'Switch theme',
            child: Icon(state is LightThemeState
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
          );
        },
      ),
    );
  }
}
