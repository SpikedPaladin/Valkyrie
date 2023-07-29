namespace Valkyrie {
    
    public class ValaCompletionProvider : GtkSource.CompletionProvider, Object {
        
		public async ListModel populate_async(GtkSource.CompletionContext context, GLib.Cancellable? cancellable) throws GLib.Error {
		    var list = new ListStore(typeof(ValaProposal));
		    
		    // TODO load real vala completion proposals
		    list.append(new ValaProposal() {
		        name = "Button",
		        type = ValaType.CLASS,
		        args = "Gtk.Widget"
		    });
		    list.append(new ValaProposal() {
		        name = "Gtk",
		        type = ValaType.NAMESPACE
		    });
		    list.append(new ValaProposal() {
		        name = "init",
		        type = ValaType.METHOD,
		        args = "string name"
		    });
		    
		    return list;
		}
		
		public void activate(GtkSource.CompletionContext context, GtkSource.CompletionProposal proposal) {
		    var vala_proposal = proposal as ValaProposal;
		    if (vala_proposal == null) return;
		    
		    var buffer = context.get_buffer();
		    
		    buffer.begin_user_action();
		    
		    Gtk.TextIter begin, end;
		    var has_selection = context.get_bounds(out begin, out end);
		    
		    if (has_selection)
		        buffer.delete(ref begin, ref end);
		    
		    buffer.insert(ref begin, vala_proposal.name, vala_proposal.name.length);
		    
		    buffer.end_user_action();
		}
		
		public void display(GtkSource.CompletionContext context, GtkSource.CompletionProposal proposal, GtkSource.CompletionCell cell) {
		    var vala_proposal = proposal as ValaProposal;
		    if (vala_proposal == null) return;
		    
		    var column = cell.get_column();
		    if (column == GtkSource.CompletionColumn.ICON) {
		        string icon = "lang-method-symbolic";
		        switch (vala_proposal.type) {
		            case ValaType.STRUCT:
                        icon = "lang-struct-symbolic";
                        break;
                    case ValaType.METHOD:
                        icon = "lang-method-symbolic";
                        break;
                    case ValaType.ENUM:
                        icon = "lang-enum-symbolic";
                        break;
                    case ValaType.NAMESPACE:
                        icon = "lang-namespace-symbolic";
                        break;
                    case ValaType.CLASS:
                        icon = "lang-class-symbolic";
                        break;
		        }
		        cell.set_icon_name(icon);
		    } else if (column == GtkSource.CompletionColumn.TYPED_TEXT) {
		        cell.set_text_with_attributes(vala_proposal.name, GtkSource.Completion.fuzzy_highlight(vala_proposal.name, context.get_word()));
		    } else if (column == GtkSource.CompletionColumn.DETAILS) {
		        cell.set_text("Some insane documentation");
		    } else if (column == GtkSource.CompletionColumn.BEFORE) {
		        cell.set_text("before");
		    } else if (column == GtkSource.CompletionColumn.AFTER) {
		        if (vala_proposal.type == ValaType.CLASS)
		            cell.set_text(@": $(vala_proposal.args)");
		        else if (vala_proposal.type == ValaType.METHOD)
		            cell.set_text(@"($(vala_proposal.args))");
		    } else if (column == GtkSource.CompletionColumn.COMMENT) {
		        cell.set_text("comment");
		    }
		}
		
		public void refilter(GtkSource.CompletionContext context, ListModel model) {
		    var list = model as ListStore;
		    
		    list.sort((a, b) => {
		        var prop_a = a as ValaProposal;
		        var prop_b = b as ValaProposal;
		        return prop_b.name.index_of(context.get_word(), 0) - prop_a.name.index_of(context.get_word(), 0);
		    });
		    print(@"Context: $(context.get_word())\n");
		    
		}
		
		public bool is_trigger(Gtk.TextIter iter, unichar ch) {
		    return true;
		}
    }
}
