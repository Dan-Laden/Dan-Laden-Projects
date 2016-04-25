package Outlab6;

/**
 * Driver for Outlab 6
 */
public class Driver
{
    public static void main (String [] args)
    {
        Battleship game = new Battleship(5, 4);        //play on a board with 5 rows and 7 columns

        System.out.println("Battleship!");
        System.out.println("-----------\n");

        game.setBoard();                //get board ready to play

        System.out.println("Revealed board (for verification purposes):\n");
        game.printBoard(true);          //print contents of all spots

       while (!game.over())
        {
            game.printBoard(false);     //only print visited spots           
            game.makeGuess();           //prompt user for guess and process it
        }

        game.printStatistics();         //print number of guesses it took to win game

        System.out.println("Goodbye.  Thanks for playing.");
    }            
}