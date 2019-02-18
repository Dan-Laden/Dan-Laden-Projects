
import java.util.Random;

/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class MyBot extends Player {
    protected String inName;
    private Random r;
    private int iter;
    public MyBot(String name) {
        super(name);
        r = new Random();
        iter = 0;
    }

    
    //Assume this bot always plays before a human player.
    @Override
    public Element play() {
        Element elem = null;
        String move = "";
        int n = r.nextInt(5);
        
        move = generateMove(n);
        System.out.println("My next move will be "+move);//That assumption is for tricking the human player
       
        //My bot has three phases they go into. 1. they grab the counter for what would counter their telegraphed move 2. they do that twofold 3. they pick a move randomly
        if(iter==0){iter++;move = getCounter(move);}
        else if(iter==1){iter++;move = getCounter(move);move = getCounter(move);}
        else if (iter==2){iter=0;n = r.nextInt(5);move = generateMove(n);}
        
        elem = generateElem(move);
        
        return elem;
    }
    
    //This method gets the move that will counter the move that will beat what they telegraph
    //There is a higher chance for a move that will get selected that will beat both possible defeaters of the telegraph
    private String getCounter(String move){
        String genMove = "";
        int n = r.nextInt(4);
        
        if(move.equals("Rock")){
            if(n==0){genMove="Paper";}//Traitor
            else if(n==1){genMove="Scissors";}
            else{genMove="Lizard";}}//Defeats both counters
        else if(move.equals("Paper")){
            if(n==0){genMove="Scissors";}//Traitor
            else if(n==1){genMove="Spock";}
            else{genMove="Rock";}}//Defeats both counters
        else if(move.equals("Scissors")){
            if(n==0){genMove="Spock";}//Traitor
            else if(n==1){genMove="Lizard";}
            else{genMove="Paper";}}//Defeats both counters
        else if(move.equals("Lizard")){
            if(n==0){genMove="Rock";}//Traitor
            else if(n==1){genMove="Paper";}
            else{genMove="Spock";}}//Defeats both counters
        else if(move.equals("Spock")){
            if(n==0){genMove="Lizard";}//Traitor
            else if(n==1){genMove="Rock";}
            else{genMove="Scissors";}}//Defeats both counters
        
        return genMove;
    }
    
    //This method is to change from a string to an element with the string
    private Element generateElem(String move){
        Element elem = null;
        
        if(move.equals("Rock")){elem = new Rock("Rock");}
        else if(move.equals("Paper")){elem = new Paper("Paper");}
        else if(move.equals("Scissors")){elem = new Scissors("Scissors");}
        else if(move.equals("Lizard")){elem = new Lizard("Lizard");}
        else if(move.equals("Spock")){elem = new Spock("Spock");}
        
        return elem;
    }
    
    //This is for move generation much like what's used in randombot. int to string conversion
    private String generateMove(int n){
       String move = "";
       if(n == 0){move = "Rock";} 
       else if(n == 1){move = "Paper";} 
       else if(n == 2){move = "Scissors";} 
       else if(n == 3){move = "Lizard";} 
       else if(n == 4){move = "Spock";}
       return move;
    }
}