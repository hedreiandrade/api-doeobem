--
-- PostgreSQL database dump
--

\restrict yLOX4ff39zxrrugmnQd7Ky1YXoaaBpDsRVPcdW0IAk4XSKhdozV3qVTeBjhCqMR

-- Dumped from database version 17.11 (Debian 17.11-1.pgdg13+2)
-- Dumped by pg_dump version 17.11 (Debian 17.11-1.pgdg13+2)

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
-- Name: block_users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.block_users (
    id integer NOT NULL,
    user_id_bu integer NOT NULL,
    user_block_id_bu integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    deleted_at timestamp without time zone,
    CONSTRAINT chk_block_user_not_self CHECK ((user_id_bu <> user_block_id_bu))
);


ALTER TABLE public.block_users OWNER TO root;

--
-- Name: block_user_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

ALTER TABLE public.block_users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.block_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
    deleted_at timestamp without time zone,
    media_link_comment character varying(255)
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
-- Data for Name: block_users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.block_users (id, user_id_bu, user_block_id_bu, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.comments (id, post_id, user_id, comment, created_at, updated_at, deleted_at, media_link_comment) FROM stdin;
1	1	2	Lindo!	2026-03-02 20:46:10	2026-03-02 20:46:10	\N	\N
2	2	2	Top!	2026-03-02 20:46:30	2026-03-02 20:46:30	\N	\N
3	2	3	Demais!	2026-03-02 20:49:23	2026-03-02 20:49:23	\N	\N
4	1	3	Amei!	2026-03-02 20:49:34	2026-03-02 20:49:34	\N	\N
5	7	1	Bora ?	2026-03-22 18:43:29	2026-03-22 18:43:29	\N	\N
6	6	1	Bom dia!	2026-03-22 18:51:59	2026-03-22 18:51:59	\N	\N
7	72	1	teste	2026-06-05 12:25:42	2026-06-05 12:25:42	\N	\N
8	72	1	🖤	2026-06-05 12:26:05	2026-06-05 12:26:05	\N	\N
9	90	1	Demais!	2026-06-10 19:21:32	2026-06-10 22:27:38	2026-06-10 22:27:38	\N
10	7	1	Massa!	2026-06-10 19:27:49	2026-06-10 22:27:51	2026-06-10 22:27:51	\N
11	90	1	Lindo!	2026-06-10 19:36:31	2026-06-10 22:40:09	2026-06-10 22:40:09	\N
12	90	1	Lindo!	2026-06-10 19:42:24	2026-06-10 22:44:20	2026-06-10 22:44:20	\N
13	90	1	Lindo	2026-06-10 19:46:50	2026-06-10 19:46:50	\N	\N
14	110	1	teste veritical video	2026-06-15 17:39:34	2026-06-15 17:39:34	\N	\N
15	110	3	Demais!	2026-06-15 19:56:20	2026-06-15 19:56:20	\N	\N
16	112	1	trste	2026-06-28 10:23:17	2026-06-28 13:23:28	2026-06-28 13:23:28	\N
22	128	1	6	2026-06-28 18:56:09	2026-06-28 21:56:12	2026-06-28 21:56:12	\N
21	128	1	5	2026-06-28 18:56:05	2026-06-28 21:56:12	2026-06-28 21:56:12	\N
20	128	1	4	2026-06-28 18:56:01	2026-06-28 21:56:13	2026-06-28 21:56:13	\N
19	128	1	3	2026-06-28 18:55:26	2026-06-28 21:56:14	2026-06-28 21:56:14	\N
18	128	1	2	2026-06-28 18:55:19	2026-06-28 21:56:15	2026-06-28 21:56:15	\N
17	128	1	1	2026-06-28 18:55:18	2026-06-28 21:56:16	2026-06-28 21:56:16	\N
28	128	1	6	2026-06-28 18:56:59	2026-06-28 21:57:59	2026-06-28 21:57:59	\N
27	128	1	5	2026-06-28 18:56:53	2026-06-28 21:58:00	2026-06-28 21:58:00	\N
25	128	1	3	2026-06-28 18:56:50	2026-06-28 21:58:01	2026-06-28 21:58:01	\N
24	128	1	2	2026-06-28 18:56:48	2026-06-28 21:58:01	2026-06-28 21:58:01	\N
23	128	1	1	2026-06-28 18:56:44	2026-06-28 21:58:03	2026-06-28 21:58:03	\N
26	128	1	4	2026-06-28 18:56:51	2026-06-28 21:58:03	2026-06-28 21:58:03	\N
29	128	1	1	2026-06-28 18:58:11	2026-06-28 18:58:11	\N	\N
30	128	1	2	2026-06-28 18:58:13	2026-06-28 18:58:13	\N	\N
31	128	1	3	2026-06-28 18:58:14	2026-06-28 18:58:14	\N	\N
32	128	1	4	2026-06-28 18:58:19	2026-06-28 18:58:19	\N	\N
33	128	1	5	2026-06-28 18:58:21	2026-06-28 18:58:21	\N	\N
34	128	1	6	2026-06-28 18:58:24	2026-06-28 18:58:24	\N	\N
35	12	1	teste	2026-06-28 19:35:54	2026-06-28 22:35:56	2026-06-28 22:35:56	\N
36	111	1	Demais!	2026-06-29 11:33:55	2026-06-29 11:33:55	\N	\N
37	135	1	Amei!	2026-06-29 11:34:41	2026-06-29 11:34:41	\N	\N
38	143	1	teste	2026-07-10 20:21:09	2026-07-10 23:21:10	2026-07-10 23:21:10	\N
39	153	3	Demais!	2026-07-30 23:54:10	2026-07-30 23:54:10	\N	\N
40	151	3	Lindo!	2026-07-30 23:54:49	2026-07-30 23:54:49	\N	\N
41	153	2	Top!	2026-07-31 00:23:20	2026-07-31 00:23:20	\N	\N
42	159	1	Demais 💚	2026-08-09 00:39:59	2026-08-09 00:39:59	\N	\N
43	12	1	Olá!	2026-08-09 00:53:55	2026-08-09 00:53:55	\N	\N
44	185	1	Opa!	2026-08-09 01:25:33	2026-08-09 01:25:33	\N	\N
45	189	3	Linda casa!	2026-09-22 07:24:35	2026-09-22 07:24:35	\N	\N
46	190	1	Gostei do relógio!	2026-09-22 07:25:06	2026-09-22 07:25:06	\N	\N
49	201	1	3	2026-09-24 05:54:37	2026-09-24 08:55:19	2026-09-24 08:55:19	\N
47	201	1	1	2026-09-24 05:54:33	2026-09-24 08:56:01	2026-09-24 08:56:01	\N
48	201	1	2	2026-09-24 05:54:34	2026-09-24 08:56:02	2026-09-24 08:56:02	\N
50	201	1	4	2026-09-24 05:54:39	2026-09-24 08:56:03	2026-09-24 08:56:03	\N
51	201	1	5	2026-09-24 05:54:41	2026-09-24 08:56:03	2026-09-24 08:56:03	\N
52	201	1	6	2026-09-24 05:54:43	2026-09-24 08:56:03	2026-09-24 08:56:03	\N
53	210	1	1	2026-09-26 16:23:16	2026-09-26 16:23:16	\N	\N
54	210	1	2	2026-09-26 16:23:19	2026-09-26 16:23:19	\N	\N
55	210	1	3	2026-09-26 16:23:21	2026-09-26 16:23:21	\N	\N
56	210	1	4	2026-09-26 16:23:24	2026-09-26 16:23:24	\N	\N
57	210	1	5	2026-09-26 16:23:27	2026-09-26 16:23:27	\N	\N
58	210	1	6	2026-09-26 16:23:30	2026-09-26 16:23:30	\N	\N
59	210	1	7	2026-09-26 16:41:28	2026-09-26 16:41:28	\N	\N
60	210	1	8	2026-09-26 16:41:31	2026-09-26 16:41:31	\N	\N
61	210	1	9	2026-09-26 16:41:34	2026-09-26 16:41:34	\N	\N
62	210	1	10	2026-09-26 16:41:37	2026-09-26 16:41:37	\N	\N
63	210	1	11	2026-09-26 16:41:40	2026-09-26 16:41:40	\N	\N
64	210	1	teste	2026-09-27 11:02:47	2026-09-27 11:02:47	\N	\N
67	218	1	massa!	2026-10-09 01:12:50	2026-10-09 01:12:50	\N	\N
68	224	1	teste	2026-10-09 19:56:41	2026-10-09 19:56:41	\N	\N
69	221	1	dsada	2026-10-09 20:00:10	2026-10-09 23:00:43	2026-10-09 23:00:43	\N
66	221	1	dsadad	2026-10-06 04:07:01	2026-10-09 23:00:43	2026-10-09 23:00:43	\N
65	221	1	teste	2026-10-06 04:06:38	2026-10-09 23:00:44	2026-10-09 23:00:44	\N
70	226	1	teste	2026-10-11 08:33:50	2026-10-11 11:37:48	2026-10-11 11:37:48	
72	227	1	aaa	2026-10-12 18:03:53	2026-10-12 21:04:18	2026-10-12 21:04:18	
71	226	1	teste	2026-10-11 08:38:52	2026-10-12 21:11:04	2026-10-12 21:11:04	
74	226	1	teste	2026-10-12 18:18:48	2026-10-12 21:24:47	2026-10-12 21:24:47	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6acd4e95bf41b4.91173301.mp4
73	226	1	dsadada	2026-10-12 18:16:20	2026-10-12 21:24:48	2026-10-12 21:24:48	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6acd4e20537a56.29786728.jpg
75	218	1	Psycho ! 🖤	2026-10-12 18:28:35	2026-10-12 21:29:13	2026-10-12 21:29:13	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6acd50fe850b03.82179876.mp4
76	218	1	Dubai	2026-10-12 18:28:54	2026-10-12 21:29:31	2026-10-12 21:29:31	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6acd51150680e2.17571512.jpg
77	218	1	Dubai 🖤	2026-10-12 18:29:57	2026-10-12 18:29:57	\N	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6acd51545641b4.13502700.jpg
78	218	1	Psycho !	2026-10-12 18:30:17	2026-10-12 18:30:17	\N	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6acd5165f05212.40432409.mp4
82	227	1	teste	2026-10-13 12:45:53	2026-10-13 15:46:06	2026-10-13 15:46:06	
85	228	1	6	2026-10-13 12:47:15	2026-10-13 16:00:12	2026-10-13 16:00:12	
84	228	1	5	2026-10-13 12:46:43	2026-10-13 16:00:13	2026-10-13 16:00:13	
83	228	1	4	2026-10-13 12:46:33	2026-10-13 16:00:14	2026-10-13 16:00:14	
81	228	1	3	2026-10-13 12:45:17	2026-10-13 16:00:15	2026-10-13 16:00:15	
90	228	1	7	2026-10-13 13:00:39	2026-10-13 16:00:55	2026-10-13 16:00:55	
89	228	1	6	2026-10-13 13:00:36	2026-10-13 16:00:55	2026-10-13 16:00:55	
88	228	1	5	2026-10-13 13:00:34	2026-10-13 16:00:56	2026-10-13 16:00:56	
87	228	1	4	2026-10-13 13:00:32	2026-10-13 16:00:57	2026-10-13 16:00:57	
86	228	1	3	2026-10-13 13:00:29	2026-10-13 16:00:57	2026-10-13 16:00:57	
94	228	1	6	2026-10-13 13:01:15	2026-10-13 16:01:29	2026-10-13 16:01:29	
93	228	1	5	2026-10-13 13:01:13	2026-10-13 16:01:29	2026-10-13 16:01:29	
92	228	1	4	2026-10-13 13:01:11	2026-10-13 16:01:30	2026-10-13 16:01:30	
80	228	1	dsada	2026-10-13 12:42:49	2026-10-13 16:12:51	2026-10-13 16:12:51	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ace5171643a08.57045894.mp4
95	228	1	7	2026-10-13 13:01:19	2026-10-13 16:01:28	2026-10-13 16:01:28	
91	228	1	3	2026-10-13 13:01:09	2026-10-13 16:01:31	2026-10-13 16:01:31	
79	228	1	dsadsad	2026-10-13 12:42:11	2026-10-13 16:12:50	2026-10-13 16:12:50	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ace5150655086.63538870.jpg
96	228	1	Dubai 🖤	2026-10-13 13:13:42	2026-10-13 16:14:56	2026-10-13 16:14:56	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ace58b27075a0.17954686.jpg
97	228	1	Psycho	2026-10-13 13:14:18	2026-10-13 16:14:57	2026-10-13 16:14:57	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ace58d79e13b3.14693088.mp4
98	228	1	Psycho	2026-10-13 13:15:22	2026-10-13 13:15:22	\N	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ace59178b4e10.50314588.mp4
99	228	1	Dubai 🖤	2026-10-13 13:15:56	2026-10-13 16:16:17	2026-10-13 16:16:17	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ace593a991da9.56730028.jpg
100	221	1	teste	2026-10-15 14:23:28	2026-10-15 17:23:31	2026-10-15 17:23:31	
101	221	1	dsadasda	2026-10-19 18:22:33	2026-10-19 21:23:09	2026-10-19 21:23:09	
102	228	5	massa!	2026-10-19 18:33:50	2026-10-19 18:33:50	\N	
103	221	5	Show 🥰	2026-10-19 18:34:11	2026-10-19 18:34:11	\N	
104	237	4	🖤	2026-10-20 20:53:27	2026-10-20 20:53:27	\N	
105	228	4	🖤	2026-10-20 20:53:47	2026-10-20 20:53:47	\N	
106	243	3	massa!	2026-10-22 14:47:42	2026-10-22 14:47:42	\N	
107	228	3	massa!	2026-10-22 14:47:55	2026-10-22 14:47:55	\N	
108	153	1	hahah	2026-10-22 15:51:14	2026-10-22 15:51:14	\N	
109	247	1	massa!	2026-10-22 16:47:26	2026-10-22 16:47:26	\N	
111	228	1	56	2026-10-22 17:20:44	2026-10-22 20:24:53	2026-10-22 20:24:53	
110	228	1	1	2026-10-22 17:20:35	2026-10-22 20:25:00	2026-10-22 20:25:00	
112	243	1	legal!	2026-10-23 12:08:46	2026-10-23 12:08:46	\N	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6adb787d0d3043.87444789.jpg
113	252	3	TOP !	2026-10-25 14:06:48	2026-10-25 14:06:48	\N	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6ade3726d9beb2.49671822.jpg
114	291	1	teste	2026-10-30 18:11:04	2026-10-30 21:11:08	2026-10-30 21:11:08	
117	286	3	dsada	2026-10-31 03:50:51	2026-10-31 17:03:27	2026-10-31 17:03:27	
119	302	3	cxzcz	2026-11-06 10:19:10	2026-11-06 13:19:32	2026-11-06 13:19:32	
120	302	4	Demais !	2026-11-06 12:03:05	2026-11-06 12:03:05	\N	
121	290	4	Top!	2026-11-06 12:03:20	2026-11-06 12:03:20	\N	
115	293	3	Bom dia!	2026-10-31 03:44:34	2026-11-06 15:05:25	2026-11-06 15:05:25	
118	293	3	dsadas	2026-10-31 13:32:37	2026-11-06 15:05:26	2026-11-06 15:05:26	
122	293	3	Top!	2026-11-06 12:05:30	2026-11-06 12:05:30	\N	
116	290	3	dsadada	2026-10-31 03:50:47	2026-11-06 15:05:36	2026-11-06 15:05:36	
123	290	3	Demais!	2026-11-06 12:05:40	2026-11-06 12:05:40	\N	
124	303	3	Lindo!	2026-11-06 12:05:55	2026-11-06 12:05:55	\N	
125	303	1	Demais	2026-11-06 12:14:39	2026-11-06 12:14:39	\N	
126	303	1	dsada	2026-11-09 19:10:06	2026-11-09 22:10:09	2026-11-09 22:10:09	
127	299	1	teste	2026-11-11 18:59:54	2026-11-11 22:00:02	2026-11-11 22:00:02	
128	299	1	teste	2026-11-11 19:00:05	2026-11-11 22:00:07	2026-11-11 22:00:07	
129	299	1	dsada	2026-11-11 19:00:18	2026-11-11 22:00:20	2026-11-11 22:00:20	
\.


--
-- Data for Name: followers; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.followers (id, user_id, follower_id, created_at, updated_at, deleted_at) FROM stdin;
1	1	2	2026-03-02 23:45:42	2026-03-02 23:45:42	\N
2	1	3	2026-03-02 23:48:34	2026-03-02 23:48:34	\N
3	2	3	2026-03-02 23:48:39	2026-03-02 23:48:39	\N
14	2	1	2026-06-05 15:39:07	2026-06-05 15:39:35	2026-06-05 15:39:35
16	2	1	2026-06-05 15:49:13	2026-06-05 15:49:35	2026-06-05 15:49:35
6	4	1	2026-03-10 19:50:24	2026-06-10 22:15:05	2026-06-10 22:15:05
18	4	1	2026-06-10 22:15:16	2026-06-10 22:22:18	2026-06-10 22:22:18
19	4	1	2026-06-10 22:22:24	2026-06-10 22:28:02	2026-06-10 22:28:02
20	4	1	2026-06-10 22:28:12	2026-06-10 22:38:17	2026-06-10 22:38:17
21	4	1	2026-06-10 22:38:24	2026-06-10 22:41:24	2026-06-10 22:41:24
22	4	1	2026-06-10 22:41:31	2026-06-10 22:45:12	2026-06-10 22:45:12
24	1	4	2026-06-11 09:10:15	2026-06-11 09:10:15	\N
23	4	1	2026-06-10 22:45:20	2026-09-27 14:04:23	2026-09-27 14:04:23
4	3	1	2026-03-02 23:50:21	2026-09-27 14:13:29	2026-09-27 14:13:29
26	3	1	2026-09-27 14:13:30	2026-09-30 01:22:10	2026-09-30 01:22:10
28	3	4	2026-09-30 01:23:21	2026-09-30 01:23:21	\N
29	1	5	2026-09-30 01:37:58	2026-09-30 01:37:58	\N
30	5	1	2026-09-30 01:38:55	2026-09-30 01:38:56	2026-09-30 01:38:56
17	2	1	2026-06-05 15:49:52	2026-09-30 01:39:05	2026-09-30 01:39:05
31	2	1	2026-09-30 01:39:06	2026-09-30 01:39:07	2026-09-30 01:39:07
32	2	1	2026-09-30 01:39:08	2026-09-30 01:39:08	\N
33	5	1	2026-09-30 01:39:12	2026-09-30 01:39:14	2026-09-30 01:39:14
34	5	1	2026-09-30 01:39:15	2026-09-30 01:39:16	2026-09-30 01:39:16
35	5	1	2026-09-30 01:39:17	2026-09-30 01:39:19	2026-09-30 01:39:19
36	5	1	2026-09-30 01:39:21	2026-09-30 01:39:28	2026-09-30 01:39:28
37	5	1	2026-09-30 15:06:57	2026-09-30 15:07:06	2026-09-30 15:07:06
27	3	1	2026-09-30 01:22:13	2026-09-30 15:14:41	2026-09-30 15:14:41
38	3	1	2026-09-30 15:14:42	2026-09-30 15:24:16	2026-09-30 15:24:16
40	5	1	2026-10-03 15:47:46	2026-10-09 22:56:22	2026-10-09 22:56:22
41	5	1	2026-10-09 22:56:32	2026-10-09 22:59:24	2026-10-09 22:59:24
42	5	1	2026-10-09 22:59:26	2026-10-09 22:59:26	\N
43	6	1	2026-10-17 16:54:50	2026-10-17 16:54:50	\N
25	4	1	2026-09-27 14:04:27	2026-10-30 21:14:19	2026-10-30 21:14:19
44	4	1	2026-10-30 21:14:20	2026-10-30 21:14:20	\N
39	3	1	2026-09-30 15:24:17	2026-11-11 22:15:42	2026-11-11 22:15:42
45	3	1	2026-11-11 22:15:43	2026-11-11 22:15:43	\N
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
10	57	1	2026-05-11 03:36:10	2026-05-11 03:36:11	2026-05-11 03:36:11
11	62	1	2026-05-11 03:39:58	2026-05-11 03:39:58	2026-05-11 03:39:58
12	2	1	2026-05-14 22:07:49	2026-05-14 22:07:49	\N
13	72	1	2026-06-05 15:19:36	2026-06-05 15:19:37	2026-06-05 15:19:37
14	72	1	2026-06-05 15:22:11	2026-06-05 15:25:34	2026-06-05 15:25:34
15	72	1	2026-06-05 15:25:36	2026-06-05 15:25:36	\N
16	90	1	2026-06-10 22:21:27	2026-06-10 22:27:34	2026-06-10 22:27:34
17	90	1	2026-06-10 22:27:35	2026-06-10 22:36:25	2026-06-10 22:36:25
18	90	1	2026-06-10 22:36:26	2026-06-10 22:40:07	2026-06-10 22:40:07
19	90	1	2026-06-10 22:42:17	2026-06-10 22:44:19	2026-06-10 22:44:19
20	90	1	2026-06-10 22:46:45	2026-06-10 22:46:45	\N
21	110	3	2026-06-15 22:56:15	2026-06-15 22:56:15	\N
23	112	1	2026-06-28 13:23:00	2026-06-28 13:23:13	2026-06-28 13:23:13
24	112	1	2026-06-28 21:54:16	2026-06-28 21:54:16	\N
25	110	1	2026-06-28 22:08:21	2026-06-28 22:08:57	2026-06-28 22:08:57
26	110	1	2026-06-28 22:09:02	2026-06-28 22:09:03	2026-06-28 22:09:03
27	110	1	2026-06-28 22:09:12	2026-06-28 22:09:16	2026-06-28 22:09:16
28	130	1	2026-06-28 22:09:31	2026-06-28 22:09:34	2026-06-28 22:09:34
29	130	1	2026-06-28 22:09:35	2026-06-28 22:09:39	2026-06-28 22:09:39
30	130	1	2026-06-28 22:10:23	2026-06-28 22:10:24	2026-06-28 22:10:24
31	135	5	2026-06-28 22:20:01	2026-06-28 22:20:02	2026-06-28 22:20:02
32	135	1	2026-06-28 22:20:29	2026-06-28 22:20:36	2026-06-28 22:20:36
33	12	1	2026-06-28 22:35:47	2026-06-28 22:35:48	2026-06-28 22:35:48
34	109	1	2026-06-29 14:34:03	2026-06-29 14:34:03	\N
35	135	1	2026-06-29 14:34:33	2026-06-29 14:34:33	\N
22	111	1	2026-06-15 22:57:46	2026-06-29 14:39:04	2026-06-29 14:39:04
36	111	1	2026-06-29 14:39:05	2026-06-29 14:39:05	\N
8	7	1	2026-03-22 21:43:20	2026-06-29 16:13:40	2026-06-29 16:13:40
37	7	1	2026-06-29 16:13:41	2026-06-29 16:13:41	\N
38	142	1	2026-07-02 22:32:32	2026-07-02 22:32:34	2026-07-02 22:32:34
39	142	1	2026-07-02 22:32:36	2026-07-02 22:32:37	2026-07-02 22:32:37
40	143	1	2026-07-10 23:21:05	2026-07-10 23:21:06	2026-07-10 23:21:06
41	153	3	2026-07-31 02:53:58	2026-07-31 02:53:58	\N
42	152	3	2026-07-31 02:54:41	2026-07-31 02:54:41	\N
43	151	3	2026-07-31 02:54:43	2026-07-31 02:54:43	\N
44	138	3	2026-07-31 02:54:51	2026-07-31 02:54:51	\N
45	133	3	2026-07-31 02:54:52	2026-07-31 02:54:52	\N
46	156	2	2026-07-31 03:23:09	2026-07-31 03:23:09	\N
47	153	2	2026-07-31 03:23:11	2026-07-31 03:23:11	\N
48	152	2	2026-07-31 03:23:23	2026-07-31 03:23:23	\N
49	151	2	2026-07-31 03:23:24	2026-07-31 03:23:24	\N
50	138	2	2026-07-31 03:23:25	2026-07-31 03:23:25	\N
51	159	3	2026-07-31 03:28:26	2026-07-31 03:28:26	\N
52	159	1	2026-08-09 03:39:48	2026-08-09 03:39:48	\N
53	151	1	2026-08-09 03:40:08	2026-08-09 03:40:08	\N
55	185	1	2026-08-09 04:25:27	2026-08-09 04:25:27	\N
56	160	1	2026-08-09 04:25:39	2026-08-09 04:25:39	\N
57	187	1	2026-08-10 21:10:56	2026-08-10 21:10:56	\N
58	189	3	2026-09-22 10:24:28	2026-09-22 10:24:28	\N
59	191	1	2026-09-22 10:24:57	2026-09-22 10:24:57	\N
60	190	1	2026-09-22 10:24:59	2026-09-22 10:24:59	\N
61	195	1	2026-09-22 11:58:57	2026-09-22 11:58:57	\N
62	204	1	2026-09-24 08:51:47	2026-09-24 08:51:49	2026-09-24 08:51:49
63	201	1	2026-09-24 08:52:01	2026-09-24 08:52:01	\N
64	207	1	2026-09-24 19:23:09	2026-09-24 19:23:09	\N
65	210	1	2026-09-27 14:04:05	2026-09-27 14:04:05	\N
66	220	1	2026-09-30 15:23:19	2026-09-30 15:24:04	2026-09-30 15:24:04
67	218	1	2026-10-03 15:47:48	2026-10-03 15:47:48	\N
68	228	1	2026-10-13 15:44:57	2026-10-13 15:44:57	\N
69	221	1	2026-10-15 17:23:24	2026-10-15 17:23:24	\N
70	230	1	2026-10-19 21:22:10	2026-10-19 21:22:10	\N
72	227	1	2026-10-19 21:24:11	2026-10-19 21:25:58	2026-10-19 21:25:58
73	226	1	2026-10-19 21:26:03	2026-10-19 21:26:03	2026-10-19 21:26:03
74	226	1	2026-10-19 21:26:04	2026-10-19 21:26:07	2026-10-19 21:26:07
75	226	1	2026-10-19 21:26:08	2026-10-19 21:26:08	\N
71	234	1	2026-10-19 21:23:35	2026-10-19 21:26:13	2026-10-19 21:26:13
76	234	1	2026-10-19 21:26:14	2026-10-19 21:26:24	2026-10-19 21:26:24
77	234	1	2026-10-19 21:26:26	2026-10-19 21:26:32	2026-10-19 21:26:32
78	234	1	2026-10-19 21:26:33	2026-10-19 21:26:34	2026-10-19 21:26:34
79	234	1	2026-10-19 21:26:36	2026-10-19 21:27:07	2026-10-19 21:27:07
80	234	1	2026-10-19 21:27:10	2026-10-19 21:27:19	2026-10-19 21:27:19
81	233	5	2026-10-19 21:33:32	2026-10-19 21:33:32	\N
82	232	5	2026-10-19 21:33:33	2026-10-19 21:33:33	\N
83	230	5	2026-10-19 21:33:36	2026-10-19 21:33:36	\N
84	237	4	2026-10-20 23:53:20	2026-10-20 23:53:20	\N
85	233	4	2026-10-20 23:53:30	2026-10-20 23:53:30	\N
86	230	4	2026-10-20 23:53:34	2026-10-20 23:53:34	\N
87	228	4	2026-10-20 23:53:36	2026-10-20 23:53:36	\N
88	243	3	2026-10-22 17:47:37	2026-10-22 17:47:37	\N
89	228	3	2026-10-22 17:47:49	2026-10-22 17:47:49	\N
90	221	3	2026-10-22 17:47:59	2026-10-22 17:47:59	\N
91	233	1	2026-10-22 18:47:00	2026-10-22 18:47:00	\N
92	217	1	2026-10-22 18:47:25	2026-10-22 18:47:25	\N
93	231	1	2026-10-22 18:49:11	2026-10-22 18:49:11	\N
95	252	1	2026-10-23 15:10:38	2026-10-23 15:10:38	\N
54	12	1	2026-08-09 03:53:51	2026-10-23 19:49:20	2026-10-23 19:49:20
97	12	1	2026-10-23 19:49:21	2026-10-23 19:49:21	\N
96	133	1	2026-10-23 19:49:17	2026-10-23 19:49:22	2026-10-23 19:49:22
9	6	1	2026-03-22 21:51:54	2026-10-24 22:45:29	2026-10-24 22:45:29
98	6	1	2026-10-24 22:45:48	2026-10-24 22:45:48	\N
99	199	1	2026-10-24 22:47:50	2026-10-24 22:47:50	\N
94	243	1	2026-10-23 15:08:10	2026-10-25 12:07:06	2026-10-25 12:07:06
100	243	1	2026-10-25 12:07:07	2026-10-25 12:07:07	\N
101	283	3	2026-10-25 17:06:09	2026-10-25 17:06:09	\N
102	252	3	2026-10-25 17:06:13	2026-10-25 17:06:13	\N
103	284	1	2026-10-25 17:08:31	2026-10-25 17:08:31	\N
104	291	1	2026-10-30 21:10:59	2026-10-30 21:10:59	\N
105	282	3	2026-10-31 06:50:53	2026-10-31 06:50:53	\N
106	293	3	2026-10-31 06:57:50	2026-10-31 06:57:50	\N
107	290	3	2026-10-31 06:57:51	2026-10-31 06:57:51	\N
108	286	3	2026-10-31 06:57:53	2026-10-31 06:57:53	\N
109	237	1	2026-11-03 23:19:32	2026-11-03 23:19:32	\N
110	302	4	2026-11-06 15:02:58	2026-11-06 15:02:58	\N
111	300	4	2026-11-06 15:03:09	2026-11-06 15:03:09	\N
112	299	4	2026-11-06 15:03:11	2026-11-06 15:03:11	\N
113	290	4	2026-11-06 15:03:15	2026-11-06 15:03:15	\N
114	300	3	2026-11-06 15:05:45	2026-11-06 15:05:45	\N
115	302	3	2026-11-06 15:05:47	2026-11-06 15:05:47	\N
116	303	3	2026-11-06 15:05:49	2026-11-06 15:05:49	\N
117	303	1	2026-11-06 15:14:29	2026-11-06 15:14:29	\N
118	299	1	2026-11-11 21:59:46	2026-11-11 22:00:15	2026-11-11 22:00:15
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.posts (id, description, media_link, created_at, updated_at, deleted_at, is_repost, original_post_id, original_user_id, music_link) FROM stdin;
144	tes		2026-07-10 20:20:06	2026-07-10 23:20:08	2026-07-10 23:20:08	f	\N	\N	\N
4	Bom dia pessoal! 💜		2026-03-02 20:49:12	2026-03-02 23:51:35	2026-03-02 23:51:35	f	\N	\N	\N
6	Bom dia Pessoal		2026-03-02 20:51:40	2026-03-02 20:51:40	\N	f	\N	\N	\N
7	Vamos pescar hj 💦 ?		2026-03-02 20:51:54	2026-03-02 20:51:54	\N	f	\N	\N	\N
146	teste		2026-07-10 21:07:38	2026-07-11 00:07:43	2026-07-11 00:07:43	t	142	1	\N
8	teste		2026-03-10 16:51:27	2026-03-10 19:51:31	2026-03-10 19:51:31	f	\N	\N	\N
9	Esse é o meu portfolio 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a61f391fd426.45868746.mp4	2026-03-22 18:43:35	2026-03-22 21:43:46	2026-03-22 21:43:46	t	1	1	\N
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
20	Lindo design	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69fe1edbc85695.55532545.jpg	2026-05-08 14:35:25	2026-06-10 22:29:34	2026-06-10 22:29:34	f	\N	\N	\N
21	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69fe1f0474bd56.57218318.mp4	2026-05-08 14:36:16	2026-06-10 22:29:38	2026-06-10 22:29:38	f	\N	\N	\N
2	MVP da H Media 💙	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a620913354d6.86533246.mp4	2026-03-02 20:43:45	2026-06-28 22:15:51	2026-06-28 22:15:51	f	\N	\N	\N
10	MVP da H Media 💙	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a620913354d6.86533246.mp4	2026-03-22 18:43:50	2026-06-28 22:15:53	2026-06-28 22:15:53	t	2	1	\N
66	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22d96b7932a7.71930435.mp4	2026-06-05 11:13:04	2026-06-05 14:13:12	2026-06-05 14:13:12	f	\N	\N	\N
142	teste		2026-07-02 19:32:27	2026-10-23 04:00:55	2026-10-23 04:00:55	f	\N	\N	\N
67	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a22d989cccf53.02668244.jpg	2026-06-05 11:13:32	2026-06-05 14:13:36	2026-06-05 14:13:36	f	\N	\N	\N
68	teste		2026-06-05 11:13:40	2026-06-05 14:13:41	2026-06-05 14:13:41	f	\N	\N	\N
165	k		2026-08-09 00:04:32	2026-08-09 03:04:35	2026-08-09 03:04:35	f	\N	\N	\N
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
91	teste		2026-06-10 19:12:01	2026-06-10 22:12:03	2026-06-10 22:12:03	f	\N	\N	\N
92	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a29e141d07700.35664476.jpg	2026-06-10 19:12:21	2026-06-10 22:12:27	2026-06-10 22:12:27	f	\N	\N	\N
95	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69fe1f0474bd56.57218318.mp4	2026-06-10 19:24:55	2026-06-10 22:25:03	2026-06-10 22:25:03	t	93	1	\N
94	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a29e3b49880f6.57555689.jpg	2026-06-10 19:22:46	2026-06-10 22:25:07	2026-06-10 22:25:07	f	\N	\N	\N
98	Video massa 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6a22ee2b966cf7.94433712.mp4	2026-06-10 19:25:24	2026-06-10 22:25:27	2026-06-10 22:25:27	t	97	4	\N
97	Video massa 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6a22ee2b966cf7.94433712.mp4	2026-06-10 19:25:20	2026-06-10 22:25:29	2026-06-10 22:25:29	t	96	4	\N
96	Video massa 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6a22ee2b966cf7.94433712.mp4	2026-06-10 19:25:17	2026-06-10 22:25:30	2026-06-10 22:25:30	t	90	4	\N
99	Lindo design	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69fe1edbc85695.55532545.jpg	2026-06-10 19:27:22	2026-06-10 22:27:32	2026-06-10 22:27:32	t	20	1	\N
93	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69fe1f0474bd56.57218318.mp4	2026-06-10 19:21:40	2026-06-10 22:29:20	2026-06-10 22:29:20	t	21	1	\N
100	dz\\d	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a29e6a0650130.67617474.mp4	2026-06-10 19:35:14	2026-06-10 22:35:22	2026-06-10 22:35:22	f	\N	\N	\N
101	Vamos pescar hj 💦 ?		2026-06-10 19:36:37	2026-06-10 22:37:23	2026-06-10 22:37:23	t	7	3	\N
102	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a29e7880e6820.39966388.mp4	2026-06-10 19:39:40	2026-06-10 22:39:58	2026-06-10 22:39:58	f	\N	\N	\N
105	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a29e82d504e45.34685684.mp4	2026-06-10 19:42:01	2026-06-10 22:42:15	2026-06-10 22:42:15	f	\N	\N	\N
104	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a29e5862d5f17.37167275.mp4	2026-06-10 19:41:42	2026-06-10 22:43:36	2026-06-10 22:43:36	f	\N	\N	\N
103	Vamos pescar hj 💦 ?		2026-06-10 19:40:44	2026-06-10 22:43:37	2026-06-10 22:43:37	t	7	3	\N
90	Video massa 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6a22ee2b966cf7.94433712.mp4	2026-06-05 12:41:41	2026-06-11 09:09:38	2026-06-11 09:09:38	f	\N	\N	\N
106	tteste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a29e8ab719700.68058209.mp4	2026-06-10 19:44:02	2026-06-10 22:44:12	2026-06-10 22:44:12	f	\N	\N	\N
111	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a308334204ea4.65970375.mp4	2026-06-15 19:56:55	2026-07-02 22:34:49	2026-07-02 22:34:49	f	\N	\N	\N
273	Bom dia Pessoal		2026-10-25 09:05:52	2026-10-25 12:05:59	2026-10-25 12:05:59	t	12	3	\N
107	💙	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a29e91110f159.37505758.mp4	2026-06-10 19:46:17	2026-06-10 22:46:30	2026-06-10 22:46:30	f	\N	\N	\N
109	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6a2a7b631c1723.72180230.mp4	2026-06-11 06:09:58	2026-07-02 22:35:06	2026-07-02 22:35:06	f	\N	\N	\N
108	Vamos pescar hj 💦 ?		2026-06-10 19:46:34	2026-06-10 22:47:43	2026-06-10 22:47:43	t	7	3	\N
145	💛	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a46f83dd56511.67969580.jpg	2026-07-10 20:21:11	2026-07-10 23:21:18	2026-07-10 23:21:18	t	143	3	\N
147	Trabalhando na rede social 🤍	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/media_6a419df34f28f3.20121899.jpg	2026-07-10 21:07:44	2026-07-11 00:07:54	2026-07-11 00:07:54	t	138	5	\N
114	aaaa		2026-06-23 20:39:23	2026-06-24 00:04:07	2026-06-24 00:04:07	f	\N	\N	\N
113	teste		2026-06-23 20:39:03	2026-06-24 00:04:08	2026-06-24 00:04:08	f	\N	\N	\N
148	teste www.hedreiandrade.com.br		2026-07-10 21:20:21	2026-07-11 00:20:24	2026-07-11 00:20:24	f	\N	\N	\N
115	teste		2026-06-28 10:23:43	2026-06-28 13:24:18	2026-06-28 13:24:18	t	112	5	\N
116	teste		2026-06-28 10:24:26	2026-06-28 13:24:30	2026-06-28 13:24:30	t	112	5	\N
149	ggit.com		2026-07-10 21:20:36	2026-07-11 00:20:40	2026-07-11 00:20:40	f	\N	\N	\N
117	teste		2026-06-28 10:24:37	2026-06-28 13:25:01	2026-06-28 13:25:01	t	112	5	\N
150	soundcloud.com		2026-07-10 21:20:52	2026-07-11 00:21:06	2026-07-11 00:21:06	f	\N	\N	\N
119	teste		2026-06-28 10:25:13	2026-06-28 13:25:16	2026-06-28 13:25:16	t	118	5	\N
118	teste		2026-06-28 10:25:11	2026-06-28 13:25:17	2026-06-28 13:25:17	t	112	5	\N
143	💛	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a46f83dd56511.67969580.jpg	2026-07-02 20:46:12	2026-07-31 01:04:37	2026-07-31 01:04:37	f	\N	\N	\N
120	teste		2026-06-28 10:26:14	2026-06-28 13:26:33	2026-06-28 13:26:33	t	112	5	\N
121	teste		2026-06-28 10:26:43	2026-06-28 13:27:09	2026-06-28 13:27:09	t	112	5	\N
122	teste		2026-06-28 10:27:33	2026-06-28 13:27:50	2026-06-28 13:27:50	t	112	5	\N
124	teste		2026-06-28 18:52:57	2026-06-28 21:52:59	2026-06-28 21:52:59	t	123	5	\N
123	teste		2026-06-28 18:52:49	2026-06-28 21:52:59	2026-06-28 21:52:59	t	112	5	\N
154	teste		2026-07-31 00:05:32	2026-07-31 03:07:00	2026-07-31 03:07:00	f	\N	\N	\N
125	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a308334204ea4.65970375.mp4	2026-06-28 18:53:06	2026-06-28 21:53:33	2026-06-28 21:53:33	t	111	3	\N
126	teste		2026-06-28 18:53:41	2026-06-28 21:53:57	2026-06-28 21:53:57	t	112	5	\N
155	teste		2026-07-31 00:07:08	2026-07-31 03:07:14	2026-07-31 03:07:14	f	\N	\N	\N
127	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a308334204ea4.65970375.mp4	2026-06-28 18:54:00	2026-06-28 21:54:13	2026-06-28 21:54:13	t	111	3	\N
128	teste		2026-06-28 18:55:13	2026-06-28 21:58:45	2026-06-28 21:58:45	t	112	5	\N
129	haha	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a30601c863e72.26472188.mp4	2026-06-28 19:07:47	2026-06-28 22:07:55	2026-06-28 22:07:55	t	110	1	\N
157	teste		2026-07-31 00:24:48	2026-07-31 03:24:49	2026-07-31 03:24:49	f	\N	\N	\N
130	haha	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a30601c863e72.26472188.mp4	2026-06-28 19:09:27	2026-06-28 22:11:10	2026-06-28 22:11:10	t	110	1	\N
110	haha	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a30601c863e72.26472188.mp4	2026-06-15 17:28:09	2026-06-28 22:11:13	2026-06-28 22:11:13	f	\N	\N	\N
131	MVP da H Media 💙	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a620913354d6.86533246.mp4	2026-06-28 19:11:20	2026-06-28 22:12:21	2026-06-28 22:12:21	t	2	1	\N
161	teste		2026-08-08 23:42:41	2026-08-09 02:50:47	2026-08-09 02:50:47	f	\N	\N	\N
132	teste		2026-06-28 19:12:24	2026-06-28 22:12:35	2026-06-28 22:12:35	t	112	5	\N
112	teste		2026-06-22 22:58:41	2026-06-28 22:18:35	2026-06-28 22:18:35	f	\N	\N	\N
135	Trabalhando na rede social 🤍	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/media_6a419df34f28f3.20121899.jpg	2026-06-28 19:19:32	2026-06-28 19:19:32	\N	f	\N	\N	\N
136	Legal 	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a419d970e3b45.60192054.mp4	2026-06-28 19:41:00	2026-06-28 22:41:07	2026-06-28 22:41:07	t	134	1	\N
134	Legal 	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a419d970e3b45.60192054.mp4	2026-06-28 19:18:01	2026-06-28 22:44:13	2026-06-28 22:44:13	f	\N	\N	\N
137	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6a2a7b631c1723.72180230.mp4	2026-06-29 11:34:07	2026-06-29 14:34:24	2026-06-29 14:34:24	t	109	4	\N
139	teste		2026-06-29 11:35:21	2026-06-29 14:35:25	2026-06-29 14:35:25	f	\N	\N	\N
140	teste		2026-06-29 11:38:52	2026-06-29 14:38:54	2026-06-29 14:38:54	f	\N	\N	\N
141	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a308334204ea4.65970375.mp4	2026-06-29 11:39:09	2026-06-29 14:39:14	2026-06-29 14:39:14	t	111	3	\N
158	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebeandrade/media_6a6c158bce6fd3.18283327.jpg	2026-07-31 00:25:01	2026-07-31 03:25:06	2026-07-31 03:25:06	f	\N	\N	\N
159	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebeandrade/media_6a6c15af9bdc47.01220479.mp4	2026-07-31 00:25:37	2026-08-09 04:19:25	2026-08-09 04:19:25	f	\N	\N	\N
162	teste		2026-08-08 23:51:06	2026-08-09 03:02:47	2026-08-09 03:02:47	f	\N	\N	\N
163	teste		2026-08-09 00:02:56	2026-08-09 03:03:00	2026-08-09 03:03:00	f	\N	\N	\N
151	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-07-30 22:05:34	2026-09-22 10:16:44	2026-09-22 10:16:44	f	\N	\N	\N
152	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a6c0c515f3005.94560582.mp4	2026-07-30 23:45:41	2026-09-22 11:40:44	2026-09-22 11:40:44	f	\N	\N	\N
156		https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a6c12fe84da02.90567172.mp4	2026-07-31 00:14:19	2026-10-30 08:57:27	2026-10-30 08:57:27	f	\N	\N	\N
133	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a419d4e721c53.71307569.mp4	2026-06-28 19:16:54	2026-10-30 16:08:54	2026-10-30 16:08:54	f	\N	\N	\N
164	teste		2026-08-09 00:03:09	2026-08-09 03:03:19	2026-08-09 03:03:19	f	\N	\N	\N
166		https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a77ee63436bd1.89886746.png	2026-08-09 00:05:14	2026-08-09 03:05:22	2026-08-09 03:05:22	f	\N	\N	\N
167	teste		2026-08-09 00:12:58	2026-08-09 03:13:01	2026-08-09 03:13:01	f	\N	\N	\N
168	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-08-09 00:40:10	2026-08-09 03:40:45	2026-08-09 03:40:45	t	151	3	\N
169	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-08-09 00:41:10	2026-08-09 03:42:35	2026-08-09 03:42:35	t	151	3	\N
170	Vamos pescar hj 💦 ?		2026-08-09 00:43:00	2026-08-09 03:43:07	2026-08-09 03:43:07	t	7	3	\N
171	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebeandrade/media_6a6c15af9bdc47.01220479.mp4	2026-08-09 00:43:15	2026-08-09 03:43:25	2026-08-09 03:43:25	t	159	2	\N
172	Trabalhando na rede social 🤍	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/media_6a419df34f28f3.20121899.jpg	2026-08-09 00:44:06	2026-08-09 03:44:21	2026-08-09 03:44:21	t	138	5	\N
173	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-08-09 00:48:28	2026-08-09 03:48:44	2026-08-09 03:48:44	t	151	3	\N
174	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-08-09 00:48:50	2026-08-09 03:48:55	2026-08-09 03:48:55	t	151	3	\N
175	Trabalhando na rede social 🤍	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/media_6a419df34f28f3.20121899.jpg	2026-08-09 00:49:23	2026-08-09 03:49:31	2026-08-09 03:49:31	t	135	5	\N
176	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-08-09 00:50:12	2026-08-09 03:50:20	2026-08-09 03:50:20	t	151	3	\N
177	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-08-09 00:50:36	2026-08-09 03:50:42	2026-08-09 03:50:42	t	151	3	\N
178	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-08-09 00:51:28	2026-08-09 03:51:32	2026-08-09 03:51:32	t	151	3	\N
179	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-08-09 00:51:42	2026-08-09 03:51:49	2026-08-09 03:51:49	t	151	3	\N
180	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-08-09 00:52:01	2026-08-09 03:52:05	2026-08-09 03:52:05	t	151	3	\N
181	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-08-09 00:52:13	2026-08-09 03:52:22	2026-08-09 03:52:22	t	151	3	\N
182	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-08-09 00:52:33	2026-08-09 03:52:44	2026-08-09 03:52:44	t	151	3	\N
184	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a77fa406a7098.85134109.jpg	2026-08-09 00:55:48	2026-08-09 04:17:38	2026-08-09 04:17:38	f	\N	\N	\N
183	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebeandrade/media_6a6c15af9bdc47.01220479.mp4	2026-08-09 00:54:13	2026-08-09 04:17:42	2026-08-09 04:17:42	t	159	2	\N
185	Boa madrugada amigos !!! 🖤		2026-08-09 01:19:59	2026-08-09 01:19:59	\N	f	\N	\N	\N
138	Trabalhando na rede social 🤍	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/media_6a419df34f28f3.20121899.jpg	2026-06-29 11:34:44	2026-08-09 04:20:29	2026-08-09 04:20:29	t	135	5	\N
188	kkk		2026-09-19 18:09:38	2026-09-19 21:09:40	2026-09-19 21:09:40	f	\N	\N	\N
187	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a7801b3ef1c65.55553091.jpg	2026-08-09 01:27:40	2026-09-22 10:14:22	2026-09-22 10:14:22	f	\N	\N	\N
186	Studio time !	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6c16526ebd44.97891671.mp4	2026-08-09 01:25:48	2026-09-22 10:14:43	2026-09-22 10:14:43	t	160	3	\N
160	Studio time !	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6c16526ebd44.97891671.mp4	2026-07-31 00:28:23	2026-09-22 10:16:00	2026-09-22 10:16:00	f	\N	\N	\N
194	teste vertical	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ab265b2390d59.66806731.mp4	2026-09-22 08:25:41	2026-09-22 11:26:41	2026-09-22 11:26:41	f	\N	\N	\N
193	Star Projectt news www.youtube.com/@starprojectt	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ab25d9be59ca8.43789523.mp4	2026-09-22 07:51:15	2026-09-22 11:40:33	2026-09-22 11:40:33	f	\N	\N	\N
192	H Media news 💛\r\nwww.github.com/hedreiandrade	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6ab257506e7839.94304961.mp4	2026-09-22 07:25:09	2026-09-22 11:40:35	2026-09-22 11:40:35	t	190	3	\N
189	Eu 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ab256aca519b1.55131892.mp4	2026-09-22 07:21:34	2026-09-22 11:40:49	2026-09-22 11:40:49	f	\N	\N	\N
191	Eu 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ab256aca519b1.55131892.mp4	2026-09-22 07:24:38	2026-09-22 11:41:05	2026-09-22 11:41:05	t	189	1	\N
190	H Media news 💛\r\nwww.github.com/hedreiandrade	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6ab257506e7839.94304961.mp4	2026-09-22 07:24:18	2026-09-22 11:41:07	2026-09-22 11:41:07	f	\N	\N	\N
197	dsada	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ab26c33d04d08.02827051.mp4	2026-09-22 08:53:27	2026-09-22 11:53:50	2026-09-22 11:53:50	f	\N	\N	\N
195	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab2696813adc1.49330589.mp4	2026-09-22 08:41:29	2026-09-24 19:10:41	2026-09-24 19:10:41	f	\N	\N	\N
196	💚	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6ab2699434d544.41269264.mp4	2026-09-22 08:42:13	2026-10-13 15:44:22	2026-10-13 15:44:22	f	\N	\N	\N
198	gfgf	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6ab26c6332f899.51070867.mp4	2026-09-22 08:54:15	2026-09-22 11:54:28	2026-09-22 11:54:28	f	\N	\N	\N
202	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab2696813adc1.49330589.mp4	2026-09-22 08:58:58	2026-09-22 12:00:33	2026-09-22 12:00:33	t	195	3	\N
203	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab2696813adc1.49330589.mp4	2026-09-22 09:00:42	2026-09-22 12:01:15	2026-09-22 12:01:15	t	195	3	\N
206	Studio time 💜	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab26d1aa62ab4.90579652.mp4	2026-09-24 05:52:29	2026-09-24 08:52:48	2026-09-24 08:52:48	t	200	3	\N
205	Studio time 💜	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab26d1aa62ab4.90579652.mp4	2026-09-24 05:52:27	2026-09-24 19:09:56	2026-09-24 19:09:56	t	200	3	\N
200	Studio time 💜	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab26d1aa62ab4.90579652.mp4	2026-09-22 08:57:20	2026-09-24 19:10:38	2026-09-24 19:10:38	f	\N	\N	\N
201	Bom dia amigos!!!	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab26d6a3115f5.51176649.mp4	2026-09-22 08:58:36	2026-09-24 19:12:43	2026-09-24 19:12:43	f	\N	\N	\N
204	Bom dia amigos!!!	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab26d6a3115f5.51176649.mp4	2026-09-22 09:01:35	2026-09-24 19:22:34	2026-09-24 19:22:34	t	201	3	\N
211	🤎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab578239259c5.30471174.mp4	2026-09-24 16:36:52	2026-09-26 19:11:56	2026-09-26 19:11:56	f	\N	\N	\N
212	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ab922a29c7799.13560301.jpg	2026-09-27 11:05:31	2026-09-27 14:10:52	2026-09-27 14:10:52	f	\N	\N	\N
213	🤎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab57640357b98.13481732.mp4	2026-09-27 11:05:42	2026-09-27 14:10:56	2026-09-27 14:10:56	t	210	3	\N
214	🤎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab57640357b98.13481732.mp4	2026-09-27 11:12:44	2026-09-30 01:32:44	2026-09-30 01:32:44	t	210	3	\N
210	🤎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab57640357b98.13481732.mp4	2026-09-24 16:32:38	2026-09-30 01:33:12	2026-09-30 01:33:12	f	\N	\N	\N
216		https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/_verticalmedia_6abc6741e45274.31414225.mp4	2026-09-29 22:35:00	2026-09-29 22:35:00	\N	f	\N	\N	\N
219	www.github.com/hedreiandrade	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6abd1d7a6b3d45.53574837.mp4	2026-09-30 11:32:30	2026-09-30 15:12:32	2026-09-30 15:12:32	f	\N	\N	\N
223	teste		2026-10-09 01:13:48	2026-10-09 04:13:51	2026-10-09 04:13:51	f	\N	\N	\N
225	💜	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6abc67e98ba737.84474005.mp4	2026-10-09 19:56:49	2026-10-09 22:57:07	2026-10-09 22:57:07	t	224	5	\N
224	💜	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6abc67e98ba737.84474005.mp4	2026-10-09 01:13:59	2026-10-09 22:57:15	2026-10-09 22:57:15	t	218	5	\N
222	💜	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6abc67e98ba737.84474005.mp4	2026-10-09 01:12:56	2026-10-09 22:58:47	2026-10-09 22:58:47	t	218	5	\N
228	Art by Mara Dias 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6ace4e73ce4929.15474908.jpg	2026-10-13 12:29:58	2026-10-13 12:29:58	\N	f	\N	\N	\N
208	💚	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6ab2699434d544.41269264.mp4	2026-09-24 16:23:19	2026-10-13 15:44:42	2026-10-13 15:44:42	t	196	1	\N
229	teste		2026-10-15 14:23:15	2026-10-15 17:23:18	2026-10-15 17:23:18	f	\N	\N	\N
231	Bom dia Pessoal !		2026-10-17 13:52:00	2026-10-17 13:52:00	\N	f	\N	\N	\N
232	Bom dia Pessoal !		2026-10-17 13:55:06	2026-10-17 13:55:06	\N	t	231	6	\N
226	💜	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6abc67e98ba737.84474005.mp4	2026-10-09 19:59:08	2026-10-19 21:40:47	2026-10-19 21:40:47	t	218	5	\N
207	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab575e75ee301.50845001.mp4	2026-09-24 16:12:17	2026-10-22 17:46:45	2026-10-22 17:46:45	f	\N	\N	\N
230	Produzindo minha nova música chamada Yellow goa, espero que gostem estou produzindo ela a dias e está linda 💙	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6abd1ede2e6d28.01632503.mp4	2026-10-17 12:34:52	2026-10-22 17:46:52	2026-10-22 17:46:52	t	220	1	\N
221	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab575e75ee301.50845001.mp4	2026-09-30 12:24:43	2026-10-22 17:48:36	2026-10-22 17:48:36	t	207	3	\N
220	Produzindo minha nova música chamada Yellow goa, espero que gostem estou produzindo ela a dias e está linda 💙	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6abd1ede2e6d28.01632503.mp4	2026-09-30 11:38:28	2026-10-22 17:48:37	2026-10-22 17:48:37	f	\N	\N	\N
217	Bom dia!		2026-09-29 22:36:54	2026-10-23 19:55:59	2026-10-23 19:55:59	f	\N	\N	\N
215	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ab924dba15e76.09681441.jpg	2026-09-27 11:14:53	2026-10-25 12:10:55	2026-10-25 12:10:55	f	\N	\N	\N
209	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6ab26c8092c117.75494562.mp4	2026-09-24 16:23:23	2026-10-25 12:10:58	2026-10-25 12:10:58	t	199	1	\N
199	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6ab26c8092c117.75494562.mp4	2026-09-22 08:54:44	2026-10-25 12:11:00	2026-10-25 12:11:00	f	\N	\N	\N
234	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab575e75ee301.50845001.mp4	2026-10-19 18:22:09	2026-10-19 21:28:13	2026-10-19 21:28:13	t	221	3	\N
235	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab575e75ee301.50845001.mp4	2026-10-19 18:28:25	2026-10-19 21:28:36	2026-10-19 21:28:36	t	221	3	\N
236	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ab575e75ee301.50845001.mp4	2026-10-19 18:28:47	2026-10-19 21:28:54	2026-10-19 21:28:54	t	221	3	\N
218	💜	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6abc67e98ba737.84474005.mp4	2026-09-29 22:37:51	2026-10-19 21:31:48	2026-10-19 21:31:48	f	\N	\N	\N
237	Que somzera 😎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6ad68c9a064e58.35364478.mp4	2026-10-19 18:33:23	2026-10-19 18:33:23	\N	f	\N	\N	\N
238	Que somzera 😎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6ad68c9a064e58.35364478.mp4	2026-10-19 18:34:36	2026-10-19 21:34:40	2026-10-19 21:34:40	t	237	5	\N
239	Que somzera 😎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6ad68c9a064e58.35364478.mp4	2026-10-19 18:35:21	2026-10-19 21:39:43	2026-10-19 21:39:43	t	237	5	\N
242	teste 🤣	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ad7fe5023e355.37373439.mp4	2026-10-20 20:50:50	2026-10-20 23:51:28	2026-10-20 23:51:28	f	\N	\N	\N
227	Produzindo minha nova música chamada Yellow goa, espero que gostem estou produzindo ela a dias e está linda 💙	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6abd1ede2e6d28.01632503.mp4	2026-10-11 22:47:56	2026-10-22 17:45:52	2026-10-22 17:45:52	t	220	1	\N
240	teste		2026-10-20 20:47:46	2026-10-22 17:48:45	2026-10-22 17:48:45	f	\N	\N	\N
241	teste		2026-10-20 20:48:27	2026-10-22 17:48:47	2026-10-22 17:48:47	f	\N	\N	\N
246	Produzindo minha nova música chamada Yellow goa, espero que gostem estou produzindo ela a dias e está linda.	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ada4c26a8f4d5.01174213.mp4	2026-10-22 14:49:29	2026-10-22 17:49:34	2026-10-22 17:49:34	t	245	3	\N
245	Produzindo minha nova música chamada Yellow goa, espero que gostem estou produzindo ela a dias e está linda.	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ada4c26a8f4d5.01174213.mp4	2026-10-22 14:49:27	2026-10-22 19:53:03	2026-10-22 19:53:03	t	244	3	\N
244	Produzindo minha nova música chamada Yellow goa, espero que gostem estou produzindo ela a dias e está linda.	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ada4c26a8f4d5.01174213.mp4	2026-10-22 14:47:24	2026-10-22 19:53:24	2026-10-22 19:53:24	f	\N	\N	\N
248	Art by Mara Dias 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6ace4e73ce4929.15474908.jpg	2026-10-22 17:42:03	2026-10-22 17:42:03	\N	t	228	3	\N
251	teste		2026-10-23 01:02:45	2026-10-23 04:02:47	2026-10-23 04:02:47	f	\N	\N	\N
250	Boa madrugada amigos !!! 🖤		2026-10-23 01:00:58	2026-10-23 15:04:46	2026-10-23 15:04:46	t	185	2	\N
249	Que somzera 😎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6ad68c9a064e58.35364478.mp4	2026-10-22 17:44:12	2026-10-23 15:05:09	2026-10-23 15:05:09	t	237	5	\N
252	Que somzera 😎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6ad68c9a064e58.35364478.mp4	2026-10-23 12:07:49	2026-10-23 12:07:49	\N	t	237	5	\N
254	Bom dia!		2026-10-23 16:48:57	2026-10-23 19:49:09	2026-10-23 19:49:09	t	217	1	\N
255	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a419d4e721c53.71307569.mp4	2026-10-23 16:49:29	2026-10-23 19:49:42	2026-10-23 19:49:42	t	133	1	\N
256	Bom dia Pessoal		2026-10-23 16:54:22	2026-10-23 19:54:26	2026-10-23 19:54:26	t	6	3	\N
253	teste		2026-10-23 12:10:52	2026-10-23 19:55:04	2026-10-23 19:55:04	f	\N	\N	\N
257	Bom dia!		2026-10-23 16:55:12	2026-10-23 19:55:55	2026-10-23 19:55:55	t	217	1	\N
258	Vamos pescar hj 💦 ?		2026-10-23 16:56:08	2026-10-23 19:56:19	2026-10-23 19:56:19	t	7	3	\N
259	❤💓	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a6c0e2a63ad86.95155625.mp4	2026-10-23 16:56:31	2026-10-23 19:57:08	2026-10-23 19:57:08	t	153	1	\N
261	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6ab26c8092c117.75494562.mp4	2026-10-24 19:48:34	2026-10-24 22:48:51	2026-10-24 22:48:51	t	199	1	\N
262	Vamos pescar hj 💦 ?		2026-10-25 08:49:20	2026-10-25 11:49:23	2026-10-25 11:49:23	t	260	3	\N
263	Que somzera 😎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6ad68c9a064e58.35364478.mp4	2026-10-25 08:49:31	2026-10-25 11:49:36	2026-10-25 11:49:36	t	252	5	\N
264	Bom dia Pessoal		2026-10-25 08:52:53	2026-10-25 11:52:58	2026-10-25 11:52:58	t	6	3	\N
265	Que somzera 😎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6ad68c9a064e58.35364478.mp4	2026-10-25 08:53:06	2026-10-25 11:53:11	2026-10-25 11:53:11	t	237	5	\N
266	Bom dia Pessoal !		2026-10-25 08:55:22	2026-10-25 11:55:29	2026-10-25 11:55:29	t	232	6	\N
267	Bom dia Pessoal !		2026-10-25 08:55:45	2026-10-25 11:56:00	2026-10-25 11:56:00	t	232	6	\N
268	Bom dia Pessoal		2026-10-25 09:01:02	2026-10-25 12:01:12	2026-10-25 12:01:12	t	12	3	\N
269	Bom dia Pessoal !		2026-10-25 09:01:28	2026-10-25 12:01:34	2026-10-25 12:01:34	t	232	6	\N
270	Bom dia Pessoal !		2026-10-25 09:03:12	2026-10-25 12:03:17	2026-10-25 12:03:17	t	232	6	\N
271	Bom dia Pessoal !		2026-10-25 09:05:20	2026-10-25 12:05:23	2026-10-25 12:05:23	t	232	6	\N
272	Bom dia Pessoal		2026-10-25 09:05:41	2026-10-25 12:06:26	2026-10-25 12:06:26	t	12	3	\N
260	Vamos pescar hj 💦 ?		2026-10-23 17:03:21	2026-10-25 12:06:28	2026-10-25 12:06:28	t	7	3	\N
243	MVP 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6ad7fe9e12cba5.02640827.mp4	2026-10-20 20:52:12	2026-10-25 12:09:50	2026-10-25 12:09:50	f	\N	\N	\N
233	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ab924dba15e76.09681441.jpg	2026-10-18 16:42:54	2026-10-25 12:10:30	2026-10-25 12:10:30	t	215	1	\N
274	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6ab924dba15e76.09681441.jpg	2026-10-25 09:06:04	2026-10-25 12:06:19	2026-10-25 12:06:19	t	215	1	\N
276	MVP 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6ad7fe9e12cba5.02640827.mp4	2026-10-25 09:07:09	2026-10-25 12:07:15	2026-10-25 12:07:15	t	243	4	\N
277	Vamos pescar hj 💦 ?		2026-10-25 09:07:20	2026-10-25 12:07:25	2026-10-25 12:07:25	t	7	3	\N
278		https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a6c12fe84da02.90567172.mp4	2026-10-25 09:07:31	2026-10-25 12:07:44	2026-10-25 12:07:44	t	156	1	\N
247	MVP 🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6ad7fe9e12cba5.02640827.mp4	2026-10-22 14:58:07	2026-10-25 12:08:29	2026-10-25 12:08:29	t	243	4	\N
280	Bom dia Pessoal !		2026-10-25 09:08:59	2026-10-25 12:09:03	2026-10-25 12:09:03	t	231	6	\N
281		https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a6c12fe84da02.90567172.mp4	2026-10-25 09:09:09	2026-10-25 12:09:15	2026-10-25 12:09:15	t	156	1	\N
279	Bom dia Pessoal !		2026-10-25 09:08:50	2026-10-25 12:13:07	2026-10-25 12:13:07	t	232	6	\N
275	Bom dia Pessoal !		2026-10-25 09:06:52	2026-10-25 12:13:11	2026-10-25 12:13:11	t	232	6	\N
282	Bom dia Pessoal		2026-10-25 09:14:38	2026-10-25 09:14:38	\N	t	12	3	\N
284	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ade36f6cecef1.89563213.mp4	2026-10-25 14:06:01	2026-10-25 14:06:01	\N	f	\N	\N	\N
285	Bom dia Pessoal		2026-10-25 14:08:24	2026-10-25 17:08:28	2026-10-25 17:08:28	t	6	3	\N
286	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ade36f6cecef1.89563213.mp4	2026-10-25 14:09:23	2026-10-25 14:09:23	\N	t	284	3	\N
288	teste		2026-10-25 14:10:21	2026-10-25 17:10:22	2026-10-25 17:10:22	f	\N	\N	\N
153	❤💓	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a6c0e2a63ad86.95155625.mp4	2026-07-30 23:53:33	2026-10-30 08:56:25	2026-10-30 08:56:25	f	\N	\N	\N
283	❤💓	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a6c0e2a63ad86.95155625.mp4	2026-10-25 09:15:20	2026-10-30 08:56:24	2026-10-30 08:56:24	t	153	1	\N
289	teste		2026-10-30 05:59:07	2026-10-30 08:59:09	2026-10-30 08:59:09	f	\N	\N	\N
287	Que somzera 😎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6ad68c9a064e58.35364478.mp4	2026-10-25 14:09:59	2026-10-30 08:59:22	2026-10-30 08:59:22	t	252	5	\N
290	Que somzera 😎	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6ad68c9a064e58.35364478.mp4	2026-10-30 05:59:29	2026-10-30 05:59:29	\N	t	237	5	\N
292	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6ae4c15d173115.45753964.mp4	2026-10-30 18:11:14	2026-10-30 21:11:55	2026-10-30 21:11:55	t	291	1	\N
291	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6ae4c15d173115.45753964.mp4	2026-10-30 13:10:09	2026-10-30 21:14:48	2026-10-30 21:14:48	f	\N	\N	\N
293	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6ae508e8010cb9.34178461.mp4	2026-10-30 18:15:22	2026-10-30 18:15:22	\N	f	\N	\N	\N
294	Bom dia Pessoal		2026-10-30 18:16:40	2026-10-30 21:16:43	2026-10-30 21:16:43	t	12	3	\N
295	teste		2026-10-31 02:54:47	2026-10-31 06:21:22	2026-10-31 06:21:22	f	\N	\N	\N
298	hahahhhaha		2026-10-31 03:42:03	2026-10-31 14:45:10	2026-10-31 14:45:10	f	\N	\N	\N
297	dsadasda		2026-10-31 03:20:16	2026-10-31 14:45:12	2026-10-31 14:45:12	f	\N	\N	\N
299	Bom dia pessoal 🖤		2026-10-31 11:45:23	2026-10-31 11:45:23	\N	f	\N	\N	\N
300	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6ae719c6250262.66498601.mp4	2026-11-01 07:51:57	2026-11-01 07:51:57	\N	f	\N	\N	\N
301	teste		2026-11-01 07:54:23	2026-11-01 10:54:31	2026-11-01 10:54:31	f	\N	\N	\N
302	Esse é meu portfolio !\r\nE aí gostaram ?🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6aec57d7f132c8.36984837.mp4	2026-11-05 07:18:19	2026-11-05 07:18:19	\N	f	\N	\N	\N
303	Psycho !	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6aedec11bbd862.77149256.mp4	2026-11-06 12:02:51	2026-11-06 12:02:51	\N	f	\N	\N	\N
296	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/_verticalmedia_6ae58899959ef1.48968203.mp4	2026-10-31 03:20:13	2026-11-06 15:05:14	2026-11-06 15:05:14	f	\N	\N	\N
304	Coding the social media called H Media.	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/_verticalmedia_6aededd421b8c1.87962023.mp4	2026-11-06 12:10:14	2026-11-06 12:10:14	\N	f	\N	\N	\N
305		https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/_verticalmedia_6aedee776d81b8.65266411.mp4	2026-11-06 12:12:59	2026-11-06 15:13:06	2026-11-06 15:13:06	f	\N	\N	\N
306	Psycho !	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6aedec11bbd862.77149256.mp4	2026-11-06 12:14:44	2026-11-06 12:14:44	\N	t	303	4	\N
307	teste		2026-11-06 12:16:54	2026-11-06 15:16:59	2026-11-06 15:16:59	f	\N	\N	\N
308	Evolução da rede social H Media até agora 🪐 Hello, evolution of H Media, you can run the micro service api-doeobem(lnkd.in/d_3u9…) and api-doeobem-feed (lnkd.in/dXPhB… ) by DockerCompose and after this, run the Reacts Applications for social media called H Media (lnkd.in/dJrib…) 🧑🏾‍💻 #phpdeveloper  #reactdeveloper		2026-11-07 01:28:55	2026-11-07 04:29:01	2026-11-07 04:29:01	f	\N	\N	\N
309	Bom dia Pessoal		2026-11-09 19:09:37	2026-11-09 22:09:43	2026-11-09 22:09:43	t	12	3	\N
310	Bom dia pessoal 🖤		2026-11-11 19:00:21	2026-11-11 22:00:28	2026-11-11 22:00:28	t	299	3	\N
311	Bom dia pessoal 🖤		2026-11-11 19:00:34	2026-11-11 22:00:40	2026-11-11 22:00:40	t	299	3	\N
312	Psycho !	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6aedec11bbd862.77149256.mp4	2026-11-11 19:34:28	2026-11-11 19:34:28	\N	t	306	4	\N
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
93	1	93	2026-06-10 19:21:40	2026-06-10 19:21:40	\N
94	1	94	2026-06-10 19:22:46	2026-06-10 19:22:46	\N
95	1	95	2026-06-10 19:24:55	2026-06-10 19:24:55	\N
96	1	96	2026-06-10 19:25:17	2026-06-10 19:25:17	\N
97	1	97	2026-06-10 19:25:20	2026-06-10 19:25:20	\N
98	1	98	2026-06-10 19:25:24	2026-06-10 19:25:24	\N
99	1	99	2026-06-10 19:27:22	2026-06-10 19:27:22	\N
100	1	100	2026-06-10 19:35:14	2026-06-10 19:35:14	\N
101	1	101	2026-06-10 19:36:37	2026-06-10 19:36:37	\N
102	1	102	2026-06-10 19:39:40	2026-06-10 19:39:40	\N
103	1	103	2026-06-10 19:40:45	2026-06-10 19:40:45	\N
104	1	104	2026-06-10 19:41:42	2026-06-10 19:41:42	\N
105	1	105	2026-06-10 19:42:01	2026-06-10 19:42:01	\N
106	1	106	2026-06-10 19:44:02	2026-06-10 19:44:02	\N
107	1	107	2026-06-10 19:46:17	2026-06-10 19:46:17	\N
108	1	108	2026-06-10 19:46:34	2026-06-10 19:46:34	\N
109	4	109	2026-06-11 06:09:58	2026-06-11 06:09:58	\N
110	1	110	2026-06-15 17:28:10	2026-06-15 17:28:10	\N
111	3	111	2026-06-15 19:56:55	2026-06-15 19:56:55	\N
112	5	112	2026-06-22 22:58:41	2026-06-22 22:58:41	\N
113	1	113	2026-06-23 20:39:03	2026-06-23 20:39:03	\N
114	1	114	2026-06-23 20:39:23	2026-06-23 20:39:23	\N
115	1	115	2026-06-28 10:23:43	2026-06-28 10:23:43	\N
116	1	116	2026-06-28 10:24:26	2026-06-28 10:24:26	\N
117	1	117	2026-06-28 10:24:37	2026-06-28 10:24:37	\N
118	1	118	2026-06-28 10:25:11	2026-06-28 10:25:11	\N
119	1	119	2026-06-28 10:25:13	2026-06-28 10:25:13	\N
120	1	120	2026-06-28 10:26:14	2026-06-28 10:26:14	\N
121	1	121	2026-06-28 10:26:43	2026-06-28 10:26:43	\N
122	1	122	2026-06-28 10:27:33	2026-06-28 10:27:33	\N
123	1	123	2026-06-28 18:52:49	2026-06-28 18:52:49	\N
124	1	124	2026-06-28 18:52:57	2026-06-28 18:52:57	\N
125	1	125	2026-06-28 18:53:06	2026-06-28 18:53:06	\N
126	1	126	2026-06-28 18:53:42	2026-06-28 18:53:42	\N
127	1	127	2026-06-28 18:54:00	2026-06-28 18:54:00	\N
128	1	128	2026-06-28 18:55:13	2026-06-28 18:55:13	\N
129	1	129	2026-06-28 19:07:48	2026-06-28 19:07:48	\N
130	1	130	2026-06-28 19:09:27	2026-06-28 19:09:27	\N
131	1	131	2026-06-28 19:11:20	2026-06-28 19:11:20	\N
132	1	132	2026-06-28 19:12:24	2026-06-28 19:12:24	\N
133	1	133	2026-06-28 19:16:54	2026-06-28 19:16:54	\N
134	1	134	2026-06-28 19:18:02	2026-06-28 19:18:02	\N
135	5	135	2026-06-28 19:19:32	2026-06-28 19:19:32	\N
136	1	136	2026-06-28 19:41:00	2026-06-28 19:41:00	\N
137	1	137	2026-06-29 11:34:08	2026-06-29 11:34:08	\N
138	1	138	2026-06-29 11:34:45	2026-06-29 11:34:45	\N
139	1	139	2026-06-29 11:35:22	2026-06-29 11:35:22	\N
140	1	140	2026-06-29 11:38:52	2026-06-29 11:38:52	\N
141	1	141	2026-06-29 11:39:09	2026-06-29 11:39:09	\N
142	1	142	2026-07-02 19:32:28	2026-07-02 19:32:28	\N
143	3	143	2026-07-02 20:46:12	2026-07-02 20:46:12	\N
144	1	144	2026-07-10 20:20:07	2026-07-10 20:20:07	\N
145	1	145	2026-07-10 20:21:11	2026-07-10 20:21:11	\N
146	1	146	2026-07-10 21:07:39	2026-07-10 21:07:39	\N
147	1	147	2026-07-10 21:07:45	2026-07-10 21:07:45	\N
148	1	148	2026-07-10 21:20:22	2026-07-10 21:20:22	\N
149	1	149	2026-07-10 21:20:36	2026-07-10 21:20:36	\N
150	1	150	2026-07-10 21:20:52	2026-07-10 21:20:52	\N
151	3	151	2026-07-30 22:05:34	2026-07-30 22:05:34	\N
152	1	152	2026-07-30 23:45:41	2026-07-30 23:45:41	\N
153	1	153	2026-07-30 23:53:33	2026-07-30 23:53:33	\N
154	1	154	2026-07-31 00:05:33	2026-07-31 00:05:33	\N
155	1	155	2026-07-31 00:07:08	2026-07-31 00:07:08	\N
156	1	156	2026-07-31 00:14:19	2026-07-31 00:14:19	\N
157	2	157	2026-07-31 00:24:48	2026-07-31 00:24:48	\N
158	2	158	2026-07-31 00:25:01	2026-07-31 00:25:01	\N
159	2	159	2026-07-31 00:25:37	2026-07-31 00:25:37	\N
160	3	160	2026-07-31 00:28:23	2026-07-31 00:28:23	\N
161	1	161	2026-08-08 23:42:44	2026-08-08 23:42:44	\N
162	1	162	2026-08-08 23:51:07	2026-08-08 23:51:07	\N
163	1	163	2026-08-09 00:02:56	2026-08-09 00:02:56	\N
164	1	164	2026-08-09 00:03:10	2026-08-09 00:03:10	\N
165	1	165	2026-08-09 00:04:32	2026-08-09 00:04:32	\N
166	1	166	2026-08-09 00:05:14	2026-08-09 00:05:14	\N
167	1	167	2026-08-09 00:12:59	2026-08-09 00:12:59	\N
168	1	168	2026-08-09 00:40:10	2026-08-09 00:40:10	\N
169	1	169	2026-08-09 00:41:10	2026-08-09 00:41:10	\N
170	1	170	2026-08-09 00:43:00	2026-08-09 00:43:00	\N
171	1	171	2026-08-09 00:43:15	2026-08-09 00:43:15	\N
172	1	172	2026-08-09 00:44:06	2026-08-09 00:44:06	\N
173	1	173	2026-08-09 00:48:28	2026-08-09 00:48:28	\N
174	1	174	2026-08-09 00:48:50	2026-08-09 00:48:50	\N
175	1	175	2026-08-09 00:49:23	2026-08-09 00:49:23	\N
176	1	176	2026-08-09 00:50:12	2026-08-09 00:50:12	\N
177	1	177	2026-08-09 00:50:36	2026-08-09 00:50:36	\N
178	1	178	2026-08-09 00:51:28	2026-08-09 00:51:28	\N
179	1	179	2026-08-09 00:51:42	2026-08-09 00:51:42	\N
180	1	180	2026-08-09 00:52:01	2026-08-09 00:52:01	\N
181	1	181	2026-08-09 00:52:14	2026-08-09 00:52:14	\N
182	1	182	2026-08-09 00:52:34	2026-08-09 00:52:34	\N
183	1	183	2026-08-09 00:54:13	2026-08-09 00:54:13	\N
184	1	184	2026-08-09 00:55:48	2026-08-09 00:55:48	\N
185	2	185	2026-08-09 01:19:59	2026-08-09 01:19:59	\N
186	1	186	2026-08-09 01:25:48	2026-08-09 01:25:48	\N
187	1	187	2026-08-09 01:27:40	2026-08-09 01:27:40	\N
188	1	188	2026-09-19 18:09:39	2026-09-19 18:09:39	\N
189	1	189	2026-09-22 07:21:34	2026-09-22 07:21:34	\N
190	3	190	2026-09-22 07:24:18	2026-09-22 07:24:18	\N
191	3	191	2026-09-22 07:24:38	2026-09-22 07:24:38	\N
192	1	192	2026-09-22 07:25:09	2026-09-22 07:25:09	\N
193	1	193	2026-09-22 07:51:16	2026-09-22 07:51:16	\N
194	1	194	2026-09-22 08:25:41	2026-09-22 08:25:41	\N
195	3	195	2026-09-22 08:41:29	2026-09-22 08:41:29	\N
196	1	196	2026-09-22 08:42:13	2026-09-22 08:42:13	\N
197	1	197	2026-09-22 08:53:27	2026-09-22 08:53:27	\N
198	1	198	2026-09-22 08:54:15	2026-09-22 08:54:15	\N
199	1	199	2026-09-22 08:54:44	2026-09-22 08:54:44	\N
200	3	200	2026-09-22 08:57:20	2026-09-22 08:57:20	\N
201	3	201	2026-09-22 08:58:36	2026-09-22 08:58:36	\N
202	1	202	2026-09-22 08:58:58	2026-09-22 08:58:58	\N
203	1	203	2026-09-22 09:00:42	2026-09-22 09:00:42	\N
204	1	204	2026-09-22 09:01:35	2026-09-22 09:01:35	\N
205	1	205	2026-09-24 05:52:27	2026-09-24 05:52:27	\N
206	1	206	2026-09-24 05:52:29	2026-09-24 05:52:29	\N
207	3	207	2026-09-24 16:12:17	2026-09-24 16:12:17	\N
208	1	208	2026-09-24 16:23:19	2026-09-24 16:23:19	\N
209	1	209	2026-09-24 16:23:24	2026-09-24 16:23:24	\N
210	3	210	2026-09-24 16:32:38	2026-09-24 16:32:38	\N
211	3	211	2026-09-24 16:36:52	2026-09-24 16:36:52	\N
212	1	212	2026-09-27 11:05:31	2026-09-27 11:05:31	\N
213	1	213	2026-09-27 11:05:42	2026-09-27 11:05:42	\N
214	1	214	2026-09-27 11:12:44	2026-09-27 11:12:44	\N
215	1	215	2026-09-27 11:14:53	2026-09-27 11:14:53	\N
216	4	216	2026-09-29 22:35:01	2026-09-29 22:35:01	\N
217	1	217	2026-09-29 22:36:54	2026-09-29 22:36:54	\N
218	5	218	2026-09-29 22:37:51	2026-09-29 22:37:51	\N
219	1	219	2026-09-30 11:32:30	2026-09-30 11:32:30	\N
220	1	220	2026-09-30 11:38:28	2026-09-30 11:38:28	\N
221	1	221	2026-09-30 12:24:44	2026-09-30 12:24:44	\N
222	1	222	2026-10-09 01:12:56	2026-10-09 01:12:56	\N
223	1	223	2026-10-09 01:13:48	2026-10-09 01:13:48	\N
224	1	224	2026-10-09 01:13:59	2026-10-09 01:13:59	\N
225	1	225	2026-10-09 19:56:49	2026-10-09 19:56:49	\N
226	1	226	2026-10-09 19:59:08	2026-10-09 19:59:08	\N
227	1	227	2026-10-11 22:47:56	2026-10-11 22:47:56	\N
228	3	228	2026-10-13 12:29:58	2026-10-13 12:29:58	\N
229	1	229	2026-10-15 14:23:15	2026-10-15 14:23:15	\N
230	3	230	2026-10-17 12:34:58	2026-10-17 12:34:58	\N
231	6	231	2026-10-17 13:52:00	2026-10-17 13:52:00	\N
232	1	232	2026-10-17 13:55:06	2026-10-17 13:55:06	\N
233	5	233	2026-10-18 16:42:54	2026-10-18 16:42:54	\N
234	1	234	2026-10-19 18:22:10	2026-10-19 18:22:10	\N
235	1	235	2026-10-19 18:28:26	2026-10-19 18:28:26	\N
236	1	236	2026-10-19 18:28:48	2026-10-19 18:28:48	\N
237	5	237	2026-10-19 18:33:24	2026-10-19 18:33:24	\N
238	1	238	2026-10-19 18:34:36	2026-10-19 18:34:36	\N
239	1	239	2026-10-19 18:35:22	2026-10-19 18:35:22	\N
240	1	240	2026-10-20 20:47:47	2026-10-20 20:47:47	\N
241	1	241	2026-10-20 20:48:28	2026-10-20 20:48:28	\N
242	1	242	2026-10-20 20:50:50	2026-10-20 20:50:50	\N
243	4	243	2026-10-20 20:52:13	2026-10-20 20:52:13	\N
244	3	244	2026-10-22 14:47:26	2026-10-22 14:47:26	\N
245	1	245	2026-10-22 14:49:27	2026-10-22 14:49:27	\N
246	1	246	2026-10-22 14:49:29	2026-10-22 14:49:29	\N
247	1	247	2026-10-22 14:58:07	2026-10-22 14:58:07	\N
248	1	248	2026-10-22 17:42:04	2026-10-22 17:42:04	\N
249	1	249	2026-10-22 17:44:12	2026-10-22 17:44:12	\N
250	1	250	2026-10-23 01:00:58	2026-10-23 01:00:58	\N
251	1	251	2026-10-23 01:02:45	2026-10-23 01:02:45	\N
252	1	252	2026-10-23 12:07:50	2026-10-23 12:07:50	\N
253	1	253	2026-10-23 12:10:52	2026-10-23 12:10:52	\N
254	1	254	2026-10-23 16:48:58	2026-10-23 16:48:58	\N
255	1	255	2026-10-23 16:49:29	2026-10-23 16:49:29	\N
256	1	256	2026-10-23 16:54:22	2026-10-23 16:54:22	\N
257	1	257	2026-10-23 16:55:13	2026-10-23 16:55:13	\N
258	1	258	2026-10-23 16:56:08	2026-10-23 16:56:08	\N
259	1	259	2026-10-23 16:56:31	2026-10-23 16:56:31	\N
260	1	260	2026-10-23 17:03:21	2026-10-23 17:03:21	\N
261	1	261	2026-10-24 19:48:34	2026-10-24 19:48:34	\N
262	1	262	2026-10-25 08:49:20	2026-10-25 08:49:20	\N
263	1	263	2026-10-25 08:49:31	2026-10-25 08:49:31	\N
264	1	264	2026-10-25 08:52:54	2026-10-25 08:52:54	\N
265	1	265	2026-10-25 08:53:06	2026-10-25 08:53:06	\N
266	1	266	2026-10-25 08:55:22	2026-10-25 08:55:22	\N
267	1	267	2026-10-25 08:55:45	2026-10-25 08:55:45	\N
268	1	268	2026-10-25 09:01:02	2026-10-25 09:01:02	\N
269	1	269	2026-10-25 09:01:28	2026-10-25 09:01:28	\N
270	1	270	2026-10-25 09:03:12	2026-10-25 09:03:12	\N
271	1	271	2026-10-25 09:05:20	2026-10-25 09:05:20	\N
272	1	272	2026-10-25 09:05:41	2026-10-25 09:05:41	\N
273	1	273	2026-10-25 09:05:52	2026-10-25 09:05:52	\N
274	1	274	2026-10-25 09:06:08	2026-10-25 09:06:08	\N
275	1	275	2026-10-25 09:06:52	2026-10-25 09:06:52	\N
276	1	276	2026-10-25 09:07:09	2026-10-25 09:07:09	\N
277	1	277	2026-10-25 09:07:21	2026-10-25 09:07:21	\N
278	1	278	2026-10-25 09:07:32	2026-10-25 09:07:32	\N
279	1	279	2026-10-25 09:08:50	2026-10-25 09:08:50	\N
280	1	280	2026-10-25 09:08:59	2026-10-25 09:08:59	\N
281	1	281	2026-10-25 09:09:09	2026-10-25 09:09:09	\N
282	1	282	2026-10-25 09:14:38	2026-10-25 09:14:38	\N
283	1	283	2026-10-25 09:15:20	2026-10-25 09:15:20	\N
284	3	284	2026-10-25 14:06:01	2026-10-25 14:06:01	\N
285	1	285	2026-10-25 14:08:25	2026-10-25 14:08:25	\N
286	1	286	2026-10-25 14:09:23	2026-10-25 14:09:23	\N
287	1	287	2026-10-25 14:09:59	2026-10-25 14:09:59	\N
288	1	288	2026-10-25 14:10:21	2026-10-25 14:10:21	\N
289	1	289	2026-10-30 05:59:07	2026-10-30 05:59:07	\N
290	1	290	2026-10-30 05:59:29	2026-10-30 05:59:29	\N
291	1	291	2026-10-30 13:10:09	2026-10-30 13:10:09	\N
292	1	292	2026-10-30 18:11:26	2026-10-30 18:11:26	\N
293	1	293	2026-10-30 18:15:23	2026-10-30 18:15:23	\N
294	1	294	2026-10-30 18:16:40	2026-10-30 18:16:40	\N
295	3	295	2026-10-31 02:54:47	2026-10-31 02:54:47	\N
296	3	296	2026-10-31 03:20:13	2026-10-31 03:20:13	\N
297	3	297	2026-10-31 03:20:16	2026-10-31 03:20:16	\N
298	3	298	2026-10-31 03:42:03	2026-10-31 03:42:03	\N
299	3	299	2026-10-31 11:45:23	2026-10-31 11:45:23	\N
300	1	300	2026-11-01 07:51:57	2026-11-01 07:51:57	\N
301	1	301	2026-11-01 07:54:23	2026-11-01 07:54:23	\N
302	1	302	2026-11-05 07:18:20	2026-11-05 07:18:20	\N
303	4	303	2026-11-06 12:02:51	2026-11-06 12:02:51	\N
304	1	304	2026-11-06 12:10:15	2026-11-06 12:10:15	\N
305	5	305	2026-11-06 12:12:59	2026-11-06 12:12:59	\N
306	1	306	2026-11-06 12:14:44	2026-11-06 12:14:44	\N
307	1	307	2026-11-06 12:16:54	2026-11-06 12:16:54	\N
308	1	308	2026-11-07 01:28:56	2026-11-07 01:28:56	\N
309	1	309	2026-11-09 19:09:37	2026-11-09 19:09:37	\N
310	1	310	2026-11-11 19:00:22	2026-11-11 19:00:22	\N
311	1	311	2026-11-11 19:00:35	2026-11-11 19:00:35	\N
312	1	312	2026-11-11 19:34:28	2026-11-11 19:34:28	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.users (id, name, nickname, phone1, has_whatsapp, phone2, email, password, postal_code, address, number, complement, neighborhood, city, state, country, country_code, state_code, recovery_key, first_access, last_access, bio, website, access_count, receive_newsletter, active, created_at, updated_at, deleted_at, birth_date, userscol, photo, cover_photo, google_id, facebook_id, auth_provider, email_verified, verified_profile) FROM stdin;
5	João Batista	\N	\N	f	\N	joaobatista@gmail.com	$2y$10$hAYqKqf6Kn98R.fbT6th6OvqJy7AkNg5wbI5NgA1k9KIzsn3BFQcO	13051257	Rua Walmir Jose	232	\N	\N		São Paulo	Brazil	BR	SP	\N	2026-06-23 01:57:01	\N	\N	\N	\N	f	t	2026-06-23 01:57:01	2026-06-23 01:57:18	\N	1981-11-13 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_jo%C3%A3obatista/2091435885sol.jpeg	\N	\N	\N	local	t	f
2	Calebe Andrade	\N	\N	f	\N	calebe@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	13392-350	teste	5656	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-03-02 23:45:12	\N	Meu site www.calebe.com.br	\N	\N	f	t	2026-03-02 23:45:12	2026-03-02 23:55:28	\N	2026-03-02 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_calebeandrade/1650059618eu3.jpg	https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebeandrade/684454171capasound.jpg	\N	\N	local	t	f
3	Thor Tron	\N	\N	f	\N	thor@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	13392-350	teste	265	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-03-02 23:48:07	\N	www.thor.com.br	www.mixcloud.com/starprojectt	\N	f	t	2026-03-02 23:48:07	2026-03-02 23:48:14	\N	2026-03-02 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_thortron/1578230748euuu.jpg	\N	\N	\N	local	t	f
4	Mara Dias	\N	\N	f	\N	maradias@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	11851252	Rua Walmir Jose Peres	5454	\N	\N	Assunção do Piauí	Piauí	Brazil	BR	PI	\N	2026-03-10 19:48:26	\N	Jupiter ⚫	www.maradias.com.br	\N	f	t	2026-03-10 19:48:27	2026-06-03 23:00:14	\N	2026-03-04 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/58b126c625581c7d0ea3f8472de5303e_maradias/1394953472mandalaart.jpg	\N	\N	\N	local	t	f
6	Maria de Lourdes	\N	\N	f	\N	maria@gmail.com	$2y$10$GWZvzXRHniFT8D1MkC5KLu6yIrZEQtDy1P/Fm5zFjt/U.QweoqWHy	13051251	Rua Walmir Jose Peres	3232	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-10-17 16:49:52	\N	\N	\N	\N	f	t	2026-10-17 16:49:52	2026-10-17 16:50:13	\N	1990-09-17 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_hedreiandrade/1996881435nicepsy.jpg	\N	\N	\N	local	t	f
1	Hedrei Andrade	\N	\N	f	\N	hedreiandrade@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	13051251	teste	989	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-02-28 01:13:41	2026-09-19 21:05:46	www.youtube.com/@starprojectt	www.github.com/hedreiandrade	6	f	t	2026-02-28 01:13:41	2026-10-30 21:16:25	\N	1988-05-07 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_hedreiandrade/35275069ha.jpg	https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/1776643368capayoutube.jpg	\N	\N	local	t	t
\.


--
-- Name: block_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.block_user_id_seq', 113, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.comments_id_seq', 129, true);


