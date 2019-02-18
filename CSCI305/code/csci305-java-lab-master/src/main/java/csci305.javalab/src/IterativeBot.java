/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class IterativeBot extends Player {
    protected String inName;
    private int n;
    public IterativeBot(String name) {
        super(name);
        n = 0;
    }

    //Iterates through a string n nothing special
    @Override
    public Element play() {
       Element elem = null;
       if(n == 0){ n++; elem = new Rock("Rock");} 
       else if(n == 1){n++; elem = new Paper("Paper");} 
       else if(n == 2){n++; elem = new Scissors("Scissors");} 
       else if(n == 3){n++; elem = new Lizard("Lizard");} 
       else if(n == 4){n=0; elem = new Spock("Spock");} 
       return elem;
    }
}