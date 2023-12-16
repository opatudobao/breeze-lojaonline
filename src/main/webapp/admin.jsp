<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    
    <%@ page import ="com.onlinecloth.pojo.*"%>
    <%@ page import ="com.onlinecloth.dao.*"%>
    <%@ page import ="java.sql.*"%>
    <%@ page import ="java.util.*"%>

    
    <%
        List<Cloth> lic=new ClothDaoImp().getAllCloth(); 
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Breeze Store - Administrador</title>
<%@ include file="components/common_cs_js.jsp"%>

</head>
<body>
 <%@ include file="components/navbar.jsp"%>
  
 <div class="container admin mt-2">
     <%@ include file="components/message.jsp"%> 
      <div class="row mt-3">
      
           <div class="col-md-3">
                 <div class="card hover" data-toggle="modal" data-target="#show-users-modal">
                     <div class="card-body text-center">
                         <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/usuarios.png" alt="users_pic" >
                         </div>
                         <h1><%=new UserDaoImp().getTotalUser() %></h1>
                         <h2 class="text-uppercase text-muted">Usuários</h2>
                     </div>
                 </div>
           </div>
            
           <div class="col-md-3">
                  <div class="card hover" data-toggle="modal" data-target="#show-cloth-modal">
                     <div class="card-body text-center">
                          <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/roupa.png" alt="users_pic" >
                         </div>
                          <h1><%=new ClothDaoImp().getTotalCloth() %></h1>
                          <h2 class="text-uppercase text-muted">Roupas</h2>
                     </div>
                 </div>
           </div>
           
           <div class="col-md-3">
                  <div class="card hover" data-toggle="modal" data-target="#show-product-modal">
                     <div class="card-body text-center">
                           <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/produtos.png" alt="users_pic" >
                           </div>
                           <h1><%=new ProductDaoImp().getTotalProduct() %></h1>
                           <h2 class="text-uppercase text-muted">Produtos</h2>
                     </div>
                 </div>
           </div>
      </div>
      
      <div class="row mt-3" >
 
           <div class="col-md-3">
                  <div class="card hover" data-toggle="modal" data-target="#add-cloth-modal">
                     <div class="card-body text-center">
                          <div class="container md-5">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/addroupa.png" alt="users_pic" >
                         </div>                   
                          <h2 class="text-uppercase text-muted mt-1">Adicionar roupas</h2>
                     </div>
                 </div>
           </div>
           
           <div class="col-md-3">
                  <div class="card hover" data-toggle="modal" data-target="#add-product-modal">
                     <div class="card-body text-center">
                          <div class="container">
                             <img style="max-width:120px" class="img-fluid rounded-circle" src="images/addproduto.png" alt="users_pic" >
                         </div>
                         <h2 class="text-uppercase text-muted">Adicionar produto</h2>
                     </div>
                 </div>
           </div>
           
      </div>
      
 </div> 
    
  <!-- add roupa modal -->
     
<div class="modal fade" id="add-cloth-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white">
        <h5 class="modal-title" id="exampleModalLongTitle" >Adicione os detalhes da roupa</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body">
          <form action="ProductOperationServlet" method="post">
               <input type="hidden" name="action" value="addCloth">
               <div class="form-group">
                   <input type="text" class="form-control" name="clothTitle" placeholder="Adicione o título" required>
               </div>
               
               <div class="form-group">
                   <textarea style="height:250px" class="form-control" name="clothDescription" placeholder="Adicione a descrição" required></textarea>
               </div>
               
               <div class="container text-center">
                   <button class="btn custom-bg text-white">Adicionar roupa</button>
                   <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
               </div>   
          </form>
      </div>
    </div>
  </div>
</div>
      
      
  <!--  -->
  
  <!-- add produto modal -->
     
