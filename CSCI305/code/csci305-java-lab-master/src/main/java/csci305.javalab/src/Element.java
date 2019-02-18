/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public abstract class Element {
    protected String name;
    
    public Element(String name) {
        this.name = name;
    }
    
    public String getName(){ return name; }
    
    public abstract Outcome compareTo(Element elem);
}
