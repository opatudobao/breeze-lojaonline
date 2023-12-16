<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="com.onlinecloth.pojo.*"%>
    <%@ page import ="com.onlinecloth.dao.*"%>
    <%@ page import ="java.sql.*"%>
    <%@ page import ="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=new ProductDaoImp().getProductById(Integer.parseInt(request.getParameter("productId"))).getProductTitle() %></title>
<%@ include file="components/common_cs_js.jsp"%>
<script type="text/javascript">
      function checkUser()
      {
    	  <%
    	      User u=(User)session.getAttribute("active-user"); 
    	      if(u!=null)
    	      {
    	    	  if(u.getUserType().equals("normal"))
    	    	  {
    	  %>
    	             return  true;
    	          <%
    	    	  }
    	    	  
    	    	  else
    	    	  {	  
    	    	  %>
    	    	  alert("Faça login como usuário.");
    	    	  return false;
    	    	  <%
    	    	  }
    	    	  
    	      }
    	      else
    	      {
    	  %>
    	    	  alert("Faça login para adicionar o produto ao carrinho.");
    	    	  return false;
    	  <%
    	      }
    	  %>
      }
</script>
</head>
<body>
<%@ include file="components/navbar.jsp"%>
<%@ include file="components/message.jsp"%>

<%
     int productId=Integer.parseInt((String)request.getParameter("productId"));
     Product product=new ProductDaoImp().getProductById(productId);
     String stock="Fora de estoque!"; 
     int clothId=product.getClothId();
     String productFor=product.getProductFor();
     
%>

<div class="container-fluid">
   <div class="row">
         <div class="col-md-2 mt-4" >
               <div class="card">
          
       <div class="card-header text-center">
            <h4>Pesquisa rápida</h4>
       </div>   
                              
       <div class="card-body">
        <form action="ProductOperationServlet" method="post">
        
        <input type="hidden" name="action" value="searchSmartly">
        
        
  <div class="form-group">
  
     <select class="form-control custom-bg text-center mt-3" id="cloth" name="clothId">
            <option value="0">Selecione a roupa</option>
            <%
                    for(Cloth c: cll)
                    {    	
            %> 
                         <option value="<%=c.getClothId() %>"><%=c.getClothTitle() %></option>
                              
           <%
                    }
            %>
     </select>

     <select class="form-control custom-bg text-center mt-3" id="type" name="productFT">
            <option value="0">Selecione a  categoria</option>
            <option value="Casual">Casual</option>
            <option value="Formal">Formal</option>
            <option value="Intima">Íntima</option>
            
        </select>
 
</div>
   
  <button type="submit" class="btn custom-bg" style="width:200px;">Procurar</button>

 </form>   
       </div>
                             
 </div>
        </div> 
        
        
        
