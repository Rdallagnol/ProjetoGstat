/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import dao.AnaliseDao;
import dao.AreaDao;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Dallagnol
 */
public final class DaoFactory {

    public DaoFactory() {
    }
        
    ////////////////////////////////
    /// Entity Manager Factory
    ////////////////////////////////
    
    private static final String PERSISTENCE_UNIT_NAME = "default";
    
    private static EntityManagerFactory entityManagerFactoryInstace;
    
    public static EntityManagerFactory entityManagerFactoryInstance(){
        if(entityManagerFactoryInstace == null){
            entityManagerFactoryInstace = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
        }
        return entityManagerFactoryInstace;
    }
    
    
    /////////////////////////////
    /// Analise
    /////////////////////////////
    private static AnaliseDao analiseDaoInstance;
    
    public static AnaliseDao analiseInstance(){
        if(analiseDaoInstance == null){
           analiseDaoInstance = new AnaliseDao();
        }
        return analiseDaoInstance;
    }
    
    
    /////////////////////////////
    /// Area
    /////////////////////////////
    private static AreaDao areaDaoInstance;
    
    public static AreaDao areaDaoInstance(){
        if(areaDaoInstance == null){
           areaDaoInstance = new AreaDao();
        }
        return areaDaoInstance;
    }
}
