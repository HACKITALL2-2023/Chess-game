import 'package:firebase_database/firebase_database.dart';
import 'package:state_notifier/state_notifier.dart';

class ChessManager extends StateNotifier {

  ChessManager(super.state);

  FirebaseDatabase database = FirebaseDatabase.instance;

  void init() {
    database.ref('.info/moves').onValue.listen((event) {
      if(event.snapshot.value == true) {
        var connectionRef = database.ref('moves').push();

        connectionRef.onDisconnect().remove();

        connectionRef.set(true);
      }
    });

    database.ref('moves').onValue.listen((event) {
      var playerCount = event.snapshot.children.length;
      state = state.copyWith(playerCount: playerCount);
    });
  }

}