<!-- produtos --> 

    
   
        <div class="col-sm-3 mt-4 admin">
              <div class="card">
                   <img src="productImages/<%=product.getProductPhoto() %>" style="max-height:500px;max-width:100%;width:auto;" class="card-img-top rounded mx-auto d-block m-2" alt="img">
              </div>
        </div>
        
        <div class="col-sm-6 mt-4 admin">
              <div class="card">
                   <div class="card-header text-center">
                     
                        <h1><%=product.getProductTitle() %></h1>
                   </div>
                    <div class="text-left ml-4 mt-3"><h2>Descrição:</h2></div>
                        <div class="card-body text-left">     
                                 <h4 class="card-text ml-2"><%=product.getProductDescription() %></h4> 
                        </div>
                        <div class="card-footer text-center">
                                 <p style="font-size:35px">
                                  <span class="ml-5" style="font-size:22px;">Estoque:</span>
                                  <span class="ml-1" style="font-size:20px"><%if(product.getProductQuantity()<1){ %><span style="color:black;"><b><%=stock%></b></span><%} else{ %><%=product.getProductQuantity()%><% } %></span>
                                 </p>
                                 <hr>
                                 
                               <%
                                   if(u==null)
                                   {
                               %>
                               
                               <form class="form-inline" onclick="return checkUser()">
                                  <select class="form-control text-center" id="size">
                                     <option value="0">Selecione o tamanho</option>
                                     <option value="XS">XS</option>
                                     <option value="S">S</option>
                                     <option value="M">M</option>
                                     <option value="L">L</option>
                                     <option value="XL">XL</option>
                                     <option value="XXL">XXL</option>
            
                                  </select>
                                  <div class="form-group mx-sm-3 mb-2">
                                      <input type="number" class="form-control" id="quan" name="quantity" placeholder="Quantity" required>
                                  </div>
                                  <button type="submit" class="btn custom-bg text-black mb-2">Adicionar ao carrinho</button>
                               </form>
                              
                              <%
                                   }
                               
                                   else
                                   {
                              %> 
                                       <%
                                           if(u.getUserType().equals("admin"))
                                           {
                                       %>
                                      <a href="ProductOperationServlet?productId=<%=request.getParameter("productId")%>&action=delete"><button type="button" class="btn btn-danger">Deletar</button></a>
                                      <button type="button" class="btn custom-bg text-light ml-5" data-toggle="modal" data-target="#update-product-modal">Update</button>
                                      
                                      <%
                                           }
                                           
                                           else
                                           {
                                      %>
                                               <form class="form-inline" onclick="return checkUser()" action="CartServlet" method="post">
                                                 <input type="hidden" name="action" value="addToCart">
                                                 <input type="hidden" name="productId" value="<%=productId%>">
                                                 <select class="form-control text-center" name="size">
                                                    <option value="0">Selecione o tamanho</option>
                                                    <option value="XS">XS</option>
                                                    <option value="S">S</option>
                                                    <option value="M">M</option>
                                                    <option value="L">L</option>
                                                    <option value="XL">XL</option>
                                                    <option value="XXL">XXL</option>
                                                 </select>
                                                 <div class="form-group mx-sm-3 mb-2">
                                                   <input type="number" class="form-control" id="quan" name="quantity" placeholder="Quantity" required>
                                                 </div>
                                               <input type="submit" class="btn custom-bg text-white mb-2" value="Adicione ao carrinho">
                                               
                                              </form>
                                      <%
                                           }
                                      %>
                              <%
                                   }
                              %>
                        </div>
                   </div>
              </div>
        </div>
    
     <div class="row">
         <div class="col-md-2" >
             
         </div>    
    
    <!-- Update do produto Modal -->
    
    <div class="modal fade" id="update-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white">
        <h5 class="modal-title" id="exampleModalLongTitle" >Update</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
          <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
          
          <input type="hidden" name="action" value="updateProduct">
          <input type="hidden" name="productId" value="<%=productId%>">
        
     <div class="container text-center">
                   <img style="max-width:200px" class="img-fluid" src="productImages/<%=product.getProductPhoto() %>" alt="users_pic" >
                   <h3><%=product.getProductPhoto() %></h3>
         </div> 
     
    <div class="form-group">
      <label for="inputEmail4">Título</label>
      <input type="text" class="form-control" name="productTitle" value="<%=product.getProductTitle() %>" required>
    </div>
    <div class="form-group">
      <label for="inputEmail4">Descrição</label>
      <textarea class="form-control"rows="4" name="productDescription" required><%=product.getProductDescription() %></textarea>
    </div>
    <div class="form-row">
    <div class="form-group col-md-4">
      <label for="inputPassword4">Quantidade</label>
      <input type="number" class="form-control" name="productQuantity" value=<%=product.getProductQuantity() %> required>
    </div>
   </div>
   
   
   
               <div class="form-group">
                   <label>Seleciona a foto do produto</label><br>
                   <input type="file" class="form-control" name="productPhoto" required>     
               </div>

   
   <div class="container text-center">
                   <input type="submit" class="btn custom-bg text-white" value="Update Product">
                   <button type="button" class="btn btn-secondary ml-5" data-dismiss="modal">Fechar</button>
               </div> 
    
</form>   
         
      </div>
    </div>
  </div>
</div>   
    <!-- *********************************** -->
     
</div>
</body>
</html>