package com.tech.blog.servlet;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

//            fetch all data
            String username = request.getParameter("user_name");
            String useremail = request.getParameter("user_email");
            String userabout = request.getParameter("user_about");
            String userpassword = request.getParameter("user_password");
            Part p = request.getPart("image");
            String imageName = p.getSubmittedFileName();

//            get the user form the session
            HttpSession s = request.getSession();
            User user = (User) s.getAttribute("currentUser");

            user.setEmail(useremail);
            user.setName(username);
            user.setPassword(userpassword);
            user.setAbout(userabout);
            String oldFile=user.getProfile();
            user.setProfile(imageName);
            //            update database....
            UserDao  ud = new UserDao(ConnectionProvider.getConnection());
            if(ud.UpdateUser(user)){
               
                String path=request.getSession().getServletContext().getRealPath("/")+"Pic"+File.separator+user.getProfile();
//                delete code
                String patholdFile=request.getSession().getServletContext().getRealPath("/")+"Pic"+File.separator+oldFile;
                if(!oldFile.equals("default.png")){
                
                Helper.deleteFile(patholdFile);
                }
                   if( Helper.SaveFile(p.getInputStream(), path)){
                        Message msg=new Message("Profile details Updated","success","alert-success");
                    s.setAttribute("msg", msg);
                   }else{
                       
                         Message msg=new Message("Something went wrong... ! ","error","alert-danger");
                    
                    
                    s.setAttribute("msg", msg);
            }   
            }else{
                 Message msg=new Message("Something went wrong... ! ","error","alert-danger");
                    
                    
                    s.setAttribute("msg", msg);
            }
            response.sendRedirect("profile.jsp");
            

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
