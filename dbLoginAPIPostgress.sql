-- --------------------------------------------------------
-- Script de migração MySQL -> PostgreSQL 15
-- Banco de dados: api-doeobem
-- --------------------------------------------------------

-- Drop database se existir e criar nova
DROP DATABASE IF EXISTS "api-doeobem";
CREATE DATABASE "api-doeobem"
    WITH 
    OWNER = root
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TEMPLATE = template0;

\c "api-doeobem";

-- Extensão para suporte a UUID (opcional, mas útil)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- --------------------------------------------------------
-- Tabela users
-- --------------------------------------------------------
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    nickname VARCHAR(40),
    phone1 VARCHAR(30),
    has_whatsapp BOOLEAN DEFAULT FALSE,
    phone2 VARCHAR(30),
    email VARCHAR(250) UNIQUE,
    password VARCHAR(200) NOT NULL,
    postal_code VARCHAR(20),
    address VARCHAR(500),
    number VARCHAR(30),
    complement VARCHAR(30),
    neighborhood VARCHAR(90),
    city VARCHAR(90),
    state CHAR(90),
    country CHAR(90),
    country_code VARCHAR(50),
    state_code VARCHAR(50),
    recovery_key CHAR(32),
    first_access TIMESTAMP,
    last_access TIMESTAMP,
    bio VARCHAR(100),
    website VARCHAR(100),
    access_count INTEGER,
    receive_newsletter BOOLEAN DEFAULT FALSE,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    birth_date TIMESTAMP,
    userscol VARCHAR(45),
    photo VARCHAR(800),
    cover_photo VARCHAR(800),
    google_id VARCHAR(255),
    facebook_id VARCHAR(255) UNIQUE,
    auth_provider VARCHAR(10) DEFAULT 'local' CHECK (auth_provider IN ('local', 'google', 'facebook')),
    email_verified BOOLEAN DEFAULT FALSE,
    verified_profile BOOLEAN DEFAULT FALSE
);

-- Índices para users
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_facebook_id ON users(facebook_id);
CREATE INDEX idx_users_deleted_at ON users(deleted_at);

