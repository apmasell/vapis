string foo(Git.Commit c) {
	return c.id.to_string() ?? "?";
}

void bar (Git.Object o) {
	unowned Git.Commit c = (Git.Commit) o;
}

void test(Git.Repository repo) {
	string[] attrs = { "crlf", "diff", "foo" };
	string[] res;
	repo.attributes.lookup_many(Git.AttrCheck.FILE_THEN_INDEX, "my/fun/file.c", attrs, out res);
}

void main() {
}
