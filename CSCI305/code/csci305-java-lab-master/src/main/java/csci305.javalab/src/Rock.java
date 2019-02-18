/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class Rock extends Element{

    public Rock(String name) {
        super(name);
    }

    @Override
    public Outcome compareTo(Element elem) {
        return (new Outcome(super.getName(), elem.getName()));
    }
    
}
