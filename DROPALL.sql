-- foreign keys
ALTER TABLE work_genres
    DROP FOREIGN KEY genres_works;

ALTER TABLE review_likes
    DROP FOREIGN KEY review_likes_reviews;

ALTER TABLE review_likes
    DROP FOREIGN KEY review_likes_user;

ALTER TABLE reviews
    DROP FOREIGN KEY reviews_reviews;

ALTER TABLE reviews
    DROP FOREIGN KEY reviews_user;

ALTER TABLE reviews
    DROP FOREIGN KEY reviews_works;

ALTER TABLE shelf
    DROP FOREIGN KEY shelf_statuses;

ALTER TABLE shelf
    DROP FOREIGN KEY shelf_user;

ALTER TABLE shelf
    DROP FOREIGN KEY shelf_works;

ALTER TABLE user_followers
    DROP FOREIGN KEY source_followers;

ALTER TABLE user_followers
    DROP FOREIGN KEY target_followers;

ALTER TABLE work_creators
    DROP FOREIGN KEY work_creators_creators;

ALTER TABLE work_creators
    DROP FOREIGN KEY work_creators_works;

ALTER TABLE work_genres
    DROP FOREIGN KEY work_genres_genres;

-- tables
DROP TABLE creators;

DROP TABLE genres;

DROP TABLE review_likes;

DROP TABLE reviews;

DROP TABLE shelf;

DROP TABLE statuses;

DROP TABLE user;

DROP TABLE user_followers;

DROP TABLE work_creators;

DROP TABLE work_genres;

DROP TABLE works;

-- End of file.