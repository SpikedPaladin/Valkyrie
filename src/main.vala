public void peas_register_types(TypeModule module) {
	var obj = (Peas.ObjectModule) module;
	obj.register_extension_type(typeof(GtkSource.CompletionProvider), typeof(Valkyrie.ValaCompletionProvider));
}
