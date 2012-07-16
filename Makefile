introspection.vapi introspection.h introspection.c: introspection.vala
	valac --vapi introspection.vapi -C -H introspection.h introspection.vala
