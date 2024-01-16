import java.util.ArrayList;
import java.util.Arrays;

public class Scratch {
    public static void main(String[] args) {
        String inputStr = "[[\"1\",\"3\"],[\"2\"],[\"1\",\"2\"]]";
        inputStr = inputStr.replace("[", "{")
                .replace("]", "}")
                .replace("\"", "");
        System.out.println("the user selected answer after int = " + inputStr);

        int[] selectedAnswer = { 1, 3 };
        System.out.println("the user selected answer after int = " + selectedAnswer[0] + " :: " + selectedAnswer[1]);

        String examplStr = inputStr;
        String[] splitArray = inputStr.split("},");
        System.out.println("the user selected answer after int = " + splitArray.length);

        String[] finalStrArray = new String[splitArray.length];

        int i = 0;
        for (String item : splitArray) {

            System.out.println(item);
            item = item.replace("{", "").replace("}", "");
            System.out.println(item);
            int[] finalArray = Arrays.stream(item.split(",")).mapToInt(Integer::parseInt).toArray();
            finalStrArray[i] = Arrays.toString(finalArray);
            System.out
                    .println("the user selected answer after int = " + finalArray.length + " :: [0]=" + finalArray[0]);
            i++;
        }
        ArrayList<String> selectedAnswerList = new ArrayList<>();
        selectedAnswerList.addAll(Arrays.asList(finalStrArray));
        System.out.println(" selectedAnswerList = " + selectedAnswerList);
    }
}
