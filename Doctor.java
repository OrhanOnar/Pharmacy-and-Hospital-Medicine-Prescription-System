package com.home.hibernate.entity;

import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

/**
 * @author preetham
 */
@Entity
public class Doctor
{
   @Id
   @GeneratedValue( strategy = GenerationType.AUTO )
   private int               id;
	private int               yetki;
private String            brans;
   private String            name;
   @OneToMany( mappedBy = "Doctor" )
   private Collection<House> house = new ArrayList<House>();

   public int getId()
   {
      return id;
   }

   public void setId( int id )
   {
      this.id = id;
   }


   public int getYetki()
   {
      return yetki;
   }

   public void setId( int yetki )
   {
      this.yetki = yetki;
   }



   public String getBrans()
   {
      return brans;
   }

   public void setbrans( String  brans)
   {
      this.brans = brans;
   }

   public Collection<Person> getPerson()
   {
      return person;
   }

   public void setPerson( Collection<Person> person )
   {
      this.person = person;
   }

   public String getName()
   {
      return name;
   }

   public void setName( String name )
   {
      this.name = name;
   }

   public Doctor()
   {
      // TODO Auto-generated constructor stub
   }

   public Doctor( String name )
   {
      this.name = name;
   }

}
