import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goldrush_2d/gold_rush.dart';
import 'package:goldrush_2d/providers/blocs/setting_bloc.dart';

void main() async {
  final goldRush = GoldRush();
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setPortrait();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SettingBloc>(
          create: (BuildContext context) => SettingBloc(),
        ),
      ],
      child: GameWidget(game: goldRush),
    ),
  );
}
