/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.lang.reflect.ParameterizedType;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

/**
 *
 * @author Dallagnol
 */
@SuppressWarnings("unchecked")
public abstract class GenericDao<T, PK> {

    private final EntityManager entityManager;

    private final EntityManagerFactory factory;

    private Class<?> clazz;

    public GenericDao() {
        this(DaoFactory.entityManagerFactoryInstance());
    }

    public GenericDao(EntityManagerFactory factory) {
        this.factory = factory;
        this.entityManager = factory.createEntityManager();
        this.clazz = (Class<?>) ((ParameterizedType) this.getClass().getGenericSuperclass()).getActualTypeArguments()[0];
    }

    /////////////////////////////////////
    // CRUD Methods
    ////////////////////////////////////
    public Object executeQuery(String query, Object... params) {
        
        
        Query createdQuery = this.entityManager.createQuery(query);

        for (int i = 0; i < params.length; i++) {
            createdQuery.setParameter(i, params[i]);
        }
      
        return createdQuery.getResultList();
    }

    public List<T> findAll() {
        return this.entityManager.createQuery(("from " + this.clazz.getName())).getResultList();
    }

    public void update(T entity) {
        try {
            this.beginTransaction();
            this.entityManager.merge(entity);
            this.commit();
        } catch (Exception e) {
            this.rollBack();
            throw e;
        }
    }

    public void delete(T entity) {
        try {
            this.beginTransaction();
            this.entityManager.remove(entity);
            this.commit();
        } catch (Exception e) {
            this.rollBack();
            throw e;
        }
    }
    /////////////////////////////////////
    // Transaction Methods
    ////////////////////////////////////

    public void beginTransaction() {
        this.entityManager.getTransaction().begin();
    }

    public void commit() {
        this.entityManager.getTransaction().commit();
    }

    public void close() {
        this.entityManager.close();
        this.factory.close();
    }

    public void rollBack() {
        this.entityManager.getTransaction().rollback();
    }

    public EntityManager getEntityManager() {
        return this.entityManager;
    }

}
