--
-- PostgreSQL database dump
--

\restrict xWYkfjAD5bwaeMEwuUYc6ofXn7QM8ApafuuevVsdceoRuRLxTyhIzrFEd12wG0v

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
    original_user_id integer,
    music_link character varying(255)
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
    CONSTRAINT auth_provider_check CHECK (((auth_provider)::text = ANY (ARRAY[('local'::character varying)::text, ('google'::character varying)::text, ('facebook'::character varying)::text])))
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
5	7	1	Bora ?	2026-03-22 18:43:29	2026-03-22 18:43:29	\N
6	6	1	Bom dia!	2026-03-22 18:51:59	2026-03-22 18:51:59	\N
7	72	1	teste	2026-06-05 12:25:42	2026-06-05 12:25:42	\N
8	72	1	🖤	2026-06-05 12:26:05	2026-06-05 12:26:05	\N
\.


--
-- Data for Name: followers; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.followers (id, user_id, follower_id, created_at, updated_at, deleted_at) FROM stdin;
1	1	2	2026-03-02 23:45:42	2026-03-02 23:45:42	\N
2	1	3	2026-03-02 23:48:34	2026-03-02 23:48:34	\N
3	2	3	2026-03-02 23:48:39	2026-03-02 23:48:39	\N
4	3	1	2026-03-02 23:50:21	2026-03-02 23:50:21	\N
14	2	1	2026-06-05 15:39:07	2026-06-05 15:39:35	2026-06-05 15:39:35
16	2	1	2026-06-05 15:49:13	2026-06-05 15:49:35	2026-06-05 15:49:35
17	2	1	2026-06-05 15:49:52	2026-06-05 15:49:52	\N
6	4	1	2026-03-10 19:50:24	2026-06-10 22:15:05	2026-06-10 22:15:05
18	4	1	2026-06-10 22:15:16	2026-06-10 22:15:16	\N
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
8	7	1	2026-03-22 21:43:20	2026-03-22 21:43:20	\N
9	6	1	2026-03-22 21:51:54	2026-03-22 21:51:54	\N
10	57	1	2026-05-11 03:36:10	2026-05-11 03:36:11	2026-05-11 03:36:11
11	62	1	2026-05-11 03:39:58	2026-05-11 03:39:58	2026-05-11 03:39:58
12	2	1	2026-05-14 22:07:49	2026-05-14 22:07:49	\N
13	72	1	2026-06-05 15:19:36	2026-06-05 15:19:37	2026-06-05 15:19:37
14	72	1	2026-06-05 15:22:11	2026-06-05 15:25:34	2026-06-05 15:25:34
15	72	1	2026-06-05 15:25:36	2026-06-05 15:25:36	\N
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.posts (id, description, media_link, created_at, updated_at, deleted_at, is_repost, original_post_id, original_user_id, music_link) FROM stdin;
2	MVP da H Media 💙	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a620913354d6.86533246.mp4	2026-03-02 20:43:45	2026-03-02 20:43:45	\N	f	\N	\N	\N
4	Bom dia pessoal! 💜		2026-03-02 20:49:12	2026-03-02 23:51:35	2026-03-02 23:51:35	f	\N	\N	\N
6	Bom dia Pessoal		2026-03-02 20:51:40	2026-03-02 20:51:40	\N	f	\N	\N	\N
7	Vamos pescar hj 💦 ?		2026-03-02 20:51:54	2026-03-02 20:51:54	\N	f	\N	\N	\N
8	teste		2026-03-10 16:51:27	2026-03-10 19:51:31	2026-03-10 19:51:31	f	\N	\N	\N
9	Esse é o meu portfolio 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a61f391fd426.45868746.mp4	2026-03-22 18:43:35	2026-03-22 21:43:46	2026-03-22 21:43:46	t	1	1	\N
10	MVP da H Media 💙	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a620913354d6.86533246.mp4	2026-03-22 18:43:50	2026-03-22 18:43:50	\N	t	2	1	\N
11	teste		2026-03-22 18:44:26	2026-03-22 21:44:40	2026-03-22 21:44:40	f	\N	\N	\N
1	Esse é o meu portfolio 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a61f391fd426.45868746.mp4	2026-03-02 20:42:26	2026-03-22 21:48:25	2026-03-22 21:48:25	f	\N	\N	\N
3	Esse é o meu portfolio 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a61f391fd426.45868746.mp4	2026-03-02 20:46:13	2026-03-22 21:50:13	2026-03-22 21:50:13	t	1	1	\N
5	Esse é o meu portfolio 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a61f391fd426.45868746.mp4	2026-03-02 20:49:25	2026-03-22 21:50:53	2026-03-22 21:50:53	t	1	1	\N
12	Bom dia Pessoal		2026-03-22 18:52:01	2026-03-22 18:52:01	\N	t	6	3	\N
13	teste		2026-03-22 18:52:12	2026-03-22 21:52:14	2026-03-22 21:52:14	f	\N	\N	\N
15	teste		2026-04-11 19:12:16	2026-04-11 22:12:23	2026-04-11 22:12:23	f	\N	\N	\N
14	teste		2026-04-11 19:12:09	2026-04-11 22:12:27	2026-04-11 22:12:27	f	\N	\N	\N
16	testea a		2026-04-11 19:12:31	2026-04-11 22:12:33	2026-04-11 22:12:33	f	\N	\N	\N
17	teste		2026-04-11 19:13:16	2026-04-11 22:13:22	2026-04-11 22:13:22	f	\N	\N	\N
18	🎵 High on Mel - Astrix		2026-04-11 21:56:31	2026-04-12 00:56:44	2026-04-12 00:56:44	f	\N	\N	\N
19	Teste\r\n\r\n🎵 Clouds - Star Project		2026-04-11 21:57:32	2026-04-12 00:57:39	2026-04-12 00:57:39	f	\N	\N	\N
20	Lindo design	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69fe1edbc85695.55532545.jpg	2026-05-08 14:35:25	2026-05-08 14:35:25	\N	f	\N	\N	\N
21	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69fe1f0474bd56.57218318.mp4	2026-05-08 14:36:16	2026-05-08 14:36:16	\N	f	\N	\N	\N
22	teste		2026-05-08 20:14:21	2026-05-08 23:14:32	2026-05-08 23:14:32	f	\N	\N	\N
23	teste2		2026-05-08 20:14:39	2026-05-08 23:14:41	2026-05-08 23:14:41	f	\N	\N	\N
24	teste 2		2026-05-08 20:14:48	2026-05-08 23:14:51	2026-05-08 23:14:51	f	\N	\N	\N
25	teste.		2026-05-08 20:19:56	2026-05-08 23:19:58	2026-05-08 23:19:58	f	\N	\N	\N
26	teste 2		2026-05-08 20:20:05	2026-05-08 23:20:13	2026-05-08 23:20:13	f	\N	\N	\N
27	teste 2		2026-05-08 20:20:16	2026-05-08 23:20:21	2026-05-08 23:20:21	f	\N	\N	\N
28	teste		2026-05-08 20:26:33	2026-05-08 23:26:43	2026-05-08 23:26:43	f	\N	\N	\N
29	teste 2		2026-05-08 20:26:50	2026-05-08 23:26:53	2026-05-08 23:26:53	f	\N	\N	\N
30	teste		2026-05-08 20:28:58	2026-05-08 23:29:01	2026-05-08 23:29:01	f	\N	\N	\N
31	teste 2		2026-05-08 20:29:30	2026-05-08 23:29:33	2026-05-08 23:29:33	f	\N	\N	\N
32	teste		2026-05-08 20:30:02	2026-05-08 23:30:05	2026-05-08 23:30:05	f	\N	\N	\N
33	teste 2		2026-05-08 20:33:20	2026-05-08 23:33:26	2026-05-08 23:33:26	f	\N	\N	\N
34	teste 2		2026-05-08 20:33:31	2026-05-08 23:33:33	2026-05-08 23:33:33	f	\N	\N	\N
35	teste		2026-05-08 20:33:40	2026-05-08 23:33:41	2026-05-08 23:33:41	f	\N	\N	\N
36	teste 2		2026-05-08 20:34:42	2026-05-08 23:34:55	2026-05-08 23:34:55	f	\N	\N	\N
37	teste 2		2026-05-08 20:34:50	2026-05-08 23:34:56	2026-05-08 23:34:56	f	\N	\N	\N
38	teste 1		2026-05-08 20:35:07	2026-05-08 23:36:00	2026-05-08 23:36:00	f	\N	\N	\N
39	teste 2		2026-05-08 20:36:08	2026-05-08 23:36:15	2026-05-08 23:36:15	f	\N	\N	\N
40	teste 2		2026-05-08 20:36:28	2026-05-08 23:36:32	2026-05-08 23:36:32	f	\N	\N	\N
42	teste 2		2026-05-08 20:38:50	2026-05-08 23:38:52	2026-05-08 23:38:52	f	\N	\N	\N
41	teste		2026-05-08 20:36:37	2026-05-08 23:38:53	2026-05-08 23:38:53	f	\N	\N	\N
43	teste		2026-05-08 20:39:01	2026-05-08 23:39:04	2026-05-08 23:39:04	f	\N	\N	\N
44	teste 2		2026-05-08 20:39:10	2026-05-08 23:39:16	2026-05-08 23:39:16	f	\N	\N	\N
45	teste 2		2026-05-08 20:40:22	2026-05-08 23:40:24	2026-05-08 23:40:24	f	\N	\N	\N
46	teste		2026-05-08 20:40:35	2026-05-08 23:40:38	2026-05-08 23:40:38	f	\N	\N	\N
47	dsadsa		2026-05-08 20:40:53	2026-05-08 23:40:55	2026-05-08 23:40:55	f	\N	\N	\N
48	teste		2026-05-08 20:41:02	2026-05-08 23:41:04	2026-05-08 23:41:04	f	\N	\N	\N
49	teste		2026-05-08 20:41:52	2026-05-08 23:41:54	2026-05-08 23:41:54	f	\N	\N	\N
50	teste		2026-05-08 20:42:59	2026-05-08 23:43:06	2026-05-08 23:43:06	f	\N	\N	\N
51	teste 2		2026-05-08 20:43:19	2026-05-08 23:43:24	2026-05-08 23:43:24	f	\N	\N	\N
52	teste		2026-05-08 20:43:35	2026-05-08 23:43:38	2026-05-08 23:43:38	f	\N	\N	\N
53	teste		2026-05-11 00:18:18	2026-05-11 03:18:33	2026-05-11 03:18:33	f	\N	\N	\N
54	kkk\r\n		2026-05-11 00:27:18	2026-05-11 03:27:26	2026-05-11 03:27:26	f	\N	\N	\N
55	bbb		2026-05-11 00:27:36	2026-05-11 03:27:37	2026-05-11 03:27:37	f	\N	\N	\N
56	kkkk	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a014cd6a74116.01569556.mp4	2026-05-11 00:28:33	2026-05-11 03:29:00	2026-05-11 03:29:00	f	\N	\N	\N
57	teste		2026-05-11 00:36:06	2026-05-11 03:36:12	2026-05-11 03:36:12	f	\N	\N	\N
58	aaa		2026-05-11 00:36:19	2026-05-11 03:36:21	2026-05-11 03:36:21	f	\N	\N	\N
59	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a014ee6458dc9.61996020.mp4	2026-05-11 00:37:21	2026-05-11 03:38:08	2026-05-11 03:38:08	f	\N	\N	\N
60	teste		2026-05-11 00:39:12	2026-05-11 03:39:14	2026-05-11 03:39:14	f	\N	\N	\N
61	aaa		2026-05-11 00:39:18	2026-05-11 03:39:21	2026-05-11 03:39:21	f	\N	\N	\N
62	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a014f7e608e33.41520359.mp4	2026-05-11 00:39:45	2026-05-11 03:40:01	2026-05-11 03:40:01	f	\N	\N	\N
63	hjjj		2026-05-11 02:51:16	2026-05-11 05:51:17	2026-05-11 05:51:17	f	\N	\N	\N
64	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a0689263470a2.90138169.jpg	2026-05-14 23:47:09	2026-05-15 02:47:18	2026-05-15 02:47:18	f	\N	\N	\N
65	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a068983c6ccf8.61078770.jpg	2026-05-14 23:48:38	2026-05-15 02:48:42	2026-05-15 02:48:42	f	\N	\N	\N
66	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22d96b7932a7.71930435.mp4	2026-06-05 11:13:04	2026-06-05 14:13:12	2026-06-05 14:13:12	f	\N	\N	\N
67	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22d989cccf53.02668244.jpg	2026-06-05 11:13:32	2026-06-05 14:13:36	2026-06-05 14:13:36	f	\N	\N	\N
68	teste		2026-06-05 11:13:40	2026-06-05 14:13:41	2026-06-05 14:13:41	f	\N	\N	\N
69	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22da17586735.07248073.jpg	2026-06-05 11:15:53	2026-06-05 14:15:59	2026-06-05 14:15:59	f	\N	\N	\N
70	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22da2da5fbf1.69151386.mp4	2026-06-05 11:16:21	2026-06-05 14:16:27	2026-06-05 14:16:27	f	\N	\N	\N
71	teste		2026-06-05 11:16:36	2026-06-05 14:16:38	2026-06-05 14:16:38	f	\N	\N	\N
73	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22dd71db1368.78085125.jpg	2026-06-05 11:30:12	2026-06-05 14:30:14	2026-06-05 14:30:14	f	\N	\N	\N
75	teste		2026-06-05 11:50:08	2026-06-05 14:50:12	2026-06-05 14:50:12	f	\N	\N	\N
76	teste		2026-06-05 11:50:15	2026-06-05 14:50:17	2026-06-05 14:50:17	f	\N	\N	\N
77	teste		2026-06-05 11:50:30	2026-06-05 14:50:35	2026-06-05 14:50:35	f	\N	\N	\N
78	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22e2546a64b3.90089859.jpg	2026-06-05 11:51:02	2026-06-05 14:51:12	2026-06-05 14:51:12	f	\N	\N	\N
79	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22e555404c06.94896169.jpg	2026-06-05 12:03:54	2026-06-05 15:04:03	2026-06-05 15:04:03	f	\N	\N	\N
80	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22e6b36abe88.01750963.jpg	2026-06-05 12:09:40	2026-06-05 15:09:45	2026-06-05 15:09:45	f	\N	\N	\N
74	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22e0f0a229d3.27418835.jpg	2026-06-05 11:45:20	2026-06-05 15:09:50	2026-06-05 15:09:50	f	\N	\N	\N
81	teste		2026-06-05 12:10:09	2026-06-05 15:10:24	2026-06-05 15:10:24	f	\N	\N	\N
82	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22e70238d2e5.19903177.mp4	2026-06-05 12:11:04	2026-06-05 15:11:16	2026-06-05 15:11:16	f	\N	\N	\N
83	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22e74a829be0.47898356.jpg	2026-06-05 12:12:12	2026-06-05 15:12:20	2026-06-05 15:12:20	f	\N	\N	\N
84	teste		2026-06-05 12:14:39	2026-06-05 15:14:40	2026-06-05 15:14:40	f	\N	\N	\N
85	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22e7f13bac33.79005284.jpg	2026-06-05 12:15:00	2026-06-05 15:15:08	2026-06-05 15:15:08	f	\N	\N	\N
86	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22e80f9d2b36.36986932.mp4	2026-06-05 12:15:32	2026-06-05 15:15:37	2026-06-05 15:15:37	f	\N	\N	\N
87	teste		2026-06-05 12:18:51	2026-06-05 15:18:54	2026-06-05 15:18:54	f	\N	\N	\N
88	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22e8f95415b6.39663727.jpg	2026-06-05 12:19:26	2026-06-05 15:19:31	2026-06-05 15:19:31	f	\N	\N	\N
89	Video massa 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6a22dbbe6c2ce9.81762900.mp4	2026-06-05 12:26:11	2026-06-05 15:26:15	2026-06-05 15:26:15	t	72	4	\N
72	Video massa 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6a22dbbe6c2ce9.81762900.mp4	2026-06-05 11:22:59	2026-06-05 15:41:03	2026-06-05 15:41:03	f	\N	\N	\N
90	Video massa 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6a22ee2b966cf7.94433712.mp4	2026-06-05 12:41:41	2026-06-05 12:41:41	\N	f	\N	\N	\N
91	teste		2026-06-10 19:12:01	2026-06-10 22:12:03	2026-06-10 22:12:03	f	\N	\N	\N
92	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a29e141d07700.35664476.jpg	2026-06-10 19:12:21	2026-06-10 22:12:27	2026-06-10 22:12:27	f	\N	\N	\N
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
8	1	8	2026-03-10 16:51:27	2026-03-10 16:51:27	\N
9	1	9	2026-03-22 18:43:35	2026-03-22 18:43:35	\N
10	1	10	2026-03-22 18:43:51	2026-03-22 18:43:51	\N
11	1	11	2026-03-22 18:44:27	2026-03-22 18:44:27	\N
12	1	12	2026-03-22 18:52:01	2026-03-22 18:52:01	\N
13	1	13	2026-03-22 18:52:12	2026-03-22 18:52:12	\N
14	1	15	2026-04-11 19:12:17	2026-04-11 19:12:17	\N
15	1	14	2026-04-11 19:12:17	2026-04-11 19:12:17	\N
16	1	16	2026-04-11 19:12:31	2026-04-11 19:12:31	\N
17	1	17	2026-04-11 19:13:17	2026-04-11 19:13:17	\N
18	1	18	2026-04-11 21:56:32	2026-04-11 21:56:32	\N
19	1	19	2026-04-11 21:57:32	2026-04-11 21:57:32	\N
20	1	20	2026-05-08 14:35:25	2026-05-08 14:35:25	\N
21	1	21	2026-05-08 14:36:16	2026-05-08 14:36:16	\N
22	1	22	2026-05-08 20:14:23	2026-05-08 20:14:23	\N
23	1	23	2026-05-08 20:14:39	2026-05-08 20:14:39	\N
24	1	24	2026-05-08 20:14:48	2026-05-08 20:14:48	\N
25	1	25	2026-05-08 20:19:56	2026-05-08 20:19:56	\N
26	1	26	2026-05-08 20:20:05	2026-05-08 20:20:05	\N
27	1	27	2026-05-08 20:20:16	2026-05-08 20:20:16	\N
28	1	28	2026-05-08 20:26:33	2026-05-08 20:26:33	\N
29	1	29	2026-05-08 20:26:50	2026-05-08 20:26:50	\N
30	1	30	2026-05-08 20:28:58	2026-05-08 20:28:58	\N
31	1	31	2026-05-08 20:29:30	2026-05-08 20:29:30	\N
32	1	32	2026-05-08 20:30:02	2026-05-08 20:30:02	\N
33	1	33	2026-05-08 20:33:20	2026-05-08 20:33:20	\N
34	1	34	2026-05-08 20:33:31	2026-05-08 20:33:31	\N
35	1	35	2026-05-08 20:33:40	2026-05-08 20:33:40	\N
36	1	36	2026-05-08 20:34:42	2026-05-08 20:34:42	\N
37	1	37	2026-05-08 20:34:50	2026-05-08 20:34:50	\N
38	1	38	2026-05-08 20:35:07	2026-05-08 20:35:07	\N
39	1	39	2026-05-08 20:36:08	2026-05-08 20:36:08	\N
40	1	40	2026-05-08 20:36:28	2026-05-08 20:36:28	\N
41	1	41	2026-05-08 20:36:37	2026-05-08 20:36:37	\N
42	1	42	2026-05-08 20:38:50	2026-05-08 20:38:50	\N
43	1	43	2026-05-08 20:39:01	2026-05-08 20:39:01	\N
44	1	44	2026-05-08 20:39:10	2026-05-08 20:39:10	\N
45	1	45	2026-05-08 20:40:22	2026-05-08 20:40:22	\N
46	1	46	2026-05-08 20:40:35	2026-05-08 20:40:35	\N
47	1	47	2026-05-08 20:40:53	2026-05-08 20:40:53	\N
48	1	48	2026-05-08 20:41:02	2026-05-08 20:41:02	\N
49	1	49	2026-05-08 20:41:52	2026-05-08 20:41:52	\N
50	1	50	2026-05-08 20:42:59	2026-05-08 20:42:59	\N
51	1	51	2026-05-08 20:43:19	2026-05-08 20:43:19	\N
52	1	52	2026-05-08 20:43:35	2026-05-08 20:43:35	\N
53	1	53	2026-05-11 00:18:18	2026-05-11 00:18:18	\N
54	1	54	2026-05-11 00:27:18	2026-05-11 00:27:18	\N
55	1	55	2026-05-11 00:27:36	2026-05-11 00:27:36	\N
56	1	56	2026-05-11 00:28:33	2026-05-11 00:28:33	\N
57	1	57	2026-05-11 00:36:07	2026-05-11 00:36:07	\N
58	1	58	2026-05-11 00:36:19	2026-05-11 00:36:19	\N
59	1	59	2026-05-11 00:37:21	2026-05-11 00:37:21	\N
60	1	60	2026-05-11 00:39:12	2026-05-11 00:39:12	\N
61	1	61	2026-05-11 00:39:18	2026-05-11 00:39:18	\N
62	1	62	2026-05-11 00:39:45	2026-05-11 00:39:45	\N
63	1	63	2026-05-11 02:51:16	2026-05-11 02:51:16	\N
64	1	64	2026-05-14 23:47:09	2026-05-14 23:47:09	\N
65	1	65	2026-05-14 23:48:38	2026-05-14 23:48:38	\N
66	1	66	2026-06-05 11:13:05	2026-06-05 11:13:05	\N
67	1	67	2026-06-05 11:13:32	2026-06-05 11:13:32	\N
68	1	68	2026-06-05 11:13:40	2026-06-05 11:13:40	\N
69	1	69	2026-06-05 11:15:53	2026-06-05 11:15:53	\N
70	1	70	2026-06-05 11:16:21	2026-06-05 11:16:21	\N
71	1	71	2026-06-05 11:16:36	2026-06-05 11:16:36	\N
72	4	72	2026-06-05 11:22:59	2026-06-05 11:22:59	\N
73	1	73	2026-06-05 11:30:12	2026-06-05 11:30:12	\N
74	1	74	2026-06-05 11:45:21	2026-06-05 11:45:21	\N
75	1	75	2026-06-05 11:50:09	2026-06-05 11:50:09	\N
76	1	76	2026-06-05 11:50:16	2026-06-05 11:50:16	\N
77	1	77	2026-06-05 11:50:30	2026-06-05 11:50:30	\N
78	1	78	2026-06-05 11:51:02	2026-06-05 11:51:02	\N
79	1	79	2026-06-05 12:03:55	2026-06-05 12:03:55	\N
80	1	80	2026-06-05 12:09:41	2026-06-05 12:09:41	\N
81	1	81	2026-06-05 12:10:12	2026-06-05 12:10:12	\N
82	1	82	2026-06-05 12:11:04	2026-06-05 12:11:04	\N
83	1	83	2026-06-05 12:12:13	2026-06-05 12:12:13	\N
84	1	84	2026-06-05 12:14:39	2026-06-05 12:14:39	\N
85	1	85	2026-06-05 12:15:00	2026-06-05 12:15:00	\N
86	1	86	2026-06-05 12:15:32	2026-06-05 12:15:32	\N
87	1	87	2026-06-05 12:18:52	2026-06-05 12:18:52	\N
88	1	88	2026-06-05 12:19:26	2026-06-05 12:19:26	\N
89	1	89	2026-06-05 12:26:11	2026-06-05 12:26:11	\N
90	4	90	2026-06-05 12:41:41	2026-06-05 12:41:41	\N
91	1	91	2026-06-10 19:12:01	2026-06-10 19:12:01	\N
92	1	92	2026-06-10 19:12:21	2026-06-10 19:12:21	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.users (id, name, nickname, phone1, has_whatsapp, phone2, email, password, postal_code, address, number, complement, neighborhood, city, state, country, country_code, state_code, recovery_key, first_access, last_access, bio, website, access_count, receive_newsletter, active, created_at, updated_at, deleted_at, birth_date, userscol, photo, cover_photo, google_id, facebook_id, auth_provider, email_verified, verified_profile) FROM stdin;
2	Calebe Andrade	\N	\N	f	\N	calebe@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	13392-350	teste	5656	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-03-02 23:45:12	\N	Meu site www.calebe.com.br	\N	\N	f	t	2026-03-02 23:45:12	2026-03-02 23:55:28	\N	2026-03-02 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_calebeandrade/1650059618eu3.jpg	https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebeandrade/684454171capasound.jpg	\N	\N	local	t	f
3	Thor Tron	\N	\N	f	\N	thor@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	13392-350	teste	265	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-03-02 23:48:07	\N	www.thor.com.br	www.mixcloud.com/starprojectt	\N	f	t	2026-03-02 23:48:07	2026-03-02 23:48:14	\N	2026-03-02 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_thortron/1578230748euuu.jpg	\N	\N	\N	local	t	f
1	Hedrei Andrade	\N	\N	f	\N	hedreiandrade@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	13051251	teste	989	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-02-28 01:13:41	2026-06-05 15:24:48	www.youtube.com/@starprojectt	www.github.com/hedreiandrade	4	f	t	2026-02-28 01:13:41	2026-06-05 15:25:26	\N	1988-05-07 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_hedreiandrade/35275069ha.jpg	https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/1488094812capayoutube.jpg	\N	\N	local	t	t
4	Mara Dias	\N	\N	f	\N	maradias@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	11851252	Rua Walmir Jose Peres	5454	\N	\N	Assunção do Piauí	Piauí	Brazil	BR	PI	\N	2026-03-10 19:48:26	\N	Jupiter ⚫	www.maradias.com.br	\N	f	t	2026-03-10 19:48:27	2026-06-03 23:00:14	\N	2026-03-04 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/58b126c625581c7d0ea3f8472de5303e_maradias/1394953472mandalaart.jpg	\N	\N	\N	local	t	f
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.comments_id_seq', 8, true);


--
-- Name: followers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.followers_id_seq', 18, true);


--
-- Name: likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.likes_id_seq', 15, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.posts_id_seq', 92, true);


--
-- Name: posts_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.posts_users_id_seq', 92, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


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
-- Name: unique_active_follow; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX unique_active_follow ON public.followers USING btree (user_id, follower_id) WHERE (deleted_at IS NULL);


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

\unrestrict xWYkfjAD5bwaeMEwuUYc6ofXn7QM8ApafuuevVsdceoRuRLxTyhIzrFEd12wG0v