-- --------------------------------------------------------
-- Tabela posts
-- --------------------------------------------------------
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    description TEXT,
    media_link VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    is_repost BOOLEAN DEFAULT FALSE,
    original_post_id INTEGER,
    original_user_id INTEGER,
    CONSTRAINT fk_posts_original_post FOREIGN KEY (original_post_id) 
        REFERENCES posts(id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_posts_original_user FOREIGN KEY (original_user_id) 
        REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Índices para posts
CREATE INDEX idx_posts_deleted_at ON posts(deleted_at);
CREATE INDEX idx_posts_original_post ON posts(original_post_id);
CREATE INDEX idx_posts_original_user ON posts(original_user_id);

-- --------------------------------------------------------
-- Tabela comments (com suporte a emojis)
-- --------------------------------------------------------
CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    comment TEXT NOT NULL, -- PostgreSQL TEXT suporta emojis nativamente com UTF8
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    CONSTRAINT fk_comments_post FOREIGN KEY (post_id) 
        REFERENCES posts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_comments_user FOREIGN KEY (user_id) 
        REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Índices para comments
CREATE INDEX idx_comments_post_id ON comments(post_id);
CREATE INDEX idx_comments_user_id ON comments(user_id);
CREATE INDEX idx_comments_deleted_at ON comments(deleted_at);

-- --------------------------------------------------------
-- Tabela followers
-- --------------------------------------------------------
CREATE TABLE followers (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    follower_id INTEGER NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    CONSTRAINT fk_followers_user FOREIGN KEY (user_id) 
        REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_followers_follower FOREIGN KEY (follower_id) 
        REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Índices para followers
CREATE INDEX idx_followers_user_id ON followers(user_id);
CREATE INDEX idx_followers_follower_id ON followers(follower_id);
CREATE INDEX idx_followers_deleted_at ON followers(deleted_at);

-- --------------------------------------------------------
-- Tabela likes
-- --------------------------------------------------------
CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    CONSTRAINT fk_likes_post FOREIGN KEY (post_id) 
        REFERENCES posts(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_likes_user FOREIGN KEY (user_id) 
        REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Índices para likes
CREATE INDEX idx_likes_post_id ON likes(post_id);
CREATE INDEX idx_likes_user_id ON likes(user_id);
CREATE INDEX idx_likes_deleted_at ON likes(deleted_at);

-- --------------------------------------------------------
-- Tabela posts_users (tabela pivot)
-- --------------------------------------------------------
CREATE TABLE posts_users (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    post_id INTEGER NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    CONSTRAINT fk_posts_users_user FOREIGN KEY (user_id) 
        REFERENCES users(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_posts_users_post FOREIGN KEY (post_id) 
        REFERENCES posts(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Índices para posts_users
CREATE INDEX idx_posts_users_user_id ON posts_users(user_id);
CREATE INDEX idx_posts_users_post_id ON posts_users(post_id);
CREATE INDEX idx_posts_users_deleted_at ON posts_users(deleted_at);

-- --------------------------------------------------------
-- Inserir dados na tabela users
-- --------------------------------------------------------
INSERT INTO users (id, name, nickname, phone1, has_whatsapp, phone2, email, password, postal_code, address, number, complement, neighborhood, city, state, country, country_code, state_code, recovery_key, first_access, last_access, bio, website, access_count, receive_newsletter, active, created_at, updated_at, deleted_at, birth_date, userscol, photo, cover_photo, google_id, facebook_id, auth_provider, email_verified, verified_profile) VALUES
(2, 'Calebe', NULL, NULL, FALSE, NULL, 'calebe@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', '13392-350', 'teste', '394', NULL, NULL, 'Álvares Florence', 'São Paulo', 'Brasil', NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', NULL, NULL, 2, FALSE, TRUE, '2025-11-24 13:26:09', '2026-02-13 00:33:10', NULL, '1997-09-11 00:00:00', NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/1be21001e4647d409c73c9e2bb350bf1_calebe/1993258390eu4bm.jpg', 'https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebe/1607179466capasound.jpg', NULL, NULL, 'local', TRUE, FALSE),
(3, 'Iasmin Cora', NULL, NULL, FALSE, NULL, 'iasmin@gmail.com', '$2y$10$RLe8jkyB73i5KNYnFRiR5efclCwowVvD1KaQwCDTJqYfRrsayIVx6', '13521-584', 'teste', '395', NULL, NULL, 'Buffalo', 'New York', 'Estados Unidos', NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', NULL, NULL, 2, FALSE, TRUE, '2025-11-24 13:26:09', '2026-02-13 00:34:56', NULL, '1991-07-05 00:00:00', NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/0a0c603e8b59008a552c108a80dffd53_iasmincora/1251455249clouds.jpg', '', NULL, NULL, 'local', TRUE, FALSE),
(4, 'Marcos Bastista', NULL, NULL, FALSE, NULL, 'marcos@gmail.com', '$2y$10$RLe8jkyB73i5KNYnFRiR5efclCwowVvD1KaQwCDTJqYfRrsayIVx6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', NULL, NULL, 2, FALSE, TRUE, '2025-11-24 13:26:09', '2025-11-25 01:51:07', NULL, NULL, NULL, '', '', NULL, NULL, 'local', TRUE, FALSE),
(5, 'Andre ', NULL, NULL, FALSE, NULL, 'andre@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', '97021751', 'teste', '400', NULL, NULL, 'Campinas', 'São Paulo', 'Brasil', NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', NULL, NULL, 2, FALSE, TRUE, '2025-11-24 13:26:09', '2025-11-25 02:09:32', NULL, NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/df8bcc50f015de8677e4025ecb1a369a_andre/1087917545eu3.jpg', '', NULL, NULL, 'local', TRUE, FALSE),
(6, 'Jeniffer Cora', NULL, NULL, FALSE, NULL, 'admin2@user.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', NULL, NULL, 2, FALSE, TRUE, '2025-11-24 13:26:09', '2025-11-25 02:35:00', NULL, NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/f73599fffd54f314ee59a4379278c366_jeniffercora/374066667dubai.jpg', '', NULL, NULL, 'local', TRUE, FALSE),
(7, 'Mora Dias', NULL, NULL, FALSE, NULL, 'mora@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', NULL, NULL, 2, FALSE, TRUE, '2025-11-24 13:26:09', '2025-11-25 01:52:16', NULL, NULL, NULL, '', '', NULL, NULL, 'local', TRUE, FALSE),
(20, 'Teste 1', NULL, NULL, FALSE, NULL, 'teste1@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', NULL, NULL, 2, FALSE, TRUE, '2025-11-24 13:26:09', '2025-11-25 01:54:12', NULL, NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/1be21001e4647d409c73c9e2bb350bf1_calebe/1993258390eu4bm.jpg', 'https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebe/1607179466capasound.jpg', NULL, NULL, 'local', TRUE, FALSE),
(21, 'Teste 2', NULL, NULL, FALSE, NULL, 'teste2@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', NULL, NULL, 2, FALSE, TRUE, '2025-11-24 13:26:09', '2025-11-25 01:54:12', NULL, NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/1be21001e4647d409c73c9e2bb350bf1_calebe/1993258390eu4bm.jpg', 'https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebe/1607179466capasound.jpg', NULL, NULL, 'local', TRUE, FALSE),
(22, 'Teste 3', NULL, NULL, FALSE, NULL, 'teste3@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', NULL, NULL, 2, FALSE, TRUE, '2025-11-24 13:26:09', '2025-11-25 01:54:12', NULL, NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/1be21001e4647d409c73c9e2bb350bf1_calebe/1993258390eu4bm.jpg', 'https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebe/1607179466capasound.jpg', NULL, NULL, 'local', TRUE, FALSE),
(23, 'Teste 4', NULL, NULL, FALSE, NULL, 'teste4@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', NULL, NULL, 2, FALSE, TRUE, '2025-11-24 13:26:09', '2025-11-25 01:54:12', NULL, NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/1be21001e4647d409c73c9e2bb350bf1_calebe/1993258390eu4bm.jpg', 'https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebe/1607179466capasound.jpg', NULL, NULL, 'local', TRUE, FALSE),
(24, 'Teste 5', NULL, NULL, FALSE, NULL, 'teste5@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', NULL, NULL, 2, FALSE, TRUE, '2025-11-24 13:26:09', '2025-11-25 01:54:12', NULL, NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/1be21001e4647d409c73c9e2bb350bf1_calebe/1993258390eu4bm.jpg', 'https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebe/1607179466capasound.jpg', NULL, NULL, 'local', TRUE, FALSE),
(25, 'Teste 6', NULL, NULL, FALSE, NULL, 'teste6@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', NULL, NULL, 2, FALSE, TRUE, '2025-11-24 13:26:09', '2025-11-25 01:54:12', NULL, NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/1be21001e4647d409c73c9e2bb350bf1_calebe/1993258390eu4bm.jpg', 'https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebe/1607179466capasound.jpg', NULL, NULL, 'local', TRUE, FALSE),
(233, 'Hedrei Andrade', NULL, NULL, FALSE, NULL, 'hedreiandrade@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', '13051251', 'teste', '502', NULL, NULL, 'Campinas', 'São Paulo', 'Brazil', 'BR', 'SP', NULL, '2025-11-24 13:26:09', '2026-02-09 05:31:18', 'www.youtube.com/@starprojectt', 'www.hedreiandrade.com.br', 17, FALSE, TRUE, '2025-11-24 13:26:09', '2026-02-24 20:07:11', NULL, '1988-05-06 00:00:00', NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_hedreiandrade/2048186498ha.jpg', 'https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/78722132capayoutube.jpg', NULL, NULL, 'local', TRUE, FALSE);

-- Reset da sequência de users
SELECT setval('users_id_seq', (SELECT MAX(id) FROM users));

-- --------------------------------------------------------
-- Inserir dados na tabela posts
-- --------------------------------------------------------
INSERT INTO posts (id, description, media_link, created_at, updated_at, deleted_at, is_repost, original_post_id, original_user_id) VALUES
(1, 'Meu video psycho', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6924e2f1909f67.26412208.mp4', '2025-11-24 19:57:57', '2025-12-02 23:33:44', '2025-12-02 23:33:44', FALSE, NULL, NULL),
(2, 'teste', 'http://localhost:8015/public/imagesVideos/media/media_6924e85b1aaac5.47538364.mp4', '2025-11-24 20:20:59', '2025-11-24 23:21:17', '2025-11-24 23:21:17', FALSE, NULL, NULL),
(4, 'Olha que video massa !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_69250c633ce117.48206824.mp4', '2025-11-24 22:54:59', '2025-12-24 22:42:19', '2025-12-24 22:42:19', FALSE, NULL, NULL),
(5, 'Ouvindo minha música favorita :)', '', '2025-11-24 22:55:32', '2026-01-21 07:31:22', '2026-01-21 07:31:22', FALSE, NULL, NULL),
(6, 'Assistindo Star Wars !! ❤', '', '2025-11-24 23:05:49', '2026-01-24 22:24:57', '2026-01-24 22:24:57', FALSE, NULL, NULL),
(8, 'Mais um video legal !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_69250f6691ed56.10054038.mp4', '2025-11-24 23:07:45', '2025-12-12 01:19:12', '2025-12-12 01:19:12', FALSE, NULL, NULL),
(9, 'Bom dia pessoal !!', '', '2025-11-24 23:08:11', '2025-11-24 23:08:11', NULL, FALSE, NULL, NULL),
(10, 'Hoje tem jogo do Palmeiras ✔', '', '2025-11-24 23:13:37', '2025-11-24 23:13:37', NULL, FALSE, NULL, NULL),
(12, 'Qual a boa pro final de semana ? 👏🎶✌❤', '', '2025-11-24 23:36:10', '2025-11-24 23:36:10', NULL, FALSE, NULL, NULL),
(57, 'Olha minha mandala by Mara Dias 🎶', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_692f75882dacd8.84178374.jpg', '2025-12-02 20:26:03', '2025-12-09 10:54:56', '2025-12-09 10:54:56', FALSE, NULL, NULL),
(59, 'My psycho video', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_692f776c58de40.26114566.mp4', '2025-12-02 20:34:16', '2025-12-07 15:39:27', '2025-12-07 15:39:27', FALSE, NULL, NULL),
(110, 'Linda mandala by Mara Dias 🖤', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jeniffercora/media_6937e9c19312e0.45876027.jpg', '2025-12-09 06:20:03', '2025-12-09 10:54:10', '2025-12-09 10:54:10', FALSE, NULL, NULL),
(111, 'Video massa !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_6937ea5faccd70.64969834.mp4', '2025-12-09 06:22:47', '2025-12-27 13:24:47', '2025-12-27 13:24:47', FALSE, NULL, NULL),
(115, 'Linda mandalah.', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jeniffercora/media_6937ffebd5e449.71157683.jpg', '2025-12-09 07:54:37', '2025-12-09 11:31:25', '2025-12-09 11:31:25', FALSE, NULL, NULL),
(117, 'Video massa !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6938052de71178.81840058.mp4', '2025-12-09 08:18:10', '2025-12-16 23:30:58', '2025-12-16 23:30:58', FALSE, NULL, NULL),
(122, 'Linda mandala 🖤', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jeniffercora/media_693808a16e8a16.13001595.jpg', '2025-12-09 08:31:47', '2025-12-16 23:22:35', '2025-12-16 23:22:35', FALSE, NULL, NULL),
(141, 'Linda mandala !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jeniffercora/media_6941e9c90ac766.48721806.jpg', '2025-12-16 20:22:51', '2025-12-25 12:52:29', '2025-12-25 12:52:29', FALSE, NULL, NULL),
(155, 'Video show !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_694c6c46461463.30354774.mp4', '2025-12-24 19:43:49', '2025-12-25 12:37:59', '2025-12-25 12:37:59', FALSE, NULL, NULL),
(174, 'Linda mandala 💚', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jeniffercora/media_694d33b395ac17.77759322.jpg', '2025-12-25 09:53:09', '2025-12-25 13:00:31', '2025-12-25 13:00:31', FALSE, NULL, NULL),
(177, 'Linda mandala 💛', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jeniffercora/media_694d3590133546.38560348.jpg', '2025-12-25 10:01:05', '2026-02-05 19:29:28', '2026-02-05 19:29:28', FALSE, NULL, NULL),
(180, 'Que video massa 🖤', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_694fde7520b3f8.85913658.mp4', '2025-12-27 10:26:55', '2026-01-16 19:01:28', '2026-01-16 19:01:28', FALSE, NULL, NULL),
(184, 'Que video massa 🖤', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_696a8b2e22ab28.98752031.mp4', '2026-01-16 16:02:31', '2026-01-20 20:25:47', '2026-01-20 20:25:47', FALSE, NULL, NULL),
(185, 'Esse portfolio é demais 💙', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_696a8b6dd3bb62.82668826.mp4', '2026-01-16 16:04:26', '2026-01-21 07:30:49', '2026-01-21 07:30:49', FALSE, NULL, NULL),
(195, 'Esse portfolio é demais 💚', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_697080ec9d25b1.74774968.mp4', '2026-01-21 04:33:08', '2026-01-24 22:10:19', '2026-01-24 22:10:19', FALSE, NULL, NULL),
(213, 'Esse é meu portfolio : www.hedreiandrade.com.br 💙', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_697cd08bb44137.41719966.mp4', '2026-01-30 12:39:01', '2026-02-14 01:53:58', '2026-02-14 01:53:58', FALSE, NULL, NULL),
(221, 'Linda mandala !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jeniffercora/media_6984efb69bbc95.85955258.jpg', '2026-02-05 16:30:01', '2026-02-10 23:15:54', '2026-02-10 23:15:54', FALSE, NULL, NULL),
(228, 'Linda mandala 🖤', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jeniffercora/media_698bbc3d7e7050.46383409.jpg', '2026-02-10 20:16:15', '2026-02-10 20:16:15', NULL, FALSE, NULL, NULL),
(232, 'Esse é o meu portfolio 🖤\r\nwww.hedreiandrade.com.br', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_698fd5d9cf62d4.97939550.mp4', '2026-02-13 22:56:19', '2026-02-13 22:56:19', NULL, FALSE, NULL, NULL);

-- Reset da sequência de posts
SELECT setval('posts_id_seq', (SELECT MAX(id) FROM posts));

-- --------------------------------------------------------
-- Inserir dados na tabela posts_users
-- --------------------------------------------------------
INSERT INTO posts_users (id, user_id, post_id, created_at, updated_at, deleted_at) VALUES
(1, 233, 1, '2025-11-24 19:57:57', '2025-11-24 19:57:57', NULL),
(4, 2, 4, '2025-11-24 22:54:59', '2025-11-24 22:54:59', NULL),
(5, 2, 5, '2025-11-24 22:55:32', '2025-11-24 22:55:32', NULL),
(6, 2, 6, '2025-11-24 23:05:49', '2025-11-24 23:05:49', NULL),
(9, 2, 9, '2025-11-24 23:08:11', '2025-11-24 23:08:11', NULL),
(10, 233, 10, '2025-11-24 23:13:37', '2025-11-24 23:13:37', NULL),
(12, 6, 12, '2025-11-24 23:36:10', '2025-11-24 23:36:10', NULL),
(57, 233, 57, '2025-12-02 20:26:03', '2025-12-02 20:26:03', NULL),
(110, 6, 110, '2025-12-09 06:20:03', '2025-12-09 06:20:03', NULL),
(111, 2, 111, '2025-12-09 06:22:47', '2025-12-09 06:22:47', NULL),
(115, 6, 115, '2025-12-09 07:54:37', '2025-12-09 07:54:37', NULL),
(117, 233, 117, '2025-12-09 08:18:10', '2025-12-09 08:18:10', NULL),
(122, 6, 122, '2025-12-09 08:31:47', '2025-12-09 08:31:47', NULL),
(141, 6, 141, '2025-12-16 20:22:51', '2025-12-16 20:22:51', NULL),
(155, 2, 155, '2025-12-24 19:43:49', '2025-12-24 19:43:49', NULL),
(174, 6, 174, '2025-12-25 09:53:09', '2025-12-25 09:53:09', NULL),
(177, 6, 177, '2025-12-25 10:01:05', '2025-12-25 10:01:05', NULL),
(180, 2, 180, '2025-12-27 10:26:55', '2025-12-27 10:26:55', NULL),
(184, 2, 184, '2026-01-16 16:02:31', '2026-01-16 16:02:31', NULL),
(185, 2, 185, '2026-01-16 16:04:26', '2026-01-16 16:04:26', NULL),
(195, 2, 195, '2026-01-21 04:33:08', '2026-01-21 04:33:08', NULL),
(213, 233, 213, '2026-01-30 12:39:01', '2026-01-30 12:39:01', NULL),
(221, 6, 221, '2026-02-05 16:30:01', '2026-02-05 16:30:01', NULL),
(228, 6, 228, '2026-02-10 20:16:15', '2026-02-10 20:16:15', NULL),
(232, 233, 232, '2026-02-13 22:56:19', '2026-02-13 22:56:19', NULL);

-- Reset da sequência de posts_users
SELECT setval('posts_users_id_seq', (SELECT MAX(id) FROM posts_users));

-- --------------------------------------------------------
-- Inserir dados na tabela comments
-- --------------------------------------------------------
INSERT INTO comments (id, post_id, user_id, comment, created_at, updated_at, deleted_at) VALUES
(1, 1, 5, 'Demais! ❤', '2025-11-24 23:09:58', '2025-11-24 23:09:58', NULL),
(2, 4, 5, 'Top !', '2025-11-24 23:10:06', '2025-11-24 23:10:06', NULL),
(3, 1, 6, 'Lindo!', '2025-11-24 23:10:31', '2025-11-24 23:10:31', NULL),
(22, 57, 6, 'Linda mandala :) 🖤', '2025-12-02 20:27:40', '2025-12-02 20:27:40', NULL),
(31, 4, 233, 'Massa!', '2025-12-08 01:00:04', '2025-12-08 01:00:04', NULL),
(33, 110, 5, 'Gostei :)', '2025-12-09 06:21:11', '2025-12-09 06:21:11', NULL),
(44, 174, 233, ':)', '2025-12-25 09:55:22', '2025-12-25 09:55:22', NULL),
(73, 177, 233, 'Linda !', '2026-01-28 23:07:15', '2026-01-28 23:07:15', NULL),
(74, 178, 6, 'Top !', '2026-01-29 07:21:28', '2026-01-29 07:21:28', NULL),
(81, 213, 6, 'Gostei do design 🖤', '2026-02-05 16:30:40', '2026-02-05 16:30:40', NULL),
(82, 221, 233, 'Linda!', '2026-02-05 16:31:29', '2026-02-05 16:31:29', NULL),
(85, 228, 233, 'Linda !', '2026-02-10 20:16:46', '2026-02-10 20:16:46', NULL);

-- Reset da sequência de comments
SELECT setval('comments_id_seq', (SELECT MAX(id) FROM comments));

-- --------------------------------------------------------
-- Inserir dados na tabela followers
-- --------------------------------------------------------
INSERT INTO followers (id, user_id, follower_id, created_at, updated_at, deleted_at) VALUES
(1, 233, 2, '2025-11-25 01:49:39', '2025-11-25 01:49:39', NULL),
(2, 233, 3, '2025-11-25 01:49:59', '2025-11-25 01:49:59', NULL),
(3, 2, 3, '2025-11-25 01:50:07', '2025-11-25 01:50:07', NULL),
(4, 4, 3, '2025-11-25 01:50:40', '2025-11-25 01:50:40', NULL),
(5, 233, 4, '2025-11-25 01:51:15', '2025-11-25 01:51:15', NULL),
(8, 2, 5, '2025-11-25 01:51:55', '2025-11-25 01:51:55', NULL),
(9, 233, 5, '2025-11-25 01:52:02', '2025-11-25 01:52:02', NULL),
(11, 233, 6, '2025-11-25 01:52:27', '2025-11-25 01:52:27', NULL),
(15, 5, 233, '2025-11-25 01:53:09', '2025-11-25 01:53:09', NULL),
(16, 3, 2, '2025-11-25 02:08:51', '2025-11-25 02:08:51', NULL),
(17, 233, 7, '2025-11-25 02:30:18', '2025-11-25 02:30:18', NULL),
(18, 3, 233, '2025-12-02 23:29:57', '2025-12-02 23:29:57', NULL),
(20, 7, 233, '2025-12-07 15:20:09', '2025-12-07 15:20:09', NULL),
(21, 6, 7, '2025-12-07 20:22:32', '2025-12-07 20:22:32', NULL),
(23, 6, 5, '2025-12-09 09:20:57', '2025-12-09 09:20:57', NULL),
(24, 6, 233, '2025-12-09 11:20:28', '2025-12-09 11:20:28', NULL),
(25, 2, 233, '2025-12-25 12:58:48', '2025-12-25 12:58:48', NULL),
(26, 5, 2, '2026-02-08 07:39:52', '2026-02-08 07:39:52', NULL),
(28, 7, 2, '2026-02-08 07:40:29', '2026-02-08 07:40:29', NULL),
(29, 20, 2, '2026-02-08 07:43:32', '2026-02-08 07:43:32', NULL),
(30, 21, 2, '2026-02-08 07:43:42', '2026-02-08 07:43:42', NULL),
(35, 2, 20, '2026-02-08 07:45:34', '2026-02-08 07:45:34', NULL),
(36, 2, 21, '2026-02-08 07:45:34', '2026-02-08 07:45:34', NULL),
(37, 2, 22, '2026-02-08 07:45:34', '2026-02-08 07:45:34', NULL),
(38, 2, 23, '2026-02-08 04:47:26', NULL, NULL),
(39, 2, 24, '2026-02-08 04:47:27', NULL, NULL),
(40, 2, 25, '2026-02-08 04:47:28', NULL, NULL);

-- Reset da sequência de followers
SELECT setval('followers_id_seq', (SELECT MAX(id) FROM followers));

-- --------------------------------------------------------
-- Inserir dados na tabela likes
-- --------------------------------------------------------
INSERT INTO likes (id, post_id, user_id, created_at, updated_at, deleted_at) VALUES
(2, 9, 5, '2025-11-25 02:09:38', '2025-11-25 02:09:38', NULL),
(3, 8, 5, '2025-11-25 02:09:40', '2025-11-25 02:09:40', NULL),
(4, 6, 5, '2025-11-25 02:09:41', '2025-11-25 02:09:41', NULL),
(5, 5, 5, '2025-11-25 02:09:42', '2025-11-25 02:09:42', NULL),
(6, 4, 5, '2025-11-25 02:09:43', '2025-11-25 02:09:43', NULL),
(7, 1, 5, '2025-11-25 02:09:44', '2025-11-25 02:09:44', NULL),
(8, 1, 6, '2025-11-25 02:10:24', '2025-11-25 02:10:24', NULL),
(14, 9, 3, '2025-11-25 02:12:21', '2025-11-25 02:12:21', NULL),
(16, 6, 3, '2025-11-25 02:12:22', '2025-11-25 02:12:22', NULL),
(17, 5, 3, '2025-11-25 02:12:24', '2025-11-25 02:12:24', NULL),
(18, 4, 3, '2025-11-25 02:12:25', '2025-11-25 02:12:25', NULL),
(19, 1, 3, '2025-11-25 02:12:42', '2025-11-25 02:12:42', NULL),
(22, 4, 233, '2025-11-29 00:12:00', '2025-11-29 00:12:00', NULL),
(26, 57, 6, '2025-12-02 23:27:23', '2025-12-02 23:27:23', NULL),
(36, 10, 6, '2025-12-09 09:17:58', '2025-12-09 09:17:58', NULL),
(37, 57, 5, '2025-12-09 09:20:40', '2025-12-09 09:20:40', NULL),
(38, 10, 5, '2025-12-09 09:20:42', '2025-12-09 09:20:42', NULL),
(39, 110, 5, '2025-12-09 09:21:00', '2025-12-09 09:21:00', NULL),
(40, 111, 233, '2025-12-09 09:23:55', '2025-12-09 09:23:55', NULL),
(41, 110, 233, '2025-12-09 09:24:09', '2025-12-09 09:24:09', NULL),
(42, 115, 233, '2025-12-09 10:55:01', '2025-12-09 10:55:01', NULL),
(43, 12, 233, '2025-12-09 11:19:39', '2025-12-09 11:19:39', NULL),
(44, 8, 233, '2025-12-09 11:25:37', '2025-12-09 11:25:37', NULL),
(50, 174, 233, '2025-12-25 12:53:26', '2025-12-25 12:53:26', NULL),
(51, 177, 233, '2025-12-25 13:01:41', '2025-12-25 13:01:41', NULL),
(52, 180, 233, '2025-12-27 13:28:37', '2025-12-27 13:28:37', NULL),
(56, 5, 233, '2026-01-19 23:29:30', '2026-01-19 23:29:30', NULL),
(58, 184, 233, '2026-01-19 23:33:08', '2026-01-19 23:33:08', NULL),
(59, 6, 233, '2026-01-20 20:27:50', '2026-01-20 20:27:50', NULL),
(60, 185, 233, '2026-01-20 20:32:09', '2026-01-20 20:32:09', NULL),
(61, 195, 233, '2026-01-21 07:35:02', '2026-01-21 07:35:02', NULL),
(62, 213, 6, '2026-02-05 19:30:09', '2026-02-05 19:30:09', NULL),
(63, 221, 233, '2026-02-05 19:31:24', '2026-02-05 19:31:24', NULL),
(65, 228, 233, '2026-02-10 23:16:41', '2026-02-10 23:16:41', NULL);

-- Reset da sequência de likes
SELECT setval('likes_id_seq', (SELECT MAX(id) FROM likes));

-- --------------------------------------------------------
-- Atualizar a sequência de todas as tabelas
-- --------------------------------------------------------
SELECT setval('users_id_seq', (SELECT MAX(id) FROM users));
SELECT setval('posts_id_seq', (SELECT MAX(id) FROM posts));
SELECT setval('posts_users_id_seq', (SELECT MAX(id) FROM posts_users));
SELECT setval('comments_id_seq', (SELECT MAX(id) FROM comments));
SELECT setval('followers_id_seq', (SELECT MAX(id) FROM followers));
SELECT setval('likes_id_seq', (SELECT MAX(id) FROM likes));

-- --------------------------------------------------------
-- Comentários sobre as tabelas
-- --------------------------------------------------------
COMMENT ON TABLE users IS 'Usuários da plataforma';
COMMENT ON TABLE posts IS 'Posts e reposts';
COMMENT ON TABLE comments IS 'Comentários com suporte a emojis';
COMMENT ON TABLE followers IS 'Relação de seguidores';
COMMENT ON TABLE likes IS 'Curtidas';
COMMENT ON TABLE posts_users IS 'Relação posts-usuários';