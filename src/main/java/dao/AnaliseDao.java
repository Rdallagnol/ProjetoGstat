/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.AnaliseEntity;
import utils.GenericDao;

/**
 *
 * @author Dallagnol
 */
public class AnaliseDao extends GenericDao<AnaliseEntity, Long>{
    
    
    public void consultaEspecifica(){
        executeQuery("", "");
    }
}
