/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class Scissors extends Element{

    public Scissors(String name) {
        super(name);
    }

    @Override
    public Outcome compareTo(Element elem) {
        return (new Outcome(super.getName(), elem.getName()));
    }
    
}