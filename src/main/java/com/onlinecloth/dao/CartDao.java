package com.onlinecloth.dao;

import java.util.List;
import com.onlinecloth.pojo.Cart;

public interface CartDao
{
	boolean addToCart(Cart cart);
	List<Cart> getCartByUserId(int userId);
	int totalCartByUserId(int userId);
	public boolean alreadyAvailableInCart(int productId,int userId,String size);
    public int getPreviousQuantityFromCart(int productId,int userId,String size);
    boolean updateCart(Cart cart);
    boolean deleteCartById(int cartId);
    boolean deleteCartByUserId(int userId);
}

/* A interface CartDao define um conjunto de operações que podem ser realizadas em um banco de dados
relacionadas ao carrinho de compras em um aplicativo. Cada método na interface representa uma
operação específica que pode ser realizada em relação ao carrinho de compras.
O padrão DAO (Data Access Object ou, em pt-BR, Objeto de Acesso a Dados), é uma abstração de persistência
de dados e é considerado próximo da camada de armazenamento de dados que, normalmente, é centrado em tabelas.*/