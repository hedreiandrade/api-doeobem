--
-- PostgreSQL database dump
--

\restrict B6uRZLcEvfJkIQPoOgWi1d3SagkKwraaZCp2ZdGXC1wck0zhSfgbp4GXMPph3wo

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


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
-- Name: TABLE comments; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE public.comments IS 'Comentários com suporte a emojis';


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


ALTER TABLE public.comments_id_seq OWNER TO root;

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
-- Name: TABLE followers; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE public.followers IS 'Relação de seguidores';


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


ALTER TABLE public.followers_id_seq OWNER TO root;

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
-- Name: TABLE likes; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE public.likes IS 'Curtidas';


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


ALTER TABLE public.likes_id_seq OWNER TO root;

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
-- Name: TABLE posts; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE public.posts IS 'Posts e reposts';


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


ALTER TABLE public.posts_id_seq OWNER TO root;

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
-- Name: TABLE posts_users; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE public.posts_users IS 'Relação posts-usuários';


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


ALTER TABLE public.posts_users_id_seq OWNER TO root;

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
    state character(90),
    country character(90),
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
    CONSTRAINT users_auth_provider_check CHECK (((auth_provider)::text = ANY ((ARRAY['local'::character varying, 'google'::character varying, 'facebook'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO root;

--
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON TABLE public.users IS 'Usuários da plataforma';


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


ALTER TABLE public.users_id_seq OWNER TO root;

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
2	236	235	Demais!	2026-02-27 20:20:50	2026-02-27 20:20:50	\N
3	237	235	Linda 🖤	2026-02-27 20:21:02	2026-02-27 20:21:02	\N
4	239	234	Qual é ?	2026-02-27 20:26:20	2026-02-27 20:26:20	\N
5	238	234	Top !	2026-02-27 20:26:29	2026-02-27 20:26:29	\N
6	236	236	Uruuu!	2026-02-27 20:31:04	2026-02-27 20:31:04	\N
7	237	236	Massa!	2026-02-27 20:31:11	2026-02-27 20:31:11	\N
8	244	235	Boraa\n	2026-02-27 20:38:17	2026-02-27 20:38:17	\N
\.


--
-- Data for Name: followers; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.followers (id, user_id, follower_id, created_at, updated_at, deleted_at) FROM stdin;
41	234	235	2026-02-27 23:20:38	2026-02-27 23:20:38	\N
42	235	234	2026-02-27 23:24:49	2026-02-27 23:24:49	\N
43	235	236	2026-02-27 23:30:42	2026-02-27 23:30:42	\N
44	234	236	2026-02-27 23:30:48	2026-02-27 23:30:48	\N
45	236	234	2026-02-27 23:34:47	2026-02-27 23:34:47	\N
46	236	235	2026-02-27 23:35:40	2026-02-27 23:35:40	\N
\.


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.likes (id, post_id, user_id, created_at, updated_at, deleted_at) FROM stdin;
67	237	235	2026-02-27 23:20:42	2026-02-27 23:20:42	\N
68	236	235	2026-02-27 23:20:44	2026-02-27 23:20:44	\N
69	239	234	2026-02-27 23:26:05	2026-02-27 23:26:05	\N
70	238	234	2026-02-27 23:26:07	2026-02-27 23:26:07	\N
71	240	236	2026-02-27 23:30:54	2026-02-27 23:30:54	\N
72	237	236	2026-02-27 23:30:55	2026-02-27 23:30:55	\N
73	236	236	2026-02-27 23:30:57	2026-02-27 23:30:57	\N
74	238	236	2026-02-27 23:32:03	2026-02-27 23:32:03	\N
75	239	236	2026-02-27 23:32:06	2026-02-27 23:32:06	\N
76	241	236	2026-02-27 23:32:11	2026-02-27 23:32:11	\N
77	242	235	2026-02-27 23:35:55	2026-02-27 23:35:55	\N
78	244	235	2026-02-27 23:38:09	2026-02-27 23:38:09	\N
79	245	234	2026-02-27 23:38:34	2026-02-27 23:38:34	\N
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.posts (id, description, media_link, created_at, updated_at, deleted_at, is_repost, original_post_id, original_user_id) FROM stdin;
240	Linda foto 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_69a227e44c64f7.49248449.jpg	2026-02-27 20:26:07	2026-02-27 20:26:07	\N	t	238	235
241	Esse é o meu portfolio www.hedreiandrade.com.br	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a2253c4da8e1.40096791.mp4	2026-02-27 20:26:43	2026-02-27 20:26:43	\N	t	236	234
236	Esse é o meu portfolio www.hedreiandrade.com.br	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a2253c4da8e1.40096791.mp4	2026-02-27 20:17:26	2026-02-27 20:17:26	\N	f	\N	\N
237	Linda art 💓	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a2261f8d1340.52867848.mp4	2026-02-27 20:18:01	2026-02-27 20:18:01	\N	f	\N	\N
238	Linda foto 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_69a227e44c64f7.49248449.jpg	2026-02-27 20:25:25	2026-02-27 20:25:25	\N	f	\N	\N
239	Ouvindo minha música favorita 🤍		2026-02-27 20:25:56	2026-02-27 20:25:56	\N	f	\N	\N
242	Linda art 💓	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a2261f8d1340.52867848.mp4	2026-02-27 20:31:18	2026-02-27 20:31:18	\N	t	237	234
243	teste		2026-02-27 20:37:17	2026-02-27 23:37:27	2026-02-27 23:37:27	f	\N	\N
244	Bora para um role ?		2026-02-27 20:37:38	2026-02-27 20:37:38	\N	f	\N	\N
245	Hoje tem jogo do palmeiras 💚		2026-02-27 20:38:08	2026-02-27 20:38:08	\N	f	\N	\N
246	Hoje tem jogo do palmeiras 💚		2026-02-27 20:38:37	2026-02-27 20:38:37	\N	t	245	235
\.


--
-- Data for Name: posts_users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.posts_users (id, user_id, post_id, created_at, updated_at, deleted_at) FROM stdin;
236	234	236	2026-02-27 20:17:26	2026-02-27 20:17:26	\N
237	234	237	2026-02-27 20:18:01	2026-02-27 20:18:01	\N
238	235	238	2026-02-27 20:25:25	2026-02-27 20:25:25	\N
239	235	239	2026-02-27 20:25:57	2026-02-27 20:25:57	\N
240	234	240	2026-02-27 20:26:07	2026-02-27 20:26:07	\N
241	235	241	2026-02-27 20:26:43	2026-02-27 20:26:43	\N
242	236	242	2026-02-27 20:31:18	2026-02-27 20:31:18	\N
243	234	243	2026-02-27 20:37:17	2026-02-27 20:37:17	\N
244	234	244	2026-02-27 20:37:38	2026-02-27 20:37:38	\N
245	235	245	2026-02-27 20:38:08	2026-02-27 20:38:08	\N
246	234	246	2026-02-27 20:38:37	2026-02-27 20:38:37	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.users (id, name, nickname, phone1, has_whatsapp, phone2, email, password, postal_code, address, number, complement, neighborhood, city, state, country, country_code, state_code, recovery_key, first_access, last_access, bio, website, access_count, receive_newsletter, active, created_at, updated_at, deleted_at, birth_date, userscol, photo, cover_photo, google_id, facebook_id, auth_provider, email_verified, verified_profile) FROM stdin;
235	Calebe	\N	\N	f	\N	calebe@gmail.com	$2y$10$fO5Q3q4X0ryLSpn1gJCL9uuoRha7vMRpZHzyg5dBkxbAnWV8qPNU6	12548-965	teste	5649	\N	\N	Alexandria	New South Wales                                                                           	Australia                                                                                 	AU	NSW	\N	2026-02-27 23:20:09	\N	Quero ir para Dubai	www.calebe.com.br	\N	f	t	2026-02-27 23:20:09	2026-02-27 23:28:14	\N	2026-02-19 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_calebe/662499726dubai.jpg	https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebe/1493033707capasound.jpg	\N	\N	local	t	f
236	Iasmin Cora	\N	\N	f	\N	iasmin@gmail.com	$2y$10$mESHqdJ.9s5Q9J0tM6zLvOREh/jjARY7DWWwykdGHLwu3D8MnoF2e	79845-568	teste	232	\N	\N	Hanchuan	Hubei                                                                                     	China                                                                                     	CN	HB	\N	2026-02-27 23:30:11	\N	\N	\N	\N	f	t	2026-02-27 23:30:11	2026-02-27 23:30:21	\N	2026-02-27 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_iasmincora/1138954363eu3.jpg	\N	\N	\N	local	t	f
234	Hedrei Andrade	\N	\N	f	\N	hedreiandrade@gmail.com	$2y$10$HJVF4O.G4zVzzicLv3lJ5O8JR4duVhavkrAfPYSq1tRYB.f1W5yP.	13051251	teste	897	\N	\N	Campinas	São Paulo                                                                                 	Brazil                                                                                    	BR	SP	\N	2026-02-27 23:12:31	2026-02-27 23:27:17	www.youtube.com/@starprojectt	www.hedreiandrade.com.br	1	f	t	2026-02-27 23:12:31	2026-02-27 23:34:25	\N	1988-05-06 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_hedreiandrade/2079120035ha.jpg	https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/1455450947capayoutube.jpg	\N	\N	local	t	f
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.comments_id_seq', 8, true);


--
-- Name: followers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.followers_id_seq', 46, true);


--
-- Name: likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.likes_id_seq', 79, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.posts_id_seq', 246, true);


--
-- Name: posts_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.posts_users_id_seq', 246, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.users_id_seq', 236, true);


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
    ADD CONSTRAINT fk_likes_post FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: likes fk_likes_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT fk_likes_user FOREIGN KEY (user_id) REFERENCES public.users(id);


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
    ADD CONSTRAINT fk_posts_users_post FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: posts_users fk_posts_users_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.posts_users
    ADD CONSTRAINT fk_posts_users_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict B6uRZLcEvfJkIQPoOgWi1d3SagkKwraaZCp2ZdGXC1wck0zhSfgbp4GXMPph3wo

