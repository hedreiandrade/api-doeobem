--
-- PostgreSQL database dump
--

\restrict us9Q3ufUhTVREZ4qNqqFck2G2lnhK3rIfqBHCEBKO5R1xEr8oy95SVQ0ivlMhcA

-- Dumped from database version 17.9 (Debian 17.9-1.pgdg13+1)
-- Dumped by pg_dump version 17.9 (Debian 17.9-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    post_id integer NOT NULL,
    user_id integer NOT NULL,
    comment text NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.comments OWNER TO root;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO root;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: followers; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.followers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    follower_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.followers OWNER TO root;

--
-- Name: followers_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.followers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.followers_id_seq OWNER TO root;

--
-- Name: followers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.followers_id_seq OWNED BY public.followers.id;


--
-- Name: likes; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.likes (
    id integer NOT NULL,
    post_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.likes OWNER TO root;

--
-- Name: likes_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.likes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.likes_id_seq OWNER TO root;

--
-- Name: likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.likes_id_seq OWNED BY public.likes.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    description text,
    media_link character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone,
    is_repost boolean DEFAULT false,
    original_post_id integer,
    original_user_id integer
);


ALTER TABLE public.posts OWNER TO root;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO root;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: posts_users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.posts_users (
    id integer NOT NULL,
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone
);


ALTER TABLE public.posts_users OWNER TO root;

--
-- Name: posts_users_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.posts_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_users_id_seq OWNER TO root;

--
-- Name: posts_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.posts_users_id_seq OWNED BY public.posts_users.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(200),
    nickname character varying(40),
    phone1 character varying(30),
    has_whatsapp boolean DEFAULT false,
    phone2 character varying(30),
    email character varying(250),
    password character varying(200) NOT NULL,
    postal_code character varying(20),
    address character varying(500),
    number character varying(30),
    complement character varying(30),
    neighborhood character varying(90),
    city character varying(90),
    state character varying(90),
    country character varying(90),
    country_code character varying(50),
    state_code character varying(50),
    recovery_key character(32),
    first_access timestamp without time zone,
    last_access timestamp without time zone,
    bio character varying(100),
    website character varying(100),
    access_count integer,
    receive_newsletter boolean DEFAULT false,
    active boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    deleted_at timestamp without time zone,
    birth_date timestamp without time zone,
    userscol character varying(45),
    photo character varying(800),
    cover_photo character varying(800),
    google_id character varying(255),
    facebook_id character varying(255),
    auth_provider character varying(10) DEFAULT 'local'::character varying,
    email_verified boolean DEFAULT false,
    verified_profile boolean DEFAULT false,
    CONSTRAINT auth_provider_check CHECK (((auth_provider)::text = ANY ((ARRAY['local'::character varying, 'google'::character varying, 'facebook'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO root;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO root;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: followers id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.followers ALTER COLUMN id SET DEFAULT nextval('public.followers_id_seq'::regclass);


--
-- Name: likes id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.likes ALTER COLUMN id SET DEFAULT nextval('public.likes_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: posts_users id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.posts_users ALTER COLUMN id SET DEFAULT nextval('public.posts_users_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.comments (id, post_id, user_id, comment, created_at, updated_at, deleted_at) FROM stdin;
1	1	2	Lindo!	2026-03-02 20:46:10	2026-03-02 20:46:10	\N
2	2	2	Top!	2026-03-02 20:46:30	2026-03-02 20:46:30	\N
3	2	3	Demais!	2026-03-02 20:49:23	2026-03-02 20:49:23	\N
4	1	3	Amei!	2026-03-02 20:49:34	2026-03-02 20:49:34	\N
\.


--
-- Data for Name: followers; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.followers (id, user_id, follower_id, created_at, updated_at, deleted_at) FROM stdin;
1	1	2	2026-03-02 23:45:42	2026-03-02 23:45:42	\N
2	1	3	2026-03-02 23:48:34	2026-03-02 23:48:34	\N
3	2	3	2026-03-02 23:48:39	2026-03-02 23:48:39	\N
4	3	1	2026-03-02 23:50:21	2026-03-02 23:50:21	\N
5	2	1	2026-03-02 23:50:24	2026-03-02 23:50:24	\N
\.


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.likes (id, post_id, user_id, created_at, updated_at, deleted_at) FROM stdin;
1	1	2	2026-03-02 23:46:05	2026-03-02 23:46:05	\N
2	2	2	2026-03-02 23:46:25	2026-03-02 23:46:25	\N
3	3	3	2026-03-02 23:49:18	2026-03-02 23:49:18	\N
4	2	3	2026-03-02 23:49:19	2026-03-02 23:49:19	\N
5	1	3	2026-03-02 23:49:29	2026-03-02 23:49:29	\N
6	3	1	2026-03-02 23:50:27	2026-03-02 23:50:27	\N
7	4	1	2026-03-02 23:50:32	2026-03-02 23:50:32	\N
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.posts (id, description, media_link, created_at, updated_at, deleted_at, is_repost, original_post_id, original_user_id) FROM stdin;
1	Esse é o meu portfolio 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a61f391fd426.45868746.mp4	2026-03-02 20:42:26	2026-03-02 20:42:26	\N	f	\N	\N
2	MVP da H Media 💙	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a620913354d6.86533246.mp4	2026-03-02 20:43:45	2026-03-02 20:43:45	\N	f	\N	\N
3	Esse é o meu portfolio 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a61f391fd426.45868746.mp4	2026-03-02 20:46:13	2026-03-02 20:46:13	\N	t	1	1
5	Esse é o meu portfolio 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a61f391fd426.45868746.mp4	2026-03-02 20:49:25	2026-03-02 20:49:25	\N	t	1	1
4	Bom dia pessoal! 💜		2026-03-02 20:49:12	2026-03-02 23:51:35	2026-03-02 23:51:35	f	\N	\N
6	Bom dia Pessoal		2026-03-02 20:51:40	2026-03-02 20:51:40	\N	f	\N	\N
7	Vamos pescar hj 💦 ?		2026-03-02 20:51:54	2026-03-02 20:51:54	\N	f	\N	\N
\.


--
-- Data for Name: posts_users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.posts_users (id, user_id, post_id, created_at, updated_at, deleted_at) FROM stdin;
1	1	1	2026-03-02 20:42:26	2026-03-02 20:42:26	\N
2	1	2	2026-03-02 20:43:45	2026-03-02 20:43:45	\N
3	2	3	2026-03-02 20:46:13	2026-03-02 20:46:13	\N
4	3	4	2026-03-02 20:49:12	2026-03-02 20:49:12	\N
5	3	5	2026-03-02 20:49:25	2026-03-02 20:49:25	\N
6	3	6	2026-03-02 20:51:40	2026-03-02 20:51:40	\N
7	3	7	2026-03-02 20:51:54	2026-03-02 20:51:54	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.users (id, name, nickname, phone1, has_whatsapp, phone2, email, password, postal_code, address, number, complement, neighborhood, city, state, country, country_code, state_code, recovery_key, first_access, last_access, bio, website, access_count, receive_newsletter, active, created_at, updated_at, deleted_at, birth_date, userscol, photo, cover_photo, google_id, facebook_id, auth_provider, email_verified, verified_profile) FROM stdin;
2	Calebe Andrade	\N	\N	f	\N	calebe@gmail.com	$2y$10$2TeaEg6VWyHyGlfSaM88DeQQEhf.6iQ.uFmb8myjy2fLeoi65KIay	13392-350	teste	5656	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-03-02 23:45:12	\N	Meu site www.calebe.com.br	\N	\N	f	t	2026-03-02 23:45:12	2026-03-02 23:45:21	\N	2026-03-02 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_calebeandrade/1650059618eu3.jpg	\N	\N	\N	local	t	f
3	Thor Tron	\N	\N	f	\N	thor@gmail.com	$2y$10$1DJQc0HcpVsMmOfnz/PdsOVKLtYgQaZOCr7EEskqMa95aYlQ1WVMW	13392-350	teste	265	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-03-02 23:48:07	\N	www.thor.com.br	www.mixcloud.com/starprojectt	\N	f	t	2026-03-02 23:48:07	2026-03-02 23:48:14	\N	2026-03-02 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_thortron/1578230748euuu.jpg	\N	\N	\N	local	t	f
1	Hedrei Andrade	\N	\N	f	\N	hedreiandrade@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	13051251	teste	989	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-02-28 01:13:41	\N	www.youtube.com/@starprojectt	www.hedreiandrade.com.br	\N	f	t	2026-02-28 01:13:41	2026-02-28 01:13:58	\N	1988-05-07 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_hedreiandrade/35275069ha.jpg	\N	\N	\N	local	t	f
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.comments_id_seq', 4, true);


--
-- Name: followers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.followers_id_seq', 5, true);


--
-- Name: likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.likes_id_seq', 7, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.posts_id_seq', 7, true);


--
-- Name: posts_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.posts_users_id_seq', 7, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: followers followers_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT followers_pkey PRIMARY KEY (id);


--
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: posts_users posts_users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.posts_users
    ADD CONSTRAINT posts_users_pkey PRIMARY KEY (id);


--
-- Name: followers unique_follow; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT unique_follow UNIQUE (user_id, follower_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_facebook_id_key; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_facebook_id_key UNIQUE (facebook_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_comments_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_comments_deleted_at ON public.comments USING btree (deleted_at);


--
-- Name: idx_comments_post_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_comments_post_id ON public.comments USING btree (post_id);


--
-- Name: idx_comments_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_comments_user_id ON public.comments USING btree (user_id);


--
-- Name: idx_followers_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_followers_deleted_at ON public.followers USING btree (deleted_at);


--
-- Name: idx_followers_follower_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_followers_follower_id ON public.followers USING btree (follower_id);


--
-- Name: idx_followers_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_followers_user_id ON public.followers USING btree (user_id);


--
-- Name: idx_likes_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_likes_deleted_at ON public.likes USING btree (deleted_at);


--
-- Name: idx_likes_post_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_likes_post_id ON public.likes USING btree (post_id);


--
-- Name: idx_likes_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_likes_user_id ON public.likes USING btree (user_id);


--
-- Name: idx_posts_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_posts_deleted_at ON public.posts USING btree (deleted_at);


--
-- Name: idx_posts_original_post; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_posts_original_post ON public.posts USING btree (original_post_id);


--
-- Name: idx_posts_original_user; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_posts_original_user ON public.posts USING btree (original_user_id);


--
-- Name: idx_posts_users_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_posts_users_deleted_at ON public.posts_users USING btree (deleted_at);


--
-- Name: idx_posts_users_post_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_posts_users_post_id ON public.posts_users USING btree (post_id);


--
-- Name: idx_posts_users_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_posts_users_user_id ON public.posts_users USING btree (user_id);


--
-- Name: idx_users_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_deleted_at ON public.users USING btree (deleted_at);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: idx_users_facebook_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_users_facebook_id ON public.users USING btree (facebook_id);


--
-- Name: comments fk_comments_post; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_comments_post FOREIGN KEY (post_id) REFERENCES public.posts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comments fk_comments_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_comments_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: followers fk_followers_follower; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT fk_followers_follower FOREIGN KEY (follower_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: followers fk_followers_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.followers
    ADD CONSTRAINT fk_followers_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: likes fk_likes_post; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT fk_likes_post FOREIGN KEY (post_id) REFERENCES public.posts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: likes fk_likes_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT fk_likes_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: posts fk_posts_original_post; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT fk_posts_original_post FOREIGN KEY (original_post_id) REFERENCES public.posts(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: posts fk_posts_original_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT fk_posts_original_user FOREIGN KEY (original_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: posts_users fk_posts_users_post; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.posts_users
    ADD CONSTRAINT fk_posts_users_post FOREIGN KEY (post_id) REFERENCES public.posts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: posts_users fk_posts_users_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.posts_users
    ADD CONSTRAINT fk_posts_users_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict us9Q3ufUhTVREZ4qNqqFck2G2lnhK3rIfqBHCEBKO5R1xEr8oy95SVQ0ivlMhcA

