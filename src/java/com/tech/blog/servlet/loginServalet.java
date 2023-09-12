
package com.tech.blog.servlet;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class loginServalet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet loginServalet</title>");
            out.println("</head>");
            out.println("<body>");

//            login
//fetch userName and password from request
            String check = request.getParameter("check");

            if (check == null) {
                 out.println("box not check");
            } else {
                String useremail = request.getParameter("email");
                String userpassword = request.getParameter("password");
                
                UserDao dao = new UserDao(ConnectionProvider.getConnection());

                User u = dao.getUserByEmailAndPassword(useremail, userpassword);
                
                if(u==null){
                    // login error

                    Message msg=new Message("Invalid details ! try with anthor","error","alert-danger");
                    
                    HttpSession s=request.getSession();
                    s.setAttribute("msg", msg);
                    
                    response.sendRedirect("login_page.jsp");
                    

                }else{
                    HttpSession s=request.getSession();
                    s.setAttribute("currentUser", u);
                   response.sendRedirect("profile.jsp");
                            
                }
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
