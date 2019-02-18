/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class LastPlayBot extends Player {
    protected String inName;
    protected int turn=1;
    private Element lastPlayed = null;
    public LastPlayBot(String name) {
        super(name);
    }

    @Override
    public Element play() {
        lastPlayed = new Rock("Rock");
        if(turn>=2){
            if(Main.playerMove.equals("Rock")){lastPlayed = new Rock("Rock");}
            else if(Main.playerMove.equals("Paper")){lastPlayed = new Paper("Paper");}
            else if(Main.playerMove.equals("Scissors")){lastPlayed = new Scissors("Scissors");}
            else if(Main.playerMove.equals("Lizard")){lastPlayed = new Lizard("Lizard");}
            else if(Main.playerMove.equals("Spock")){lastPlayed = new Spock("Spock");}
        }
        turn++;
        return lastPlayed;
    }
    
    /*
    *This bot will take in the last result string and compare to check if it was used using REGEXP. might need a new method tho
    */

}