--
-- Name: followers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.followers_id_seq', 45, true);


--
-- Name: likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.likes_id_seq', 118, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.posts_id_seq', 312, true);


--
-- Name: posts_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.posts_users_id_seq', 312, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: block_users block_user_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.block_users
    ADD CONSTRAINT block_user_pkey PRIMARY KEY (id);


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
-- Name: block_users uq_block_user_pair; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.block_users
    ADD CONSTRAINT uq_block_user_pair UNIQUE (user_id_bu, user_block_id_bu);


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
-- Name: idx_block_user_deleted_at; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_block_user_deleted_at ON public.block_users USING btree (deleted_at);


--
-- Name: idx_block_user_user_block_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_block_user_user_block_id ON public.block_users USING btree (user_block_id_bu);


--
-- Name: idx_block_user_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_block_user_user_id ON public.block_users USING btree (user_id_bu);


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
-- Name: block_users fk_block_user_user; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.block_users
    ADD CONSTRAINT fk_block_user_user FOREIGN KEY (user_id_bu) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: block_users fk_block_user_user_block; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.block_users
    ADD CONSTRAINT fk_block_user_user_block FOREIGN KEY (user_block_id_bu) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


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

\unrestrict yLOX4ff39zxrrugmnQd7Ky1YXoaaBpDsRVPcdW0IAk4XSKhdozV3qVTeBjhCqMR

