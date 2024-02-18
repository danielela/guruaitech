import java.io.IOException;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/EmailSender")
public class EmailSender extends HttpServlet {

    public void sendEmail(String email, String subject, String message) {
        // Send email
    }

    // create a doPost method and accept the email, subject and message as
    // parameters
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession httpSession = request.getSession(false); // true create new session
        String email = request.getParameter("user_name");
        System.out.println("Email: " + email);
        String senderEmail = "admin@guruaitech.com";
        String senderPassword = "Gracie22012#";

        // Recipient email address
        String recipientEmail = "daniel.elavarasan@gmail.com";

        // Email server settings
        String incomingServer = "mail.guruaitech.com";
        int imapPort = 143;
        int pop3Port = 110;
        String outgoingServer = "mail.guruaitech.com";
        int smtpPort = 587;

        // Email properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", outgoingServer);
        props.put("mail.smtp.port", smtpPort);

        // Create session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            // Create a default MimeMessage object
            Message message = new MimeMessage(session);

            // Set From: header field of the header
            message.setFrom(new InternetAddress(senderEmail));

            // Set To: header field of the header
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(recipientEmail));

            // Set Subject: header field
            message.setSubject("One-Time Passcode");

            // Set HTML content
            String otp = "123456"; // Replace with your actual OTP
            String htmlContent = generateHtmlContent(otp);
            message.setContent(htmlContent, "text/html");

            // Send the message
            Transport.send(message);

            System.out.println("Email sent successfully!");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);

    }

    private String generateHtmlContent(String otp) {
        return "<!DOCTYPE html>\n" +
                "<html xmlns:th=\"http://www.thymeleaf.org\">\n" +
                "<head>\n" +
                "    <title>Email Template</title>\n" +
                "    <link href=\"http://localhost:8080/css/bootstrap.min.css\" rel=\"stylesheet\">\n" +
                "    <style>\n" +
                "        .container {\n" +
                "            display: flex;\n" +
                "            flex-direction: column;\n" +
                "            align-items: center;\n" +
                "            justify-content: center;\n" +
                "            height: 100vh;\n" +
                "        }\n" +
                "        .rounded-box {\n" +
                "            border: 1px solid #000000;\n" +
                "            position: -50px -50px;\n" +
                "            border-radius: 10px;\n" +
                "            padding: 10px;\n" +
                "            background-color: #b29e9e;\n" +
                "            text-align: center; /* Added property */\n" +
                "        }\n" +
                "        .header {\n" +
                "            border-radius: 10px;\n" +
                "        }\n" +
                "\n" +
                "        .contact-form {\n" +
                "            background: #f3f0ef;\n" +
                "        }\n" +
                "    </style>\n" +
                "</head>\n" +
                "<body>\n" +
                "    <div class=\"container\">\n" +
                "        <a href=\"index.jsp\" class=\"navbar-brand header bg-primary\">\n" +
                "            <h1 class=\"fw-bold d-block custom-heading\">Guru AI Tech., </h1>\n" +
                "        </a>\n" +
                "        <div class=\"rounded-box contact-form\">\n" +
                "            <p>Your one-time passcode is: 123<strong th:text=\"" + otp + "\"></strong></p>\n" +
                "            <a href=\"http://localhost:8080/reset_password.jsp?email=daniel.elavarasan@gmail.com\" style=\"display: inline-block; padding: 10px 20px; background-color: #1890c3; color: #fff; text-decoration: none;\">Reset Password</a>\n"
                +
                "            <p>Thank you!</p>\n" +
                "        </div>\n" +
                "    </div>\n" +
                "</body>\n" +
                "</html>";
    }

}
