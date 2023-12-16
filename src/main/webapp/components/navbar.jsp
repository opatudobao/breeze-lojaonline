<%@ page import ="com.onlinecloth.pojo.*"%>
<%@ page import ="com.onlinecloth.dao.*"%>
<%@ page import ="java.sql.*"%>
<%@ page import ="java.util.*"%>

<%
     User user=(User)session.getAttribute("active-user"); 
%>

<%
     ClothDaoImp cdao=new ClothDaoImp();
     List<Cloth> cll=cdao.getAllCloth();
%>

<nav class="navbar navbar-expand-lg navbar-light custom-bg">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">
            <img src="images/logo.png" alt="Breeze Store Logo" height="70"/>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <% if(user!=null) { %>
                    <%
                        String userType=user.getUserType();
                        if(userType.equals("admin")) {
                    %>
                        <li class="nav-item active">
                            <a class="nav-link" href="admin.jsp"><b>Administrador</b> <span class="sr-only">(current)</span></a>
                        </li>
                    <% } %>
                <% } %>
                <li class="nav-item active dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <b>Produtos</b>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="index.jsp?cloth=0" >Todos os produtos</a>
                        <% for(Cloth c: cll) { %> 
                            <a class="dropdown-item" href="index.jsp?cloth=<%=c.getClothId() %>"><%=c.getClothTitle() %></a>     
                        <% } %>
                    </div>
                </li>
                
                <li class="nav-item active ml-2" data-toggle="modal" data-target=".aboutusmodal">
                    <div class="nav-link" ><b>Sobre a loja</b></div>
                </li>
                
                <li class="nav-item active ml-2" data-toggle="modal" data-target=".contactusmodal">
                    <div class="nav-link" ><b>Contato</b></div>
                </li>
            </ul>

            <% if(user!=null) { %>
            
            
                <ul class="navbar-nav ml-auto">
                    <% if(user.getUserType().equals("normal")) { %>
                        <li class="nav-item active" data-toggle="modal" data-target="#showmycartmodal">
                            <div class="nav-link"><img src="images/carrinho.png" style="width:23px;" alt="img">(<%=new CartDaoImp().totalCartByUserId(user.getUserId()) %>)</div>
                        </li> 
                    <% } %>
                    <li class="nav-item active">
                        <div class="nav-link" data-toggle="modal" data-target="#showprofilemodal"><b><%= user.getUserName()%></b></div>
                    </li> 
                    <li class="nav-item active">
                        <div class="nav-link" data-toggle="modal" data-target=".changepasswordmodal"><b>Modificar Senha</b></div>
                    </li>  
                    <li class="nav-item active" data-toggle="modal" data-target=".logout-modal">
                        <a class="nav-link" href="#" ><b>Sair</b></a>
                    </li>    
                </ul>
            <% } else { %>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <div class="nav-link" data-toggle="modal" data-target=".forgetpasswordmodal"><b>Esqueceu a senha?</b></div>
                    </li> 
                    <li class="nav-item active">
                        <a class="nav-link" href="register.jsp"><b>Nova Conta</b></a>
                    </li>  
                    <li class="nav-item active">
                        <a class="nav-link" href="login.jsp"><b>Login</b></a>
                    </li>    
                </ul>
            <% } %>     
        </div>
    </div>
</nav>

<!-- Perfil de usuário -->

<div class="modal fade" id="showprofilemodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Meu Perfil</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form >
         
         <div class="container text-center">
                   <img style="max-width:200px" class="img-fluid rounded-circle" src="userProfilePic/<%if(user!=null){ %><%=user.getUserPic() %><%} %>" alt="users_pic" >
         </div> 
         
  <div class="form-row mt-3">
    <div class="form-group col-md-4">
      <label for="inputEmail4">Nome</label>
      <input type="text" class="form-control" id="inputEmail4" value="<%if(user!=null){ %><%=user.getUserName() %><%} %>" readonly>
    </div>
    <div class="form-group col-md-4">
      <label for="inputPassword4">E-mail</label>
      <input type="email" class="form-control" id="inputPassword4" value="<%if(user!=null){ %><%=user.getUserEmail() %><%} %>" readonly>
    </div>
    <div class="form-group col-md-4">
      <label for="inputPassword4">Telefone</label>
      <input type="text" class="form-control" id="inputPassword4" value="<%if(user!=null){ %><%=user.getUserPhone() %><%} %>" readonly>
    </div>
  </div>
  <div class="form-group">
    <label for="inputAddress">Endereço</label>
    <textarea class="form-control" id="inputAddress" placeholder="1234 Main St" rows="3" readonly><%if(user!=null){ %><%=user.getUserAddress() %><%} %></textarea>
  </div>
 
  <div class="container text-center">
       <button type="button" class="btn custom-bg text-light" data-dismiss="modal">Fechar</button>
  </div>   
</form>
      </div>
    </div>
  </div>
</div>

<!-- Mostrar Carrinho -->

