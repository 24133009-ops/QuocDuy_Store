package vn.iotstar.entities;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "videos")
public class Video implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "videoId", length = 50)
    private String videoId;

    @Column(name = "title", columnDefinition = "NVARCHAR(255) NOT NULL")
    private String title;

    @Column(name = "poster", columnDefinition = "NVARCHAR(500)")
    private String poster;

    @Column(name = "views")
    private int views;

    @Column(name = "description", columnDefinition = "NVARCHAR(MAX)")
    private String description;

    @Column(name = "active")
    private boolean active;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "categoryId")
    private Category category;

    public Video() {
    }

    public Video(String videoId, String title, String poster, int views, String description, boolean active, Category category) {
        this.videoId = videoId;
        this.title = title;
        this.poster = poster;
        this.views = views;
        this.description = description;
        this.active = active;
        this.category = category;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
}