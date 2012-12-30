using Git;
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


public static int main( string []args )
{
    Repository repo;
    Repository.open(out repo, "../.git");

    repo.for_each_branch(Git.BranchType.LOCAL, callback);

    return 0;
}
public int callback (string branch_name, BranchType branch_type)
{
    stdout.puts(branch_name);
    return 0;
}

public void walk_test (Git.Tree tree) {
	tree.walk(WalkMode.PRE, (root, entry) => {stdout.printf("root: %s\n", root);return Git.Error.OK;});
}
