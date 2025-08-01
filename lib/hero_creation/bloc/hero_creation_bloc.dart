import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hero_creation_state.dart';
part 'hero_creation_event.dart';

class HeroCreationBloc extends Bloc<HeroCreationEvent, HeroCreationState> {
  HeroCreationBloc() : super(HeroCreationState());
}
