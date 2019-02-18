/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class Lizard extends Element{

    public Lizard(String name) {
        super(name);
    }

    @Override
    public Outcome compareTo(Element elem) {
        return (new Outcome(super.getName(), elem.getName()));
    }
    
}