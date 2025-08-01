import 'package:equatable/equatable.dart';

class Statistics extends Equatable {
  const Statistics({this.hero, this.events = const []});

  final Hero? hero;
  final List<GameEvent> events;

  @override
  List<Object?> get props => [hero, events];

  Statistics copyWith({Hero? hero, List<GameEvent>? events}) {
    return Statistics(hero: hero ?? this.hero, events: events ?? this.events);
  }
}

enum EventType { success, hint, error }

class Hero extends Equatable {
  Hero({required this.name, required this.race, required this.heroClass});

  @override
  List<Object?> get props => [name, race, heroClass];

  @override
  String toString() => 'Hero($name, $race, $heroClass)';

  final String name;
  final String race;
  final String heroClass;
}

class GameEvent extends Equatable {
  GameEvent({
    required this.event,
    required this.eventType,
    required this.timeLeft,
  });

  @override
  List<Object?> get props => [event, timeLeft];

  @override
  String toString() =>
      'GameEvent(Event: $event, Time Left: $timeLeft, Type: $eventType)';

  final String event;
  final EventType eventType;
  final Duration timeLeft;
}
