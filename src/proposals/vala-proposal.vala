namespace Valkyrie {
    
    public class ValaProposal : GtkSource.CompletionProposal, Object {
        public string name;
        public ValaType type;
        public string? args;
        
        public ValaProposal() {}
    }
    
    public enum ValaType {
        METHOD,
        CLASS,
        ENUM,
        STRUCT,
        NAMESPACE
    }
}
