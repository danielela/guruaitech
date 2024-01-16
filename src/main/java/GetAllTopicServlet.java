import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GetAllTopicServlet")
public class GetAllTopicServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        Connection connection = DBConnection.getConnection();
        StringBuilder resultTable = new StringBuilder();
        resultTable.append("<table class=\"table table-striped\" >");
        resultTable.append(
                "<thead><tr><th>Topic ID</th><th>Topic Name</th></tr></thead>");

        try {
            Statement stat = connection.createStatement();
            ResultSet resultSet = stat.executeQuery("SELECT * FROM onlinetest.Topics");
            while (resultSet.next()) {
                String topic_id = resultSet.getString(1);
                resultTable.append("<tr><td> <a href='#' onclick=\"loadTopic(" + topic_id + ")\">" + topic_id
                        + "</a> </td><td>"
                        + resultSet.getString(2)
                        + "</td></tr>");

            }
            resultTable.append("</table>");
            System.out.println(resultTable);
            out.print(resultTable);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

}
