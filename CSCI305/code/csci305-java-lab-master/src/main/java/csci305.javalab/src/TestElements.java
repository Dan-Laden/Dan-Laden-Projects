public class TestElements {

  public static void main(String args[]) {
    Element rock = new Rock("Rock");
    Element paper = new Paper("Paper");
    System.out.println(rock.compareTo(paper).outcome + " - - " + rock.compareTo(paper).result);
    System.out.println(paper.compareTo(rock).outcome + " - - " + paper.compareTo(rock).result);
    System.out.println(rock.compareTo(rock).outcome + " - - " + rock.compareTo(rock).result);
  }
}