import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;
import org.thymeleaf.templatemode.TemplateMode;
import org.thymeleaf.templateresolver.ClassLoaderTemplateResolver;

import javax.mail.Authenticator;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.Scanner;

import javax.mail.Session;

@WebServlet("/send-email")
public class ThymeleafEmailServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String toEmail = request.getParameter("toEmail");
        String otp = generateOTP(); // Implement your OTP generation logic here

        // Process Thymeleaf template
        String htmlContent = processThymeleafTemplate("email-template.html", otp);
        System.out.println("final HTML content: " + htmlContent);
        // Send the email
        try {
            sendEmail(toEmail, htmlContent);
            response.getWriter().write("Email sent successfully!");
        } catch (MessagingException e) {
            throw new ServletException("Error sending email", e);
        }
    }

    private String processThymeleafTemplate(String templateName, String otp) {
        ClassLoaderTemplateResolver templateResolver = new ClassLoaderTemplateResolver();
        templateResolver.setTemplateMode(TemplateMode.HTML);
        templateResolver.setPrefix("templates/"); // Adjust the path based on your project structure
        templateResolver.setSuffix(".html");
        templateResolver.setCharacterEncoding(StandardCharsets.UTF_8.name());

        TemplateEngine templateEngine = new TemplateEngine();
        templateEngine.setTemplateResolver(templateResolver);

        templateEngine.getTemplateResolvers().stream()
                .forEach(template -> System.out.println(" the template name " + template.getName()));

        Context context = new Context();
        context.setVariable("otp", otp);
        System.out.println("template name : " + templateName);
        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream("templates/" + templateName)) {
            if (inputStream != null) {
                try (Scanner scanner = new Scanner(inputStream, StandardCharsets.UTF_8.name())) {
                    String content = scanner.useDelimiter("\\A").next();
                    System.out.println("Template content: " + content);
                    return templateEngine.process(content, context);
                }
            } else {
                throw new RuntimeException("Template not found: " + templateName);
            }
        } catch (Exception e) {
            throw new RuntimeException("Error reading template", e);
        }
    }

    private void sendEmail(String toEmail, String htmlContent) throws MessagingException {
        // Email server settings
        String outgoingServer = "mail.guruaitech.com";
        int smtpPort = 587;

        String senderEmail = "admin@guruaitech.com";
        String senderPassword = "Gracie22012#";
        // Email properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", outgoingServer);
        props.put("mail.smtp.port", smtpPort);

        // Create session with authentication
        // Create session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        // Create MimeMessage
        MimeMessage mimeMessage = new MimeMessage(session);

        // Set From: header field of the header
        mimeMessage.setFrom(new InternetAddress("admin@guruaitech.com"));

        // Set To: header field of the header
        mimeMessage.setRecipients(javax.mail.Message.RecipientType.TO,
                InternetAddress.parse(toEmail));

        // Set Subject: header field
        mimeMessage.setSubject("Your One-Time Passcode");

        // Set HTML content
        mimeMessage.setContent(htmlContent, "text/html");

        // Send the email
        Transport.send(mimeMessage);
    }

    private String generateOTP() {
        // Implement your OTP generation logic here
        return "123456";
    }
}
