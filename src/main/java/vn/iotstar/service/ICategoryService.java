package vn.iotstar.services;

import java.util.List;
import vn.iotstar.entities.Category;

public interface ICategoryService {
    void insert(Category category);
    void update(Category category);
    void delete(int cateid) throws Exception;
    Category findById(int cateid);
    Category findByCategoryname(String name);
    List<Category> findAll();
    List<Category> findAll(int page, int pagesize);
    List<Category> searchByName(String keyword);
    int count();
}