/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class StupidBot extends Player {
    protected String inName;
    public StupidBot(String name) {
        super(name);
    }

    //Only plays rock I love them tho
    @Override
    public Element play() {
        return new Rock("Rock");
    }
}
