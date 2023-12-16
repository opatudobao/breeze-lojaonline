<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Breeze - Cadastro</title>
<%@ include file="components/common_cs_js.jsp"%>
</head>
<body>
  <%@ include file="components/navbar.jsp"%>
  
 <div class="container-fluid">
  <div class="row mt-2">
       <div class="col-md-4 offset-md-4 admin" >
            <div class="card">
                <%@ include file="components/message.jsp"%>
                <div class="card-body px-5">
                    <img src="images/usuarioimg.png" class="rounded mx-auto d-block" alt="img" height="90px" width="90px">
                    <h3 class="text-center my-3">Faça seu cadastro</h3>
            <form action="RegisterServlet" method="post" enctype="multipart/form-data">
                 <div class="form-group">
                     <label for="name">Nome de Usuário:</label>
                     <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="username" placeholder="Insira seu nome de usuário" required>
                 </div>
                 
                  <div class="form-group">
                     <label for="email">E-mail:</label>
                     <input type="email" class="form-control" id="email" aria-describedby="emailHelp" name="useremail" placeholder="Insira seu e-mail" required>
                 </div>
                 
                 <div class="form-group">
                     <label for="password">Senha:</label>
                     <input type="password" class="form-control" id="password" aria-describedby="emailHelp" name="userpassword" placeholder="Insira a sua senha" required>
                 </div>
                 
                 <div class="form-group">
                     <label for="phone">Telefone:</label>
                     <input type="number" class="form-control" id="phone" aria-describedby="emailHelp" name="userphone" placeholder="Adicione seu telefone" required>
                 </div>
                 
                 <div class="form-group">
                     <label for="phone">Endereço:</label>
                     <textarea style="height:90px" class="form-control" placeholder="Adicione seu endereço" name="useraddress" required></textarea>
                 </div>
                 
                 <div class="form-group">
                   <label>Selecione sua foto de perfil</label><br>
                   <input type="file" class="form-control" name="productPic" required>
               </div>
                 
                 <div class="container text-center">
                      <button class="btn text-white custom-bg">Cadastrar</button>
                 </div>
                 
            </form>
                </div>
            </div>
           
            
       </div>
  </div>
</div>
</body>
</html>