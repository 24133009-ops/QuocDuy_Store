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

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "images", columnDefinition = "NVARCHAR(255)")
    private String images;

    @Column(name = "status")
    private int status; // 0: Chưa kích hoạt, 1: Đã kích hoạt

    @Column(name = "otp", length = 10)
    private String otp;

    public User() {
    }

    // Constructor 5 tham số cho AuthController
    public User(String email, String fullname, String password, int status, String otp) {
        this.email = email;
        this.fullname = fullname;
        this.password = password;
        this.status = status;
        this.otp = otp;
    }

    // Constructor 7 tham số đầy đủ
    public User(String email, String fullname, String password, String phone, String images, int status, String otp) {
        this.email = email;
        this.fullname = fullname;
        this.password = password;
        this.phone = phone;
        this.images = images;
        this.status = status;
        this.otp = otp;
    }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getOtp() { return otp; }
    public void setOtp(String otp) { this.otp = otp; }
}