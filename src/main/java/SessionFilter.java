/*
 * import java.io.IOException;
 * 
 * import jakarta.servlet.Filter;
 * import jakarta.servlet.FilterChain;
 * import jakarta.servlet.FilterConfig;
 * import jakarta.servlet.ServletException;
 * import jakarta.servlet.ServletRequest;
 * import jakarta.servlet.ServletResponse;
 * import jakarta.servlet.annotation.WebFilter;
 * import jakarta.servlet.http.HttpServletRequest;
 * import jakarta.servlet.http.HttpServletResponse;
 * import jakarta.servlet.http.HttpSession;
 * 
 * @WebFilter("/*")
 * public class SessionFilter implements Filter {
 * 
 * @Override
 * public void init(FilterConfig filterConfig) throws ServletException {
 * // Initialization code, if needed
 * }
 * 
 * @Override
 * public void doFilter(ServletRequest request, ServletResponse response,
 * FilterChain chain)
 * throws IOException, ServletException {
 * HttpServletRequest httpRequest = (HttpServletRequest) request;
 * HttpServletResponse httpResponse = (HttpServletResponse) response;
 * 
 * // Check if the user is logged in by inspecting the session
 * HttpSession session = httpRequest.getSession(false); // Do not create a new
 * session if it doesn't exist
 * boolean isLoggedIn = (session != null && session.getAttribute("userID") !=
 * null);
 * 
 * if (isLoggedIn) {
 * // User is logged in, allow the request to proceed
 * System.out.println("inside the filter servlet valid session");
 * chain.doFilter(request, response);
 * } else {
 * System.out.println("inside the filter servlet invalid session");
 * // User is not logged in, redirect to the login page
 * // httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
 * chain.doFilter(request, response);
 * }
 * }
 * 
 * @Override
 * public void destroy() {
 * // Cleanup code, if needed
 * }
 * }
 * 
 */