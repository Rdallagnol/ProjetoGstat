/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.util.Date;
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
public class AnaliseEntity extends BaseBean {

    @Id
    @SequenceGenerator(name = "geo_analise_header_seq", sequenceName = "geo_analise_header_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "geo_analise_header_seq")
    private Long analise_header_id;
    private Long area_id;
    private Long amostra_id;
    private Date creation_date;
    private Long created_by;
    private String descricao_analise;
    private String status;

    public AnaliseEntity() {
    }

    public AnaliseEntity(Long analise_header_id, Long area_id, Long amostra_id, Date creation_date, Long created_by, String descricao_analise, String status) {
        this.analise_header_id = analise_header_id;
        this.area_id = area_id;
        this.amostra_id = amostra_id;
        this.creation_date = creation_date;
        this.created_by = created_by;
        this.descricao_analise = descricao_analise;
        this.status = status;
    }

    public Long getAnalise_header_id() {
        return analise_header_id;
    }

    public void setAnalise_header_id(Long analise_header_id) {
        this.analise_header_id = analise_header_id;
    }

    public Long getArea_id() {
        return area_id;
    }

    public void setArea_id(Long area_id) {
        this.area_id = area_id;
    }

    public Long getAmostra_id() {
        return amostra_id;
    }

    public void setAmostra_id(Long amostra_id) {
        this.amostra_id = amostra_id;
    }

    public Date getCreation_date() {
        return creation_date;
    }

    public void setCreation_date(Date creation_date) {
        this.creation_date = creation_date;
    }

    public Long getCreated_by() {
        return created_by;
    }

    public void setCreated_by(Long created_by) {
        this.created_by = created_by;
    }

    public String getDescricao_analise() {
        return descricao_analise;
    }

    public void setDescricao_analise(String descricao_analise) {
        this.descricao_analise = descricao_analise;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    

}
