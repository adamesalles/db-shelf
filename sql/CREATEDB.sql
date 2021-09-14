-- tables
-- Table: creators
CREATE TABLE creators (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    creator varchar(255) NOT NULL,
    CONSTRAINT creators_pk PRIMARY KEY (id)
);

-- Table: genres
CREATE TABLE genres (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    genre varchar(255) NOT NULL,
    CONSTRAINT genres_pk PRIMARY KEY (id)
);

-- Table: review_likes
CREATE TABLE review_likes (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    reviews_id BIGINT UNSIGNED NOT NULL,
    type INT NOT NULL COMMENT 'like/dislike
',
    created timestamp NOT NULL DEFAULT NOW(),
    CONSTRAINT review_likes_pk PRIMARY KEY (id)
);

-- Table: reviews
CREATE TABLE reviews (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    works_id BIGINT UNSIGNED NOT NULL,
    reviews_id BIGINT UNSIGNED NULL,
    score int NOT NULL,
    review text NULL,
    created timestamp NOT NULL DEFAULT NOW(),
    CONSTRAINT reviews_pk PRIMARY KEY (id)
);

-- Table: shelf
CREATE TABLE shelf (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    works_id BIGINT UNSIGNED NOT NULL,
    statuses_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    CONSTRAINT shelf_pk PRIMARY KEY (id)
);

-- Table: statuses
CREATE TABLE statuses (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    status varchar(255) NOT NULL COMMENT '"in consume", "consumed", "interest list",  "dropped"',
    CONSTRAINT statuses_pk PRIMARY KEY (id)
);

-- Table: user

CREATE TABLE user (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '@hannah_karolyne',
    username varchar(50) NOT NULL,
    name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    created timestamp NOT NULL DEFAULT NOW(),
    CONSTRAINT usuario_id PRIMARY KEY (id)
);

-- Table: user_followers
CREATE TABLE user_followers (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    source_id BIGINT UNSIGNED NOT NULL,
    target_id BIGINT UNSIGNED NOT NULL,
    created timestamp NOT NULL DEFAULT NOW(),
    CONSTRAINT user_followers_pk PRIMARY KEY (id)
);

-- Table: work_creators
CREATE TABLE work_creators (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    works_id BIGINT UNSIGNED NOT NULL,
    creators_id BIGINT UNSIGNED NOT NULL,
    CONSTRAINT work_creators_pk PRIMARY KEY (id)
);

-- Table: work_genres
CREATE TABLE work_genres (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    works_id BIGINT UNSIGNED NOT NULL,
    genres_id BIGINT UNSIGNED NOT NULL,
    CONSTRAINT work_genres_pk PRIMARY KEY (id)
);

-- Table: works
CREATE TABLE works (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    type varchar(255) NOT NULL,
    publisher varchar(255) NULL,
    synopsis text NULL,
    released date NOT NULL,
    CONSTRAINT works_pk PRIMARY KEY (id)
) COMMENT 'piece of media. remeber to add score post-calculated.';

-- foreign keys
-- Reference: genres_works (table: work_genres)
ALTER TABLE work_genres ADD CONSTRAINT genres_works FOREIGN KEY genres_works (works_id)
    REFERENCES works (id);

-- Reference: review_likes_reviews (table: review_likes)
ALTER TABLE review_likes ADD CONSTRAINT review_likes_reviews FOREIGN KEY review_likes_reviews (reviews_id)
    REFERENCES reviews (id);

-- Reference: review_likes_user (table: review_likes)
ALTER TABLE review_likes ADD CONSTRAINT review_likes_user FOREIGN KEY review_likes_user (user_id)
    REFERENCES user (id);

-- Reference: reviews_reviews (table: reviews)
ALTER TABLE reviews ADD CONSTRAINT reviews_reviews FOREIGN KEY reviews_reviews (reviews_id)
    REFERENCES reviews (id);

-- Reference: reviews_user (table: reviews)
ALTER TABLE reviews ADD CONSTRAINT reviews_user FOREIGN KEY reviews_user (user_id)
    REFERENCES user (id);

-- Reference: reviews_works (table: reviews)
ALTER TABLE reviews ADD CONSTRAINT reviews_works FOREIGN KEY reviews_works (works_id)
    REFERENCES works (id);

-- Reference: shelf_statuses (table: shelf)
ALTER TABLE shelf ADD CONSTRAINT shelf_statuses FOREIGN KEY shelf_statuses (statuses_id)
    REFERENCES statuses (id);

-- Reference: shelf_user (table: shelf)
ALTER TABLE shelf ADD CONSTRAINT shelf_user FOREIGN KEY shelf_user (user_id)
    REFERENCES user (id);

-- Reference: shelf_works (table: shelf)
ALTER TABLE shelf ADD CONSTRAINT shelf_works FOREIGN KEY shelf_works (works_id)
    REFERENCES works (id);

-- Reference: source_followers (table: user_followers)
ALTER TABLE user_followers ADD CONSTRAINT source_followers FOREIGN KEY source_followers (target_id)
    REFERENCES user (id);

-- Reference: target_followers (table: user_followers)
ALTER TABLE user_followers ADD CONSTRAINT target_followers FOREIGN KEY target_followers (source_id)
    REFERENCES user (id);

-- Reference: work_creators_creators (table: work_creators)
ALTER TABLE work_creators ADD CONSTRAINT work_creators_creators FOREIGN KEY work_creators_creators (creators_id)
    REFERENCES creators (id);

-- Reference: work_creators_works (table: work_creators)
ALTER TABLE work_creators ADD CONSTRAINT work_creators_works FOREIGN KEY work_creators_works (works_id)
    REFERENCES works (id);

-- Reference: work_genres_genres (table: work_genres)
ALTER TABLE work_genres ADD CONSTRAINT work_genres_genres FOREIGN KEY work_genres_genres (genres_id)
    REFERENCES genres (id);

-- End of file.


