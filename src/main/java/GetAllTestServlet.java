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

@WebServlet("/getAllTestServlet")
public class GetAllTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        Connection connection = DBConnection.getConnection();
        StringBuilder resultTable = new StringBuilder();
        resultTable.append("<table id=\"datatablesSimple\" class=\"table table-striped\" >");
        resultTable.append(
                "<thead><tr><th>Test ID</th><th>Test Name</th><th>Test Duration</th><th>Start Time</th><th>End Time</th><th>Test Discription</th></tr></thead>");

        try {
            Statement stat = connection.createStatement();
            ResultSet resultSet = stat.executeQuery("SELECT * FROM onlinetest.Test");
            while (resultSet.next()) {
                String test_id = resultSet.getString(1);
                resultTable.append("<tr><td> <a href='#' onclick=\"loadTest(" + test_id + ")\">" + test_id
                        + "</a> </td><td>"
                        + resultSet.getString(2)
                        + "</td><td>" + resultSet.getString(3)
                        + "</td><td>" + resultSet.getString(4) + "</td><td>"
                        + resultSet.getString(5) + "</td><td>" + resultSet.getString(6) + "</td></tr>");

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
