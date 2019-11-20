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
public class Pharmacy
{
   
   @GeneratedValue( strategy = GenerationType.AUTO )
   private int               id;
   private String            adress;
   private int               e_sicil_no;
   @OneToMany( mappedBy = "Pharmacy" )

   public int getId()
   {
      return id;
   }

   public void setId( int id )
   {
      this.id = id;
   }
   public int getE_sicil_no()
   {
      return e_sicil_no;
   }

   public void setE_sicil_no( int e_sicil_no )
   {
      this.e_sicil_no = e_sicil_no;
   }

   public int getAdress()
   {
      return adress;
   }

   public void setAdress( String adress )
   {
      this.adress = adress;
   }


  

}
