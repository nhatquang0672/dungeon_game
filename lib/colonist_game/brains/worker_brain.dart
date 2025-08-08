import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:my_game/colonist_game/brains/path_finder.dart';
import 'package:my_game/colonist_game/colonist_game.dart';
import 'package:my_game/colonist_game/standard/int_vector2.dart';
import 'package:my_game/game/configuration/configuration.dart';

class WorkerBrain extends Component with HasGameReference<ColonistGame> {
  late Timer _assignTaskInterval;
  final List<Vector2> _queuedTasks = [];

  @override
  void onMount() {
    _assignTaskInterval = Timer(1, repeat: true, onTick: _assignTasks)..start();
    super.onMount();
  }

  void calculateTasks(Vector2 tap) {
    _queuedTasks.add(tap);
  }

  @override
  void update(double dt) {
    _assignTaskInterval.update(dt);
    super.update(dt);
  }

  Future<void> _assignTasks() async {
    print('try to assign task');
    if (_queuedTasks.isEmpty || !game.worker.isIdle) {
      return;
    }
    final firstDess = _queuedTasks.removeAt(0);
    final firstDes = IntVector2(
      firstDess.x ~/ dTileSize,
      firstDess.y ~/ dTileSize,
    );

    print('have task !!!! ' + firstDes.toString());
    try {
      final calculateWorkData = _CalculateWorkData(
        idleWorkerPositions: [
          game.worker.tilePosition,
        ],
        destinations: [firstDes],
        pathFinderData: game.pathFinderData,
      );

      final path = _calculateWork(
        calculateWorkData,
      );
      game.worker.issueWork(firstDes, path);
    } finally {
      print('end work');
    }
  }

  static List<IntVector2> _calculateWork(_CalculateWorkData data) {
    final path = findPath(
      start: data.idleWorkerPositions[0],
      destination: data.destinations[0],
      pathFinderData: data.pathFinderData,
    );

    return path?.toList() ?? [];
  }
}

@immutable
class _CalculateWorkData {
  final List<IntVector2> idleWorkerPositions;
  final List<IntVector2> destinations;
  final PathFinderData pathFinderData;

  const _CalculateWorkData({
    required this.idleWorkerPositions,
    required this.destinations,
    required this.pathFinderData,
  });
}
