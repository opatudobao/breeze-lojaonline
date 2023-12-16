package com.onlinecloth.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.onlinecloth.dbUtility.DBUtility;
import com.onlinecloth.pojo.Cart;


/*A interface CartDao define um conjunto de operações que podem ser realizadas em um banco de
 * dados relacionadas ao carrinho de compras em um aplicativo. Cada método na interface
 * representa uma operação específica que pode ser realizada em relação ao carrinho de compras. */


public class CartDaoImp implements CartDao
{
	@Override
	public boolean addToCart(Cart cart)
	{
		int row=0;
    	Connection con=DBUtility.getConnection();
    	String query="insert into cart(productId,userId,size,quantity) values(?,?,?,?)";
    	try
    	{
    	    PreparedStatement stmt= con.prepareStatement(query);
    	    stmt.setInt(1,cart.getProductId());
    	    stmt.setInt(2,cart.getUserId());
    	    stmt.setString(3, cart.getProductSize());
    	    stmt.setInt(4,cart.getQuantity());
    	    row=stmt.executeUpdate();
    	}
    	
    	catch(SQLException e)
    	{
    		System.out.println(e);
    	}
    	
    	if(row>0)
    	   return true;
    	else
    	   return false;
	}

	@Override
	public List<Cart> getCartByUserId(int userId)
	{
		Connection con=DBUtility.getConnection();
		String query="select * from cart where userId="+userId;
		ResultSet rs;
		Statement stmt;
		Cart cart;
		List<Cart> li=new ArrayList<>();
		
		try
    	{
    	    stmt=con.createStatement();
    	    rs=stmt.executeQuery(query);
    	    
    	    while(rs.next())
    	    {
    	        cart=new Cart(rs.getInt("cartId"),rs.getInt("userId"),rs.getInt("productId"),rs.getInt("quantity"));
    	        cart.setProductSize(rs.getString("size"));
    	        li.add(cart);
    	    }
    	}
    	
    	catch(SQLException e)
    	{
    		System.out.println(e);
    	}
    	
    	return li;
	}

	@Override
	public int totalCartByUserId(int userId)
	{
		   int totalCart=0;
		   ResultSet rs;
	 	   String type=null;
	 	   Connection con=DBUtility.getConnection();
	        String query="select count(cartId) from cart where userId="+userId;
	        
	 	   try 
	 	   {
	 		Statement stmt=con.createStatement();
	 	    rs=stmt.executeQuery(query);
	 	    while(rs.next())
	 		{
	 	    	totalCart=rs.getInt("count(cartId)");
	 		}
	 	   }
	 	   catch (SQLException e) 
	 	   {
	 		e.printStackTrace();
	 	   }
	 	  
		 
		return totalCart;
	}

	@Override
	public boolean alreadyAvailableInCart(int productId, int userId,String size)
	{
		ResultSet rs;
		Connection con=DBUtility.getConnection();
		Statement stmt;
		int count=0;
		String query="select * from cart where userId="+userId+" and productId="+productId+" and size='"+size+"'";
		
		try
		{
			stmt=con.createStatement();
			rs=stmt.executeQuery(query); 
			if (rs.next() == false)
			{ 
				count=1; 
			}
			
		}
		
		catch(SQLException e)
      	{
      		e.printStackTrace();
      	}
		
		if(count==1)
		{
			return false;
		}	
		
		else
		{
			return true;
		}
	}

	@Override
	public int getPreviousQuantityFromCart(int productId, int userId,String size)
	{
		ResultSet rs;
		Connection con=DBUtility.getConnection();
		Statement stmt;
		String query="select quantity from cart where userId="+userId+" and productId="+productId+" and size='"+size+"'";
		int quantity=0;
		try
		{
			stmt=con.createStatement();
			rs=stmt.executeQuery(query); 
			
			while(rs.next())
			{
				quantity=rs.getInt("quantity");
			}
		}
		
		catch(SQLException e)
      	{
      		e.printStackTrace();
      	}
		
		return quantity;
	}

	@Override
	public boolean updateCart(Cart cart)
	{
		int row=0;
    	Connection con=DBUtility.getConnection();
    	String query="update cart set quantity=? where productId=? and userId=? and size=?";
    	try
    	{
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setInt(1, cart.getQuantity());
            stmt.setInt(2, cart.getProductId());
            stmt.setInt(3, cart.getUserId());
            stmt.setString(4, cart.getProductSize());
            row = stmt.executeUpdate();
    	}
    	
    	catch(SQLException e)
    	{
    		System.out.println(e);
    	}
    	
    	if(row>0)
    	   return true;
    	else
    	   return false;
	}

	@Override
	public boolean deleteCartById(int cartId)
	{
		int row=0;
    	Connection con=DBUtility.getConnection();
    	String query="delete from cart where cartId=?";
    	try
    	{
    	    PreparedStatement stmt= con.prepareStatement(query);
    	    stmt.setInt(1,cartId);
    	    row=stmt.executeUpdate();
    	}
    	
    	catch(SQLException e)
    	{
    		System.out.println(e);
    	}
    	
    	if(row>0)
    	   return true;
    	else
    	   return false;
	}

	@Override
	public boolean deleteCartByUserId(int userId)
	{
		int row=0;
    	Connection con=DBUtility.getConnection();
    	String query="delete from cart where userId=?";
    	try
    	{
    	    PreparedStatement stmt= con.prepareStatement(query);
    	    stmt.setInt(1,userId);
    	    row=stmt.executeUpdate();
    	}
    	
    	catch(SQLException e)
    	{
    		System.out.println(e);
    	}
    	
    	if(row>0)
    	   return true;
    	else
    	   return false;
	}

	

}
