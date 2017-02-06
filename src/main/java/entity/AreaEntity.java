/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.util.Date;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import utils.BaseBean;

/**
 *
 * @author Dallagnol
 */
@Entity
@Table(name = "area")
public class AreaEntity extends BaseBean {

    @Id
    @SequenceGenerator(name = "area_codigo_seq", sequenceName = "area_codigo_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "area_codigo_seq")
    private Long codigo;
    private String nome;
    private Float tamanho;

    @OneToMany(mappedBy = "area_id")
    private List<AnaliseEntity> analiseEntitys;

    public AreaEntity() {
    }

    public AreaEntity(Long codigo, String nome, Float tamanho, List<AnaliseEntity> analiseEntitys) {
        this.codigo = codigo;
        this.nome = nome;
        this.tamanho = tamanho;
        this.analiseEntitys = analiseEntitys;
    }

    public List<AnaliseEntity> getAnaliseEntitys() {
        return analiseEntitys;
    }

    public void setAnaliseEntitys(List<AnaliseEntity> analiseEntitys) {
        this.analiseEntitys = analiseEntitys;
    }

    public Long getCodigo() {
        return codigo;
    }

    public void setCodigo(Long codigo) {
        this.codigo = codigo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Float getTamanho() {
        return tamanho;
    }

    public void setTamanho(Float tamanho) {
        this.tamanho = tamanho;
    }

}
