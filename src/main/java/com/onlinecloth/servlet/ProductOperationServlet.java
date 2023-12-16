package com.onlinecloth.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import com.onlinecloth.dao.ClothDaoImp;
import com.onlinecloth.dao.ProductDaoImp;
import com.onlinecloth.pojo.Cloth;
import com.onlinecloth.pojo.Product;
/**
 * Servlet implementation class ProductOperationServlet
 */
@MultipartConfig
@WebServlet("/ProductOperationServlet")
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductOperationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String action = request.getParameter("action");
		HttpSession session = request.getSession();

		if (action.equals("delete")) {
		    int productId = Integer.parseInt(request.getParameter("productId"));
		    Product product = new ProductDaoImp().getProductById(productId);
		    String productImage = product.getProductPhoto();
		    File f = new File("C:\\Users\\Aline Palmieri\\Documents\\Store Online\\loja-online\\src\\main\\webapp\\userProfilePic\\" + productImage);

		    f.delete();
		    boolean flag=false;

		    flag=new ProductDaoImp().deleteProductById(productId);
			if(flag==true)
			{
		        session.setAttribute("message", "Produto deletado com sucesso!");
		        response.sendRedirect("index.jsp");
		    } else {
		        session.setAttribute("message", "Falha ao deletar!");
		        response.sendRedirect("index.jsp");
		    }

		} else if (action.equals("deleteCategory")) {
		    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
		    int totalProduct = new ProductDaoImp().getTotalProductOfCategoryById(categoryId);
		    if (totalProduct > 0) {
		        List<Product> products = new ProductDaoImp().getProductByCategory(categoryId);
		        for (Product p : products) {
		            File f = new File("C:\\Users\\Aline Palmieri\\Documents\\Store Online\\loja-online\\src\\main\\webapp\\userProfilePic\\" + p.getProductPhoto());
		            f.delete();
		        }

		        boolean flag = new ProductDaoImp().deleteProductByCategoryId(categoryId);
		        if (flag) {
		            
		            session.setAttribute("message", "Categoria deletada!");
		            response.sendRedirect("index.jsp");
		        } else {
		            session.setAttribute("message", "Falha ao deletar!");
		            response.sendRedirect("index.jsp");
		        }
		    } else {
		        
		        session.setAttribute("message", "Categoria deletada!");
		        response.sendRedirect("index.jsp");
		    }
		}

		
		else if(action.equals("deleteCloth"))
		{
			int clothId=Integer.parseInt(request.getParameter("clothId"));
			int totalProduct=new ProductDaoImp().getTotalProductOfClothById(clothId);
			if(totalProduct>0)
			{
			    List<Product> product=new ProductDaoImp().getProductByCloth(clothId);
			    for(Product p:product)
			    {
			    	  File f=new File("C:\\Users\\Aline Palmieri\\Documents\\Store Online\\loja-online\\src\\main\\webapp\\userProfilePic\\"+p.getProductPhoto());
					
					  f.delete();
					  
			    }
				boolean flag=new ProductDaoImp().deleteProductByClothId(clothId);
				if(flag==true)
				{
					boolean f=new ClothDaoImp().deleteClothById(clothId);
					if(f==true)
					{
						session.setAttribute("message","Categoria deletada!");
				        response.sendRedirect("index.jsp"); 	
					}
					
					else
					{
						session.setAttribute("message","Falha ao deletar!");
				        response.sendRedirect("index.jsp"); 
					}
				}
				
				else
				{
					session.setAttribute("message","Falha ao deletar!");
			        response.sendRedirect("index.jsp"); 
				}
			}
			
			
			
			else
			{
				
				boolean f=new ClothDaoImp().deleteClothById(clothId);
				if(f==true)
				{
					
					session.setAttribute("message","Deletado com sucesso!");
			        response.sendRedirect("index.jsp"); 	
				}
				
				else
				{
					session.setAttribute("message","Falha ao deletar categoria!");
			        response.sendRedirect("index.jsp"); 
				} 
			}
		}
		
		
		
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    String action = request.getParameter("action");
	    HttpSession session = request.getSession();

	    if (action.equals("addCloth")) {
	        String clothTitle = request.getParameter("clothTitle");
	        String clothDescription = request.getParameter("clothDescription");

	        Cloth cloth = new Cloth(clothTitle, clothDescription);
	        ClothDaoImp clothDaoImp = new ClothDaoImp();
	        boolean flag = clothDaoImp.addCloth(cloth);

	        if (flag) {
	            session.setAttribute("message", "Roupa adicionada!");
	            response.sendRedirect("admin.jsp");
	        } else {
	            session.setAttribute("message", "Falha ao adicionar!");
	            response.sendRedirect("admin.jsp");
	        }
	    } else if (action.equals("addProduct")) {
	        String productTitle = request.getParameter("productTitle");
	        String productDescription = request.getParameter("productDescription");
	        int productQuantity = Integer.parseInt(request.getParameter("productQuantity"));
	        int productClothId = Integer.parseInt(request.getParameter("productClothId"));
	        String productFor = request.getParameter("productFor");
	        Part part = request.getPart("productPic");
	        String fileName = part.getSubmittedFileName();
	        String uploadPath = "C:\\Users\\Aline Palmieri\\Documents\\Store Online\\loja-online\\src\\main\\webapp\\userProfilePic\\" + fileName;

	        try (FileOutputStream fos = new FileOutputStream(uploadPath);
	             InputStream is = part.getInputStream()) {

	            byte[] data = new byte[is.available()];
	            is.read(data);
	            fos.write(data);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        Product product = new Product(productQuantity, productClothId, productTitle, productDescription, fileName);
	        

	        ProductDaoImp pdao = new ProductDaoImp();
	        boolean flag = pdao.addProduct(product);

	        if (flag) {
	            session.setAttribute("message", "Produto adicionado");
	            response.sendRedirect("admin.jsp");
	        } else {
	            session.setAttribute("message", "Falha ao adicionar");
	            response.sendRedirect("admin.jsp");
	        }
	    } else if (action.equals("updateProduct")) {
	        boolean flag = false;
	        int productId = Integer.parseInt(request.getParameter("productId"));
	        String productTitle = request.getParameter("productTitle");
	        String productDescription = request.getParameter("productDescription");
	        String productQuantity = request.getParameter("productQuantity");
	        Part part = request.getPart("productPhoto");

	        String fileName = part.getSubmittedFileName();
	        String uploadPath = "C:\\Users\\Aline Palmieri\\Documents\\Store Online\\loja-online\\src\\main\\webapp\\userProfilePic\\" + fileName;

	        try (FileOutputStream fos = new FileOutputStream(uploadPath);
	             InputStream is = part.getInputStream()) {

	            byte[] data = new byte[is.available()];
	            is.read(data);
	            fos.write(data);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        Product product = new Product();
	        product.setProductId(productId);
	        product.setProductQuantity(Integer.parseInt(productQuantity));
	        product.setProductTitle(productTitle);
	        product.setProductDescription(productDescription);
	        product.setProductPhoto(fileName);

	        ProductDaoImp pdao = new ProductDaoImp();
	        flag = pdao.updateProduct(product);

	        if (flag) {
	            session.setAttribute("message", "Produto adicionado com sucesso!");
	            response.sendRedirect("index.jsp");
	        } else {
	            session.setAttribute("message", "Falha ao adicionar produto.");
	            response.sendRedirect("index.jsp");
	        }
	    }

		
		else if(action.equals("searchSmartly"))
		{
			RequestDispatcher rd;
			String productFor=request.getParameter("productFT");
			String clothId=request.getParameter("clothId");		
			
			
			request.setAttribute("prodFor",productFor);
			request.setAttribute("cId",clothId);
			
			rd=request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);   	
			
		}
		
		
	}

}