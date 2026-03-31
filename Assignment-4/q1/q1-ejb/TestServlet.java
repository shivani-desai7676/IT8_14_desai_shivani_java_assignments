
import jakarta.annotation.Resource;
import jakarta.inject.Inject;
import jakarta.jms.Destination;
import jakarta.jms.JMSContext;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Queue;

@WebServlet("/test")
public class TestServlet extends HttpServlet {
    @Inject
    private JMSContext context;

    @Resource(lookup = "jms/myQueue")
    private Queue queue;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // This matches the format in your question
        String message = "I:emp:ename,sal,phone:'prakash',3400,234567:''";
        
        context.createProducer().send((Destination) queue, message);
        
        resp.getWriter().print("Message sent to MDB: " + message);
    }
}