<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-black">
        <h5 class="modal-title" id="exampleModalLongTitle" >Adicione detalhes do produto</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
               <input type="hidden" name="action" value="addProduct">
               <div class="form-group">
                   <input type="text" class="form-control" name="productTitle" placeholder="Título do produto" required>
               </div>
               
               <div class="form-group">
                   <textarea style="height:150px" class="form-control" name="productDescription" placeholder="Descrição" required></textarea>
               </div>              
               
			<div class="form-group">
  				  <input type="text" class="form-control" name="productQuantity" placeholder="Quantidade" required>
				</div>

               <div class="form-group">
                   <select name="productClothId" class="form-control">
                       <option value="0">Selecione a roupa</option>
                       <%
                           for(Cloth cloth:lic)
                           {
                       %>
                       <option value="<%=cloth.getClothId()%>"><%=cloth.getClothTitle() %></option>
                       <%
                           }
                       %>
                   </select>
               </div>
               
               <div class="form-group">
               <select class="form-control text-center mt-3" id="type" name="productFor">
                <option value="0">Selecione a categoria:</option>
                <option value="men">Casual</option>
                <option value="women">Formal</option>
                <option value="boy">Lingerie</option>
               </select>
               </div>
               
               <div class="form-group">
                   <label>Selecione a foto da roupa</label><br>
                   <input type="file" class="form-control" name="productPic" required>
               </div>
               
               <div class="container text-center">
                   <button class="btn custom-bg text-white">Adicionar produto</button>
                   <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
               </div>   
          </form>
      </div>
    </div>
  </div>
</div>      
   
  <!--  -->
  
  
  
  <!-- Usuarios modal -->
     
<div class="modal fade" id="show-users-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Total de Usuários</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-black">
    <tr>
      <th scope="col">ID</th>
      <th scope="col">Foto</th>
      <th scope="col">Nome</th>
      <th scope="col">E-mail</th>
      <th scope="col">Telefone</th>
      <th scope="col">Endereço</th>
    </tr>
  </thead>
  <tbody>
   <%
      UserDaoImp udao=new UserDaoImp();
      List<User> l=udao.getAllUser("normal");
   %>
  
   <%
      for(User u:l)
      {
   %>
    <tr>
      <th scope="row" class="mid-align"><%=u.getUserId() %></th>
      <td><img style="max-width:70px" class="img-fluid rounded-circle" src="userProfilePic/<%=u.getUserPic() %>" alt="users_pic" ></td>
      <td class="mid-align"><%=u.getUserName() %></td>
      <td class="mid-align"><%=u.getUserEmail() %></td>
      <td class="mid-align"><%=u.getUserPhone() %></td>
      <td class="mid-align"><%=u.getUserAddress() %></td>
    </tr>
    <%
      }
    %>
  </tbody>
</table>
</div>
      </div>
    </div>
  </div>
</div>
        
<!-- -->

<!-- Total de roupas -->

<div class="modal fade" id="show-cloth-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-black text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Total de Roupas</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-black">
    <tr>
      <th scope="col">Id</th>
      <th scope="col">Nome</th>
      <th scope="col">Descrição</th>
      <th scope="col">Ação</th>
    </tr>
  </thead>
  <tbody>
   <%
      ClothDaoImp cdd=new ClothDaoImp();
      List<Cloth> lcc=cdd.getAllCloth();
   %>
  
   <%
      for(Cloth c:lcc)
      {
   %>
    <tr>
      <td class="mid-align"><%=c.getClothId() %></td>
      <td class="mid-align"><%=c.getClothTitle() %></td>
      <td class="mid-align"><%=c.getClothDescription() %></td>
      <td class="mid-align"><a href="ProductOperationServlet?clothId=<%=c.getClothId()%>&action=deleteCloth"><input type="submit" class="btn btn-danger" value="Deletar"></a></td>
    </tr>
    <%
      }
    %>
  </tbody>
</table>
</div>
      </div>
    </div>
  </div>
</div>

<!-- ********************* -->

<!-- Mostrar produtos modal -->

<div class="modal fade" id="show-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-size" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Produtos Totais</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-black">
    <tr>
      <th scope="col">Nome</th>
      <th scope="col">Imagem</th>
      <th scope="col">Descrição</th>
      <th scope="col">Quantidade</th>
    </tr>
  </thead>
  <tbody>
   <%
      ProductDaoImp pd=new ProductDaoImp();
      List<Product> lp=pd.getAllProduct();
      ClothDaoImp clothDao = new ClothDaoImp();
   %>
  
   <%
      for(Product p:lp)
      {
   %>
    <tr>
        <td class="mid-align"><%= p.getProductTitle() %></td>
        <td class="mid-align"><img style="max-width:70px" class="img-fluid"
                src="productImages/<%= p.getProductPhoto() %>" alt="users_pic"></td>
        <td class="mid-align"><%= p.getProductDescription() %></td>
        <td class="mid-align"><%= p.getProductQuantity() %></td>
    </tr>
    <%
      }
    %>
  </tbody>
</table>
</div>
      </div>
    </div>
  </div>
</div>

</body>
</html>