/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class Spock extends Element{
    protected String inName;
    public Spock(String name) {
        super(name);
    }

    @Override
    public Outcome compareTo(Element elem) {
        return (new Outcome(super.getName(), elem.getName()));
    }
    
}