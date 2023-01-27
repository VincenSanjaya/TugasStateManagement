import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugas_state_management/models/nba_model.dart';
import 'package:tugas_state_management/nba_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
          child: BlocBuilder<NbaBloc, NbaState>(
            builder: (context, state) {
              if (state is NbaInitial) {
                return const CircularProgressIndicator();
              }
              if (state is NbaLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${state.nbas.length}",
                      style: const TextStyle(
                          fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          for(int index =0; index < state.nbas.length; index++)
                            Positioned(
                              right: random.nextInt(400).toDouble(),
                              left: random.nextInt(250).toDouble(),
                              top: random.nextInt(400).toDouble(),
                              bottom: random.nextInt(300).toDouble(),
                              child: SizedBox(
                                height:150,
                                width: 150,
                                child: state.nbas[index].image,
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                );

              } else {
                return const Text("Ups, Something When Wrong");
              }
            },
          ),
        ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.sports_basketball),
              backgroundColor: Colors.orange[500],
              onPressed: () {
            context.read<NbaBloc>().add(AddNba(Nba.nbas[1]));
          }),
          const SizedBox(height: 10,),
          FloatingActionButton(
              child: const Icon(Icons.add),
              backgroundColor: Colors.orange[500],
              onPressed: () {
            context.read<NbaBloc>().add(AddNba(Nba.nbas[0]));

          }),
          const SizedBox(height: 10,),
          FloatingActionButton(
              child: const Icon(Icons.minimize),
              backgroundColor: Colors.orange[500],
              onPressed: () {
            context.read<NbaBloc>().add(RemoveNba(Nba.nbas[0]));
          }),
          const SizedBox(height: 10,),
          FloatingActionButton(
              child: const Icon(Icons.minimize),
              backgroundColor: Colors.orange[500],
              onPressed: () {
                context.read<NbaBloc>().add(RemoveNba(Nba.nbas[1]));
              })
                  ],
      ),
    );
  }
}
