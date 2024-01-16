import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet("/quizSampleServlet")
public class QuizServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        System.out.println("inside the QuizServlet *******************");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Create a list of QuizQuestion objects
        List<QuizQuestion> quizQuestions = new ArrayList<>();
        System.out.println("inside the servlet QuizServlet");
        QuizQuestion question1 = new QuizQuestion();
        question1.setQuestion("What is the main purpose of Java Virtual Machine (JVM)?");
        question1.setOptions(Arrays.asList("To provide an interpreter for Java bytecode", "To compile Java source code",
                "To manage memory in Java", "To execute Java applications"));
        question1.setCorrectAnswer("To execute Java applications");

        QuizQuestion question2 = new QuizQuestion();
        question2.setQuestion("Is Java OOPs?");
        question2.setOptions(Arrays.asList("True", "False", "Maybe", "Not sure"));
        question2.setCorrectAnswer("True");

        // Add questions to the list
        quizQuestions.add(question1);
        quizQuestions.add(question2);

        // Convert the list to JSON using Gson library
        // Gson gson = new Gson();

        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(quizQuestions);

        // String json = gson.toJson(quizQuestions);

        // Set the content type of the response to indicate that it's JSON
        response.setContentType("application/json");
        // Write the JSON response to the client
        response.getWriter().write(json);
    }
}
