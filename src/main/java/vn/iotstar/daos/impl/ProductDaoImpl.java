package vn.iotstar.daos.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.configs.JpaConfig;
import vn.iotstar.entities.Product;

public class ProductDaoImpl {
    public void insert(Product product) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally { em.close(); }
    }

    public void update(Product product) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally { em.close(); }
    }

    public void delete(int id) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Product p = em.find(Product.class, id);
            if (p != null) em.remove(p);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally { em.close(); }
    }

    public Product findById(int id) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            return em.find(Product.class, id);
        } finally { em.close(); }
    }

    public List<Product> findAll() {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Product p", Product.class).getResultList();
        } finally { em.close(); }
    }

    public List<Product> getTop10Latest() {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT p FROM Product p ORDER BY p.createDate DESC";
            return em.createQuery(jpql, Product.class).setMaxResults(10).getResultList();
        } finally { em.close(); }
    }

    public List<Product> findAllPaging(int page, int pageSize) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            String jpql = "SELECT p FROM Product p ORDER BY p.productId DESC";
            TypedQuery<Product> query = em.createQuery(jpql, Product.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally { em.close(); }
    }

    public int countTotalProducts() {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            return ((Long) em.createQuery("SELECT COUNT(p) FROM Product p").getSingleResult()).intValue();
        } finally { em.close(); }
    }
}