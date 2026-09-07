package vn.iotstar.service;

import vn.iotstar.entities.User;

public interface IUserService {
    void updateProfile(User user);
    User getByEmail(String email);
}