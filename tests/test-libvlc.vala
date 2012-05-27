using VLC;

void main() {
	var inst = Instance.create();
	var m = inst.open_media_path<bool>("http://mycool.movie.com/test.mov");
	var mp = m.create_player();

	mp.play();
	mp.stop();
}
