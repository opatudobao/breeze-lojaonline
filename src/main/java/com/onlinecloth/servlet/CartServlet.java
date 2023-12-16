package com.onlinecloth.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.onlinecloth.dao.CartDaoImp;
import com.onlinecloth.dao.ProductDaoImp;
import com.onlinecloth.pojo.Cart;
import com.onlinecloth.pojo.Product;
import com.onlinecloth.pojo.User;

/**
 * Servlet implementation class CartServlet
 * pacote Java que faz parte da API Servlet, uma tecnologia Java utilizada para desenvolver aplicativos
 * web. Servlets são classes Java que estendem as capacidades de servidores web para gerar dinamicamente
 * conteúdo e interagir com os pedidos dos clientes 
 */
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String action=request.getParameter("action");
		HttpSession session=request.getSession();
		
		if(action.equals("delete"))
		{
			int cartId=Integer.parseInt(request.getParameter("cartId"));
			boolean flag=false;
			
			flag=new CartDaoImp().deleteCartById(cartId);
			if(flag==true)
			{
				session.setAttribute("message","Produto deletado!");
		        response.sendRedirect("index.jsp"); 	
			}
			
			else
			{
				session.setAttribute("message","Falha ao deletar!");
		        response.sendRedirect("index.jsp"); 
			}
			
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		HttpSession session=request.getSession();
		String action=request.getParameter("action");
		
		if(action.equals("addToCart"))
		{
			User user=(User)session.getAttribute("active-user");
			int userId=user.getUserId();
			int productId=Integer.parseInt(request.getParameter("productId"));
			int quantity=Integer.parseInt(request.getParameter("quantity"));
			String size=request.getParameter("size");
			Product product=new ProductDaoImp().getProductById(productId);
			int productActualQuantity=product.getProductQuantity();
			
			if(quantity>productActualQuantity)
			{
				session.setAttribute("message","Only "+productActualQuantity+" O item está disponível agora:(");
		        response.sendRedirect("index.jsp");
			}
			
			else
			{
				
			boolean check=new CartDaoImp().alreadyAvailableInCart(productId, userId,size);
			if(check==false)
			{
				Cart cart=new Cart(userId,productId,quantity);
				cart.setProductSize(size);
			    boolean flag=new CartDaoImp().addToCart(cart);
			    if(flag==true)
			    {
			    	session.setAttribute("message","Produto adicionado com sucesso");
			        response.sendRedirect("index.jsp");
			    }
			    
			   else
			    {
			    	session.setAttribute("message","Falha ao adicionar o produto");
			        response.sendRedirect("index.jsp");
			    }  
			}
			
			else
			{
				
				int finalQuantity=new CartDaoImp().getPreviousQuantityFromCart(productId, userId,size)+quantity;
				Product p=new ProductDaoImp().getProductById(productId);				
				Cart cart=new Cart(userId,productId,finalQuantity);
				cart.setProductSize(size);
				boolean flag=new CartDaoImp().updateCart(cart);
				
				if(flag==true)
			    {
			    	session.setAttribute("message","Produto adicionado com sucesso");
			        response.sendRedirect("index.jsp");
			    }
			    
			    else
			    {
			    	session.setAttribute("message","Falha ao adicionar produto");
			        response.sendRedirect("index.jsp");
			    } 
			}
			
	   	  } 
		}
		
	}

}