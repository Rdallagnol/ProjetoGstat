/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import utils.BaseBean;

/**
 *
 * @author Dallagnol
 */
@Entity
@Table(name = "geo_analise_header")
public class AnaliseEntity extends BaseBean{
    
    @Id
    @SequenceGenerator(name = "geo_analise_header_seq", sequenceName = "geo_analise_header_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "geo_analise_header_seq")
    private Long analise_header_id;
    private Long area_id;    
    private String descricao_analise;
    private String status;

    public AnaliseEntity() {
    }
    
    
    /**
     * @param analise_header_id
     * @param area_id
     * @param descricao_analise
     * @param status 
     */
    public AnaliseEntity(Long analise_header_id, Long area_id, String descricao_analise, String status) {
        this.analise_header_id = analise_header_id;
        this.area_id = area_id;
        this.descricao_analise = descricao_analise;
        this.status = status;
    }
 
    /**
     * @return the analise_header_id
     */
    public Long getAnalise_header_id() {
        return analise_header_id;
    }

    /**
     * @param analise_header_id the analise_header_id to set
     */
    public void setAnalise_header_id(Long analise_header_id) {
        this.analise_header_id = analise_header_id;
    }

    /**
     * @return the area_id
     */
    public Long getArea_id() {
        return area_id;
    }

    /**
     * @param area_id the area_id to set
     */
    public void setArea_id(Long area_id) {
        this.area_id = area_id;
    }

    /**
     * @return the descricao_analise
     */
    public String getDescricao_analise() {
        return descricao_analise;
    }

    /**
     * @param descricao_analise the descricao_analise to set
     */
    public void setDescricao_analise(String descricao_analise) {
        this.descricao_analise = descricao_analise;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }
    
    
    
    
    
}
