package Outlab6;

import java.util.*;

public class Battleship {
	
	int [][] rowColSize;
	int [][] GuessArray;
	Scanner in = new Scanner(System.in);
	int tries = 0;
	int hit = 0;
	int infiniteLoop = 0;

	public Battleship(int rowSize, int colSize)
	{
		rowColSize = new int [rowSize][colSize];
		GuessArray = new int [rowSize][colSize];
		
		int colNum = 0;
		int rowNum = 0;
		
		for(; rowNum < rowSize; rowNum++)
		{
			for(; colNum < colSize; colNum++)
			{
				rowColSize[rowNum][colNum] = 0;
			}
			colNum = 0;
			
		}
	}
public void setBoard()
{
	try{
		Random r = new Random();
		int x_axis = 0;
		int y_axis = 0;
		int horz_or_virt = 0;

		//Need a TryCatch for infinite loops
		for(int shipNum = 2; shipNum <= 5; shipNum++)
		{
			y_axis = r.nextInt(rowColSize.length);
			x_axis = r.nextInt(rowColSize[0].length);
			horz_or_virt = r.nextInt(2);
			int loop = 0;
			infiniteLoop++;
		
			try
			{
				for(; loop < shipNum; loop++)
				{
					if(horz_or_virt == 0)
					{
						if(rowColSize[y_axis][x_axis + loop] == 0)
						{
							rowColSize[y_axis][x_axis + loop] = shipNum;
						}
						else
						{
							throw new BattleshipContainsException();
						}
					}
					else
					{
						if(rowColSize[y_axis + loop][x_axis] == 0)
						{
							rowColSize[y_axis + loop][x_axis] = shipNum;
						}
						else
						{
							throw new BattleshipContainsException();
						}
					}
				}
			}
			catch(BattleshipContainsException ex)
			{
				loop--;
				for(; loop >= 0; loop--)
				{
					if(horz_or_virt == 0)
					{
						if(rowColSize[y_axis][x_axis + loop] == shipNum)
						{
							rowColSize[y_axis][x_axis + loop] = 0;
						}
					}
					else
					{
						if(rowColSize[y_axis + loop][x_axis] == shipNum)
						{
							rowColSize[y_axis + loop][x_axis] = 0;
						}
					}
				}
				shipNum--;

			}
			catch(ArrayIndexOutOfBoundsException ex)
			{
				loop--;
				for(; loop >= 0; loop--)
				{
					if(horz_or_virt == 0)
					{
						if(rowColSize[y_axis][x_axis + loop] == shipNum)
						{
							rowColSize[y_axis][x_axis + loop] = 0;
						}
					}
					else
					{
						if(rowColSize[y_axis + loop][x_axis] == shipNum)
						{
							rowColSize[y_axis + loop][x_axis] = 0;
						}
					}
				}
				shipNum--;
			}
			if(infiniteLoop >= 10000000)
			{
				throw new RuntimeException();
			}
		}
	}
	catch(RuntimeException ex)
	{
		System.out.println("System has run into an error. \nThis could be caused by either: \nA board too small to generate on.\nA board that is too improbably to allow generation. \n\nPlease try to run the program again.\n");
	}
}
	public void printBoard(boolean reveal)
	{
		for(int i = 1; i <= rowColSize.length; i++)
		{
			System.out.print("  +");

			for(int j = 1; j <= rowColSize[0].length; j++)
			{
				System.out.print("-+");
			}
				
			System.out.println("");
				
			System.out.print(i + " ");
			for(int k = 0; k < rowColSize[0].length; k++)
			{
				if(reveal == true)
				{
					System.out.print("|" + rowColSize[i-1][k]);
				}
				else
				{
					//Check if the hit missed or not and return something for that spot
					if(GuessArray[i-1][k] == 1)
					{
						System.out.print("|0");
					}
					else if(GuessArray[i-1][k] == 2)
					{
						System.out.print("|" + rowColSize[i-1][k]);
					}
					else
					{
					System.out.print("| ");
					}
				}
			}
			System.out.println("|");
		}
		
		System.out.print("  +");
		for(int j = 1; j <= rowColSize[0].length; j++)
		{
			System.out.print("-+");
		}
		System.out.println("");
		
		System.out.print("  ");
		for(int i = 1; i <= rowColSize[0].length; i++)
		{
			System.out.print(" " + i);
		}
		System.out.println(" \n");
	}
	public boolean over()
	{
		if(hit == 14)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	public void makeGuess()
	{
		
		System.out.print("Please enter a row: ");
		int userRow = in.nextInt();
		userRow--;
		System.out.print("Please enter a colume: ");
		int userCol = in.nextInt();
		userCol--;
		tries++;
		
		try
		{
			if(GuessArray[userRow][userCol] == 0)
			{
				GuessArray[userRow][userCol] = 1;
			}
			else
			{
				throw new GuessedArrayError();
			}
			if(rowColSize[userRow][userCol] != 0)
			{
				System.out.print("Hit!  ");
				if(rowColSize[userRow][userCol] == 2)
				{
					System.out.println("You just hit the Patrol Boat \n");
				}
				else if(rowColSize[userRow][userCol] == 3)
				{
					System.out.println("You just hit the Submarine \n");
				}
				else if(rowColSize[userRow][userCol] == 4)
				{
					System.out.println("You just hit the Battleship \n");
				}
				else
				{
					System.out.println("You just hit the Carrier \n");
				}
				GuessArray[userRow][userCol] = 2;
				hit++;
			}
			else
			{
				System.out.println("Miss!  There was nothing at that location \n");
			}
		}
		catch(ArrayIndexOutOfBoundsException ex)
		{
			if(userRow > GuessArray.length || userRow < 0)
			{
				System.out.println("Error: Invalid row. \n");
			}
			else
			{
				System.out.println("Error: Invalid column. \n");
			}
			
		}
		catch(GuessedArrayError ex)
		{
			System.out.println("You already guessed that location! \n");
		}
		catch(InputMismatchException ex)
		{
			System.out.println("Error.  You did not enter an integer value.  Please try again. \n");
		}
			
	}
	public void printStatistics()
	{
		System.out.println("It took you " + tries + " tries to win");
	}
	
}

class BattleshipContainsException extends Exception
{
	/**
	 * This is used to catch custom errors like other ships in the way
	 */

	public BattleshipContainsException(){}
	
	public BattleshipContainsException(String message)
	{
		super(message);
	}
}
class GuessedArrayError extends Exception
{
	/**
	 * This is used to catch custom errors like other ships in the way
	 */

	public GuessedArrayError(){}
	
	public GuessedArrayError(String message)
	{
		super(message);
	}
}
