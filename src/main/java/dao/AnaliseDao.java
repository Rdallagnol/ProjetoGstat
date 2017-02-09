/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.AnaliseEntity;
import java.util.List;
import javax.enterprise.context.RequestScoped;
import utils.GenericDao;

/**
 *
 * @author Dallagnol
 */
@RequestScoped
public class AnaliseDao extends GenericDao<AnaliseEntity, Long>{
    
    
    public List<AnaliseEntity> findById(Long id){
        List<AnaliseEntity> analises = (List<AnaliseEntity>) this.executeQuery("select a from AnaliseEntity a where a.analise_header_id = ?0", id);        
        return analises;
    }

    
    public List<AnaliseEntity> findAllOrdenado() {
        List<AnaliseEntity> analises = (List<AnaliseEntity>) this.executeQuery("from AnaliseEntity order by 1 desc");
        return analises;
    }

}
