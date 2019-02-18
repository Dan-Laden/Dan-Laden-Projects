
import java.util.Scanner;

/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class Human extends Player {
    protected String inName;
    public Human(String name) {
        super(name);
    }
    //Human player non-AI
    @Override
    public Element play() {
        Element elem = null;
        Scanner s = new Scanner(System.in);
        int userIn = 6;
        
        
        printMenu();
        while(userIn<0 || userIn>5){
            System.out.print("Enter your move:");
            userIn = s.nextInt();
            if(userIn<0 || userIn>5){System.out.println("Invalid move. Please try again.");}
        }
        
       if(userIn == 1){elem = new Rock("Rock");} 
       else if(userIn == 2){elem = new Paper("Paper");} 
       else if(userIn == 3){elem = new Scissors("Scissors");} 
       else if(userIn == 4){elem = new Lizard("Lizard");} 
       else if(userIn == 5){elem = new Spock("Spock");} 
        
        return elem;
    }
    
    //Just used to seperate it from the main logic area
    private void printMenu(){
        System.out.print(
        "(1) : Rock\n"+
        "(2) : Paper\n"+
        "(3) : Scissors\n"+
        "(4) : Lizard\n"+
        "(5) : Spock\n");
    }
}