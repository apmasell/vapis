using BerkeleyDB;

public void main() {

	BerkeleyDB.Environment<bool> e;
	BerkeleyDB.Environment.create<bool>(out e);
}
