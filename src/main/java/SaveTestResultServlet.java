import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/saveTestResultServlet")
public class SaveTestResultServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        System.out.println("inside the Save Test Result Servlet");
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        // Retrieve parameters from the request
        String userID = request.getParameter("userID");
        String testID = request.getParameter("testID");
        // String attemptID = request.getParameter("attemptID");
        String score = request.getParameter("score");
        String correctCount = request.getParameter("correctCount");
        String timeSpent = request.getParameter("timeSpent");

        // get user selectedAnswer
        String userSelectedAnswer = request.getParameter("userSelectedAnswer");
        System.out.println("the user selected answer " + userSelectedAnswer);

        // Step 2: Create an ArrayList
        ArrayList<String> selectedAnswerList = new ArrayList<>();

        // Step 3: Add each element to the ArrayList
        // selectedAnswerList.addAll(Arrays.asList(array));
        selectedAnswerList = convertArrayList(userSelectedAnswer);

        // Print the ArrayList
        System.out.println("ArrayList selectedAnswerList: " + selectedAnswerList);

        System.out.println("userID=" + userID + "\ntestID=" + testID + "\ncorrectCount="
                + correctCount + "\ntimeSpent=" + timeSpent + " \n score=" + score);

        Connection connection = DBConnection.getConnection();
        try {
            PreparedStatement statement = connection.prepareStatement(
                    "INSERT INTO onlinetest.TestAttempts(`user_id`, `test_id`, `score`, `correct_count`, `time_spent`) VALUES (?,?,?,?,?)");

            statement.setInt(1, Integer.parseInt(userID));
            statement.setInt(2, Integer.parseInt(testID));
            statement.setInt(3, (int) Double.parseDouble(score)); // Convert score to whole number
            statement.setInt(4, Integer.parseInt(correctCount));
            statement.setInt(5, Integer.parseInt(timeSpent));

            int executeUpdate = statement.executeUpdate();
            if (executeUpdate > 0) {
                System.out.println("Successfuly inserted login");
                // select query to get attemptID
                // save to UserAnswer Table methdo()
                String attemptID = getAttemptID(userID, testID);
                Test testObj = (Test) session.getAttribute("test");
                List<String> questionList = testObj.getTest_questions();
                saveUserAnswer(attemptID, userID, questionList, selectedAnswerList);
                out.print("saved success");
            } else {
                out.print("failed");
            }

        } catch (Exception e) {
            System.err.println("exception while saving to DB");
            e.printStackTrace();
        }

    }

    private ArrayList<String> convertArrayList(String inputAnswer) {
        inputAnswer = inputAnswer.replace("[", "{")
                .replace("]", "}")
                .replace("\"", "");
        System.out.println("the user selected answer after int = " + inputAnswer);

        String[] splitArray = inputAnswer.split("},");
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
        return selectedAnswerList;
    }

    public String getAttemptID(String userid, String testid) {
        int attemptID = 0;
        // sql Attepth Table
        // select max(attempid()) from attempts;

        String query = "SELECT MAX(attempt_id) FROM onlinetest.TestAttempts where user_id=" + userid
                + " and test_id=" + testid;

        try {
            // Create a connection to the database
            Connection conn = DBConnection.getConnection();

            // Create a statement object
            Statement stmt = conn.createStatement();

            // Execute the query and get the result set
            ResultSet rs = stmt.executeQuery(query);

            // Retrieve the attemptID value from the result set
            if (rs.next()) {
                attemptID = rs.getInt(1);
                System.out.println("Attempt ID: " + attemptID);
            }

            // Close the resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // return attemptID + "";
        return String.valueOf(attemptID); // return attemptID;
    }

    public boolean saveUserAnswer(String attempID, String userid, List<String> questionID, List<String> optionID) {
        // for loop of question array
        System.out.println(userid + " " + attempID + " " + questionID + " selected option " + optionID);
        // Create a connection to the database

        try {

            Connection conn = DBConnection.getConnection();
            String query = "INSERT INTO onlinetest.UserAnswers(attempt_id, question_id, selected_option) VALUES (?,?,?)";

            // Create a statement object
            PreparedStatement pstmt = conn.prepareStatement(query);
            for (int i = 0; i < questionID.size(); i++) {
                System.out.println("the user selected answer = " + optionID.get(i));
                pstmt.setInt(1, Integer.parseInt(attempID));
                pstmt.setInt(2, Integer.parseInt(questionID.get(i)));
                pstmt.setString(3, String.valueOf(optionID.get(i)));
                // Execute the query and get the result set
                int result = pstmt.executeUpdate();
                if (result > 0) {
                    System.out.println("Successfuly inserted answer for question " + questionID.get(i));
                } else {
                    System.out.println("Failed to insert answer for question " + questionID.get(i));
                }
            }
            // Close the resources
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return true;
    }

}
