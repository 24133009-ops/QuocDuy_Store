package vn.iotstar.daos.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.configs.JpaConfig;
import vn.iotstar.entities.User;

public class UserDaoImpl {
    public void insert(User user) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally { em.close(); }
    }

    public void update(User user) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally { em.close(); }
    }

    public User findByEmail(String email) {
        EntityManager em = JpaConfig.getEntityManager();
        try {
            return em.find(User.class, email);
        } finally { em.close(); }
    }
}