<div class="modal fade" id="showmycartmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-black text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Carrinho</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
     <%
      if(user!=null)
      {
    	  List<Cart> l=new CartDaoImp().getCartByUserId(user.getUserId());
    	 
     %>
      <div class="modal-body">
        
        <%
            if(l.isEmpty())
            {
        %>
        <div class="text-center">
        <h1>Seu carrinho está vazio</h1>
        <hr>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
        </div>
        <%
            }
        
            else
            {
            	
            	
        %>
        <div class="table-responsive">
          <table class="table">
  <thead class="custom-bg text-black">
    <tr>
      <th scope="col">Imagem do Produto</th>
      <th scope="col">Título</th>    
      <th scope="col">Descrição</th>
      <th scope="col">Tamanho</th>
      <th scope="col">Quantidade</th>

      <th scope="col">Ação</th>
    </tr>
  </thead>
  
 
  
<tbody>
   <%
      CartDaoImp ctdao=new CartDaoImp();
      
   %>
  
   <%
      for(Cart c:l)
      {
    	  int productId=c.getProductId();
    	  Product p=new ProductDaoImp().getProductById(productId);
   %>
    <tr class="text-center">
      <td><img style="max-height:100px;max-width:70px;width:auto;" class="img-fluid mx-auto d-block" src="productImages/<%=p.getProductPhoto() %>" alt="users_pic" ></td>
      <td class="mid-align"><%=p.getProductTitle() %></td>
      <td class="mid-align"><%=p.getProductDescription() %></td>      
      <td class="mid-align"><%=c.getProductSize() %></td>
      <td class="mid-align"><%=c.getQuantity() %></td>
      <td class="mid-align"><a href="CartServlet?cartId=<%=c.getCartId()%>&action=delete"><button type="button" class="btn btn-danger">Remove</button></a></td>
    </tr>
    <%
      }
    %>
  </tbody>
 
  
</table>
</div>
<hr>

<hr>
       <%
            }
       %>
         
      </div>
  <%
           
      }
  %>
    </div>
  </div>
</div>

<!-- Logout -->

<div class="modal fade logout-modal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
    <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Logout</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="modal-body text-center">
            <h5>Você tem certeza que quer sair?</h5>
          
          <div class="text-center">
            <a href="LoginServlet"><button type="button" class="btn custom-bg text-white">Sim</button></a>
            <button type="button" class="btn btn-secondary ml-5" data-dismiss="modal">Não</button>
          </div> 
     </div>     
    </div>
  </div>
</div>

<!-- Sobre -->

<div class="modal fade aboutusmodal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
       <div class="modal-header custom-bg text-white text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Sobre nós</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div> 
      <div class="modal-body" style="text-align: justify;">
        <div class="container">
        <p style="font-size:20px;">
          <b>
Bem-vindo à Breeze Store!
Na Breeze, acreditamos que a moda é uma expressão única de quem você é, e nossa missão é oferecer uma experiência
de compra online que celebra a individualidade e a elegância feminina. Fundada com paixão e dedicação à moda,
nossa loja online é um destino cuidadosamente curado para mulheres modernas que buscam peças estilosas, confortáveis
e, acima de tudo, autênticas.
          </b>
        </p>
        </div>
      </div>
      <div class="modal-footer">
       <div class="text-center">
        <button type="button" class="btn custom-bg text-black" data-dismiss="modal">Fechar</button>
       </div>
      </div>
    </div>
  </div>
</div>

<!-- Contato -->

<div class="modal fade contactusmodal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
       <div class="modal-header custom-bg text-black text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Contato</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div> 
      <div class="modal-body">
        <div class="container text-center">
        <p style="font-size:23px;">
            <b>
                <img src="images/phonee.png" style="width:29px;" alt="img">+55 xxxx-xxxx<br>
                <img src="images/emaill.png" style="width:32px;" alt="img"> breezestore@gmail.com
            </b>
        </p>
        </div>
      </div>
      <div class="modal-footer">
       <div class="text-center">
        <button type="button" class="btn custom-bg text-white" data-dismiss="modal">Fechar</button>
       </div>
      </div>
    </div>
  </div>
</div>

<!-- Modificar Senha -->

<div class="modal fade changepasswordmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-black text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Modificar Senha</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form action="LoginServlet" method="post">
          <input type="hidden" name="action" value="changePassword">
         
  <div class="form">
 
    <div class="form-group ">
      <label for="inputPassword4">E-mail:</label>
      <input type="email" class="form-control" id="inputPassword4" value="<%if(user!=null){ %><%=user.getUserEmail() %><%} %>" readonly>
    </div>
    <div class="form-group">
      <label for="inputPassword4">Senha:</label>
      <input type="password" class="form-control" id="pass" name="pass" >
    </div>
    <div class="form-group">
      <label for="inputPassword4">Confirmar Senha:</label>
      <input type="password" class="form-control" id="cpass" name="cpass">
    </div>
  </div>
 
  <div class="container text-center">
       
       <input type="submit" class="btn custom-bg text-light" value="Trocar Senha">
       <button type="button" class="btn custom-bg text-light ml-5" data-dismiss="modal">Fechar</button>
                                      
  </div>   
</form>
      </div>
    </div>
  </div>
</div>

<!-- Esqueceu a Senha -->

<div class="modal fade forgetpasswordmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header custom-bg text-black text-center">
        <h5 class="modal-title" id="exampleModalLongTitle" >Adicione seus dados abaixo</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <form action="LoginServlet" method="post">
          <input type="hidden" name="action" value="forgetPassword">
         
  <div class="form">
 
    <div class="form-group ">
      <label for="inputPassword4">E-mail</label>
      <input type="email" class="form-control" id="email" name="email">
    </div>
    <div class="form-group ">
      <label for="inputPassword4">Telefone</label>
      <input type="text" class="form-control" id="phone" name="phone">
    </div>
    <div class="form-group">
      <label for="inputPassword4">Senha</label>
      <input type="password" class="form-control" id="pass" name="pass" >
    </div>
    <div class="form-group">
      <label for="inputPassword4">Confirmação de Senha</label>
      <input type="password" class="form-control" id="cpass" name="cpass">
    </div>
  </div>
 
  <div class="container text-center">
       
       <input type="submit" class="btn custom-bg text-black" value="Mudar">
       <button type="button" class="btn custom-bg text-black ml-5" data-dismiss="modal">Fechar</button>
                                      
  </div>   
</form>
      </div>
    </div>
  </div>
</div>