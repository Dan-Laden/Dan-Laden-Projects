/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class Paper extends Element{

    public Paper(String name) {
        super(name);
    }

    @Override
    public Outcome compareTo(Element elem) {
        return (new Outcome(super.getName(), elem.getName()));
    }
    
}