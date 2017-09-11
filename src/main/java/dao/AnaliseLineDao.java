/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.AnaliseLinesEntity;
import java.util.List;
import utils.GenericDao;

/**
 *
 * @author Dallagnol
 */
public class AnaliseLineDao extends GenericDao<AnaliseLinesEntity, Long> {

    @SuppressWarnings("unchecked")
    public List<AnaliseLinesEntity> findByArea(Long areaId) {
        return (List<AnaliseLinesEntity>) this.executeQuery(" select a from AnaliseLinesEntity a where a.analiseHeader.analise_header_id = ?0 order by a.isi ", areaId);
    }
}
