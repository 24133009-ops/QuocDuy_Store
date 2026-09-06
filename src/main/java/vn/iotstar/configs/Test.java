package vn.iotstar.configs;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.entities.Category;
import vn.iotstar.entities.Video;

public class Test {
    public static void main(String[] args) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();

        Category cate = new Category();
        cate.setCategoryname("Điện thoại");
        cate.setImages("iphone.jpg");
        cate.setStatus(1);

        Video video = new Video();
        video.setVideoId("V001");
        video.setTitle("Review iPhone 16");
        video.setActive(true);
        video.setCategory(cate);

        try {
            trans.begin();
            enma.persist(cate);
            enma.persist(video);
            trans.commit();
            System.out.println("Tạo database và chèn dữ liệu test thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) trans.rollback();
        } finally {
            enma.close();
        }
    }
}