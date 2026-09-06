package vn.iotstar.entities;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "email", length = 100)
    private String email;

    @Column(name = "fullname", columnDefinition = "NVARCHAR(100)")
    private String fullname;

    @Column(name = "password", length = 255, nullable = false)
    private String password;

    @Column(name = "status")
    private int status; // 0: Chưa kích hoạt, 1: Đã kích hoạt

    @Column(name = "otp", length = 10)
    private String otp;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public User(String email, String fullname, String password, int status, String otp) {
        this.email = email;
        this.fullname = fullname;
        this.password = password;
        this.status = status;
        this.otp = otp;
    }

    public User() {
    }
}