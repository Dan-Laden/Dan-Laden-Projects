/**
 * @author Daniel Laden
 * @email dthomasladen@gmail.com
 */
public class Outcome {
    public String outcome;
    public String result;
    
    public Outcome(String elem1, String elem2){
        if (elem1.equals("Rock")){
                if (elem2.equals("Scissors") || elem2.equals("Lizard")){this.outcome = elem1 + " crushes " + elem2;this.result = "Win";}
                else if (elem2.equals("Paper")){this.outcome = elem2 + " covers " + elem1;this.result = "Lose";}
                else if (elem2.equals("Spock")){this.outcome = elem2 + " vaporizes " + elem1;this.result = "Lose";}}
        else if(elem1.equals("Paper")){
                if (elem2.equals("Rock")){this.outcome = elem1 + " covers " + elem2;this.result = "Win";}
                else if (elem2.equals("Spock")){this.outcome = elem1 + " disproves " + elem2;this.result = "Win";}
                else if (elem2.equals("Scissors")){this.outcome = elem2 + " cut " + elem1;this.result = "Lose";}
                else if (elem2.equals("Lizard")){this.outcome = elem2 + " eats " + elem1;this.result = "Lose";}}
        else if(elem1.equals("Scissors")){
                if (elem2.equals("Paper")){this.outcome = elem1 + " cut" + elem2;this.result = "Win";}
                else if (elem2.equals("Lizard")){this.outcome = elem1 + " decapitate " + elem2;this.result = "Win";}
                else if (elem2.equals("Spock")){this.outcome = elem2 + " smashes " + elem1;this.result = "Lose";}
                else if (elem2.equals("Rock")){this.outcome = elem2 + " crushes " + elem1;this.result = "Lose";}}
        else if(elem1.equals("Lizard")){
                if (elem2.equals("Spock")){this.outcome = elem1 + " poisons " + elem2;this.result = "Win";}
                else if (elem2.equals("Paper")){this.outcome = elem1 + " eats " + elem2;this.result = "Win";}
                else if (elem2.equals("Scissors")){this.outcome = elem2 + " decapitate " + elem1;this.result = "Lose";}
                else if (elem2.equals("Rock")){this.outcome = elem2 + " crushes " + elem1;this.result = "Lose";}}
        else if(elem1.equals("Spock")){
                if (elem2.equals("Rock")){this.outcome = elem1 + " vaporizes " + elem2;this.result = "Win";}
                else if (elem2.equals("Scissors")){this.outcome = elem1 + " smashes " + elem2;this.result = "Win";}
                else if (elem2.equals("Paper")){this.outcome = elem2 + " disproves " + elem1;this.result = "Lose";}
                else if (elem2.equals("Lizard")){this.outcome = elem2 + " poisons " + elem1;this.result = "Lose";}}
        else{throw new UnsupportedOperationException("Unable to find entered type");}
        if(elem1.equals(elem2)){this.outcome = elem1 + " equals " + elem2; this.result = "Tie";}
    }
}
