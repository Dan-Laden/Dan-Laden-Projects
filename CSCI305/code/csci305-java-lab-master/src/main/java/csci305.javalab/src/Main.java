
import java.util.Scanner;

/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class Main {
    public static String playerMove;
    public static void main(String args[]) {
        Scanner s = new Scanner(System.in);
        int n = 0;
        int m = 0;
        int p1wins = 0;
        int p2wins = 0;
        int turn = 1;
        Player p1;
        Player p2;
        Element p1move;
        Element p2move;
        
        
        System.out.println("Welcome to Rock, Paper, Scissors, Lizard, Spock, implemented by Daniel Laden.");
        
        printMenu();
        
        while(n<1||n>6){System.out.print("Select player 1: ");n=s.nextInt();}
        while(m<1||m>6){System.out.print("Select player 2: ");m=s.nextInt();}
        System.out.print("\n");
        
        p1 = generateBot(n);
        p2 = generateBot(m);

        System.out.print(p1.getName()+" vs "+p2.getName()+". The Wheel of Fate is Turning, ");
        
        while(turn<6){
            printTurn(turn);
            
            if(p2.getName().equals("MyBot")){
                p2move = p2.play();
                p1move = p1.play();
            }
            else{
                p1move = p1.play();
                p2move = p2.play();
            }
            if(p1.getName().equals("LastPlayBot")){playerMove = p2move.getName();}
            else if(p2.getName().equals("LastPlayBot")){playerMove = p1move.getName();}
            
            System.out.print("Player 1 choose "+p1move.getName()+"\n"+
                    "Player 2 choose "+p2move.getName()+"\n"+
                    p1move.compareTo(p2move).outcome+"\n");
            
            if((p1move.compareTo(p2move).result).equals("Win")){
                System.out.println("Player 1 won the round\n");
                p1wins++;
            }
            else if((p1move.compareTo(p2move).result).equals("Lose")){
                System.out.println("Player 2 won the round\n");
                p2wins++;
            }
            else if((p1move.compareTo(p2move).result).equals("Tie")){
                System.out.println("Round was a tie\n");
            }
            
            turn++;
        }
        
        System.out.println("The score was "+p1wins+" to "+p2wins+".");
        
        if(p1wins>p2wins){System.out.println("Player 1 you win!");}
        else if(p1wins<p2wins){System.out.println("Player 2 you win!");}
        else if(p1wins==p2wins){System.out.println("Game was a draw");}
    }
    private static void printMenu(){
     System.out.print("Please choose two players:\n"+
     "(1) Human\n"+
     "(2) StupidBot\n"+
     "(3) RandomBot\n"+
     "(4) IterativeBot\n"+
     "(5) LastPlayBot\n"+
     "(6) MyBot\n\n");
    }
    private static Player generateBot(int n){
       Player p = null;
       if(n == 1){p = new Human("Human");} 
       else if(n == 2){p = new StupidBot("StupidBot");} 
       else if(n == 3){p = new RandomBot("RandomBot");} 
       else if(n == 4){p = new IterativeBot("IterativeBot");} 
       else if(n == 5){p = new LastPlayBot("LastPlayBot");}
       else if(n == 6){p = new MyBot("MyBot");}
       return p;
    }
    
    private static void printTurn(int turn){System.out.println("Rebel "+turn+" Action!");}
}
