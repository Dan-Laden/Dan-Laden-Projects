
import java.util.Random;

/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class RandomBot extends Player {
    protected String inName;
    private Random r;
    public RandomBot(String name) {
        super(name);
        r = new Random();
    }

    //generates a new random int each time play is called and from there generates a move
    @Override
    public Element play() {
       int n = r.nextInt(5);
       Element elem = null;
       
       if(n == 0){elem = new Rock("Rock");} 
       else if(n == 1){elem = new Paper("Paper");} 
       else if(n == 2){elem = new Scissors("Scissors");} 
       else if(n == 3){elem = new Lizard("Lizard");} 
       else if(n == 4){elem = new Spock("Spock");} 
       return elem;
    }
}