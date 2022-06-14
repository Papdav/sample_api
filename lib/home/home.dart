import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_api/home/bloc/home_bloc.dart';
import 'package:sample_api/services/boredServices.dart';
import 'package:sample_api/services/connectivityServices.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(
          RepositoryProvider.of<BoredService>(context),
          RepositoryProvider.of<ConnectivityServices>(context),
        )..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Activities for bored people'),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context,state){
            if(state is HomeLoadingState){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is HomeLoadedState){
              return Column(
                children: [
                  Text(state.activityName),
                  Text(state.activityType),
                  Text(state.participants.toString()),
                  ElevatedButton(
                    onPressed: () => BlocProvider.of<HomeBloc>(context).add(LoadApiEvent()),
                    child: const Text('Load Next'),
                  ),
                ],
              );
            }
            if(state is HomeNoInternetState){
              return const Text('No Internet');
            }
            return Container();
          },
        ),
      ),
    );

  }
}
