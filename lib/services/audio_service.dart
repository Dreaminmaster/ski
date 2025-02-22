import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();
  
  Future<void> playSkiSound() async {
    await _player.setAsset('assets/audio/ski.mp3');
    await _player.play();
  }

  Future<void> playJumpSound() async {
    await _player.setAsset('assets/audio/jump.mp3');
    await _player.play();
  }

  Future<void> playCollisionSound() async {
    await _player.setAsset('assets/audio/collision.mp3');
    await _player.play();
  }

  void dispose() {
    _player.dispose();
  }
}