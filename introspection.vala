public void type_info<T>() {
	var type = typeof(T);
	TypeQuery query;
	type.query(out query);
	stdout.printf("%s %c%c%c%C%C%C%C%C%C%C%C size(class = %u instance = %u)\n", type.name(),
		type.is_object() ? 'o' : '-',
		type.is_abstract() ? 'a' : '-',
		type.is_classed() ? 'c' : '-',
		type.is_derivable() ? (type.is_deep_derivable() ? 'D' : 'd') : '-',
		type.is_derived() ? 'v' : '-',
		type.is_fundamental() ? 'F' : '-',
		type.is_instantiatable() ? 'N' : '-',
		type.is_interface() ? 'i' : '-',
		type.is_value_type() ? 's' : '-',
		type.is_enum() ? 'e' : '-',
		type.is_flags() ? 'f' : '-',
		query.class_size,
		query.instance_size);

	if (type.is_object()) {
		stdout.printf("class %s", type.name());
		for(var parent = type.parent(); parent != Type.INVALID; parent = parent.parent()) {
			stdout.printf(" : %s", parent.name());
		}
		stdout.printf(" {\n");
		foreach (var property in ((ObjectClass)type.class_ref()).list_properties()) {
			stdout.printf("\t%s :: %s -- %s\n", property.name, property.value_type.name(), property.get_blurb());
		}
		stdout.printf("}\n");
	}
}
