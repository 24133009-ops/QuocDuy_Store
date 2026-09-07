package vn.iotstar.services.impl;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.daos.impl.UserDaoImpl;
import vn.iotstar.entities.User;
import vn.iotstar.service.IUserService;

public class UserServiceImpl implements IUserService {
    private final IUserDao userDao = new UserDaoImpl();

    @Override
    public void updateProfile(User user) {
        userDao.update(user);
    }

    @Override
    public User getByEmail(String email) {
        return userDao.findByEmail(email);
    }
}