/*
* @author: Dan-Laden
* Date: 4/11/2016
*/

import java.util.*;

public class Easy_guessingGame {
	
	public static void main(String[] args)
	{
		Random r = new Random();
        Scanner in = new Scanner(System.in);
		boolean gameFinish = false;
		
		System.out.println("=Guessing Game=");
		System.out.println("The point of this game is to guess a number value between 1 and 10. You have 3 tries before you lose, so try your best.");
		
		while(gameFinish == false)
		{
			boolean userInput = false;
			int computerNum = r.nextInt(10) + 1;
			int tries = 0; 
			
			for(;tries < 3; tries++)
			{
				System.out.print("Please enter a value: ");
				int userGuess = in.nextInt();
				if(computerNum == userGuess)
				{
					System.out.println("Correct!");
					tries = 3;
					gameFinish = true;
				}
				else
				{
					if(computerNum > userGuess)
					{
						System.out.println("Incorrect, your guess was too low");
					}
					else if(computerNum < userGuess)
					{
						System.out.println("Incorrect, your guess was too high");
					}
					else
					{
						System.out.println("Incorrect, are you sure you guess a number?");
					}
				}
			}
			if(tries == 3 && gameFinish == false)
			{
				in.nextLine();
				System.out.println("I'm sorry you're out of guesses would you like to try again?");
				while(userInput == false)
				{
					String userContinue = null;
					
					System.out.print("(Y/N): ");
					userContinue = in.nextLine();
					System.out.println("");
					if(userContinue.equals("Y"))
					{
						System.out.println("Continuing game in 3.....2....1...");
						userInput = true;
					}
					else if(userContinue.equals("N"))
					{
						System.out.println("Thank you for playing bye!");
						userInput = true;
						gameFinish = true;
					}
					else
					{
						System.out.println("System couldn't read user input");
						System.out.print("Try again ");
					}
				}

			}
			else
			{
				in.nextLine();
				System.out.println("Well done! Would you like to play again?");
				while(userInput == false)
				{
					String userContinue = null;
					
					System.out.print("(Y/N): ");
					userContinue = in.nextLine();
					System.out.println("");
					if(userContinue.equals("Y"))
					{
						System.out.println("Continuing game in 3.....2....1...");
						userInput = true;
						gameFinish = false;
					}
					else if(userContinue.equals("N"))
					{
						System.out.println("Thank you for playing bye!");
						userInput = true;
					}
					else
					{
						System.out.println("System couldn't read user input");
						System.out.print("Try again ");
					}
				}
			}
		}
	}

}
