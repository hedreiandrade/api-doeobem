--
-- PostgreSQL database dump
--

\restrict 111K1dNZ6M48NFMKWCrBVk9qv5vSzP7gs6cU061xWb5dVcu47mfR1Oh2YIJUV1a

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
9	90	1	Demais!	2026-06-10 19:21:32	2026-06-10 22:27:38	2026-06-10 22:27:38
10	7	1	Massa!	2026-06-10 19:27:49	2026-06-10 22:27:51	2026-06-10 22:27:51
11	90	1	Lindo!	2026-06-10 19:36:31	2026-06-10 22:40:09	2026-06-10 22:40:09
12	90	1	Lindo!	2026-06-10 19:42:24	2026-06-10 22:44:20	2026-06-10 22:44:20
13	90	1	Lindo	2026-06-10 19:46:50	2026-06-10 19:46:50	\N
14	110	1	teste veritical video	2026-06-15 17:39:34	2026-06-15 17:39:34	\N
15	110	3	Demais!	2026-06-15 19:56:20	2026-06-15 19:56:20	\N
16	112	1	trste	2026-06-28 10:23:17	2026-06-28 13:23:28	2026-06-28 13:23:28
22	128	1	6	2026-06-28 18:56:09	2026-06-28 21:56:12	2026-06-28 21:56:12
21	128	1	5	2026-06-28 18:56:05	2026-06-28 21:56:12	2026-06-28 21:56:12
20	128	1	4	2026-06-28 18:56:01	2026-06-28 21:56:13	2026-06-28 21:56:13
19	128	1	3	2026-06-28 18:55:26	2026-06-28 21:56:14	2026-06-28 21:56:14
18	128	1	2	2026-06-28 18:55:19	2026-06-28 21:56:15	2026-06-28 21:56:15
17	128	1	1	2026-06-28 18:55:18	2026-06-28 21:56:16	2026-06-28 21:56:16
28	128	1	6	2026-06-28 18:56:59	2026-06-28 21:57:59	2026-06-28 21:57:59
27	128	1	5	2026-06-28 18:56:53	2026-06-28 21:58:00	2026-06-28 21:58:00
25	128	1	3	2026-06-28 18:56:50	2026-06-28 21:58:01	2026-06-28 21:58:01
24	128	1	2	2026-06-28 18:56:48	2026-06-28 21:58:01	2026-06-28 21:58:01
23	128	1	1	2026-06-28 18:56:44	2026-06-28 21:58:03	2026-06-28 21:58:03
26	128	1	4	2026-06-28 18:56:51	2026-06-28 21:58:03	2026-06-28 21:58:03
29	128	1	1	2026-06-28 18:58:11	2026-06-28 18:58:11	\N
30	128	1	2	2026-06-28 18:58:13	2026-06-28 18:58:13	\N
31	128	1	3	2026-06-28 18:58:14	2026-06-28 18:58:14	\N
32	128	1	4	2026-06-28 18:58:19	2026-06-28 18:58:19	\N
33	128	1	5	2026-06-28 18:58:21	2026-06-28 18:58:21	\N
34	128	1	6	2026-06-28 18:58:24	2026-06-28 18:58:24	\N
35	12	1	teste	2026-06-28 19:35:54	2026-06-28 22:35:56	2026-06-28 22:35:56
36	111	1	Demais!	2026-06-29 11:33:55	2026-06-29 11:33:55	\N
37	135	1	Amei!	2026-06-29 11:34:41	2026-06-29 11:34:41	\N
38	143	1	teste	2026-07-10 20:21:09	2026-07-10 23:21:10	2026-07-10 23:21:10
39	153	3	Demais!	2026-07-30 23:54:10	2026-07-30 23:54:10	\N
40	151	3	Lindo!	2026-07-30 23:54:49	2026-07-30 23:54:49	\N
41	153	2	Top!	2026-07-31 00:23:20	2026-07-31 00:23:20	\N
42	159	1	Demais 💚	2026-08-09 00:39:59	2026-08-09 00:39:59	\N
43	12	1	Olá!	2026-08-09 00:53:55	2026-08-09 00:53:55	\N
44	185	1	Opa!	2026-08-09 01:25:33	2026-08-09 01:25:33	\N
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
18	4	1	2026-06-10 22:15:16	2026-06-10 22:22:18	2026-06-10 22:22:18
19	4	1	2026-06-10 22:22:24	2026-06-10 22:28:02	2026-06-10 22:28:02
20	4	1	2026-06-10 22:28:12	2026-06-10 22:38:17	2026-06-10 22:38:17
21	4	1	2026-06-10 22:38:24	2026-06-10 22:41:24	2026-06-10 22:41:24
22	4	1	2026-06-10 22:41:31	2026-06-10 22:45:12	2026-06-10 22:45:12
23	4	1	2026-06-10 22:45:20	2026-06-10 22:45:20	\N
24	1	4	2026-06-11 09:10:15	2026-06-11 09:10:15	\N
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
9	6	1	2026-03-22 21:51:54	2026-03-22 21:51:54	\N
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
54	12	1	2026-08-09 03:53:51	2026-08-09 03:53:51	\N
55	185	1	2026-08-09 04:25:27	2026-08-09 04:25:27	\N
56	160	1	2026-08-09 04:25:39	2026-08-09 04:25:39	\N
57	187	1	2026-08-10 21:10:56	2026-08-10 21:10:56	\N
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.posts (id, description, media_link, created_at, updated_at, deleted_at, is_repost, original_post_id, original_user_id, music_link) FROM stdin;
142	teste		2026-07-02 19:32:27	2026-07-02 19:32:27	\N	f	\N	\N	\N
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
151	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6bf4dcc4cb02.47940315.jpeg	2026-07-30 22:05:34	2026-07-30 22:05:34	\N	f	\N	\N	\N
121	teste		2026-06-28 10:26:43	2026-06-28 13:27:09	2026-06-28 13:27:09	t	112	5	\N
152	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a6c0c515f3005.94560582.mp4	2026-07-30 23:45:41	2026-07-30 23:45:41	\N	f	\N	\N	\N
122	teste		2026-06-28 10:27:33	2026-06-28 13:27:50	2026-06-28 13:27:50	t	112	5	\N
153	❤💓	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a6c0e2a63ad86.95155625.mp4	2026-07-30 23:53:33	2026-07-30 23:53:33	\N	f	\N	\N	\N
124	teste		2026-06-28 18:52:57	2026-06-28 21:52:59	2026-06-28 21:52:59	t	123	5	\N
123	teste		2026-06-28 18:52:49	2026-06-28 21:52:59	2026-06-28 21:52:59	t	112	5	\N
154	teste		2026-07-31 00:05:32	2026-07-31 03:07:00	2026-07-31 03:07:00	f	\N	\N	\N
125	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a308334204ea4.65970375.mp4	2026-06-28 18:53:06	2026-06-28 21:53:33	2026-06-28 21:53:33	t	111	3	\N
126	teste		2026-06-28 18:53:41	2026-06-28 21:53:57	2026-06-28 21:53:57	t	112	5	\N
155	teste		2026-07-31 00:07:08	2026-07-31 03:07:14	2026-07-31 03:07:14	f	\N	\N	\N
127	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a308334204ea4.65970375.mp4	2026-06-28 18:54:00	2026-06-28 21:54:13	2026-06-28 21:54:13	t	111	3	\N
156		https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a6c12fe84da02.90567172.mp4	2026-07-31 00:14:19	2026-07-31 00:14:19	\N	f	\N	\N	\N
128	teste		2026-06-28 18:55:13	2026-06-28 21:58:45	2026-06-28 21:58:45	t	112	5	\N
129	haha	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a30601c863e72.26472188.mp4	2026-06-28 19:07:47	2026-06-28 22:07:55	2026-06-28 22:07:55	t	110	1	\N
157	teste		2026-07-31 00:24:48	2026-07-31 03:24:49	2026-07-31 03:24:49	f	\N	\N	\N
130	haha	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a30601c863e72.26472188.mp4	2026-06-28 19:09:27	2026-06-28 22:11:10	2026-06-28 22:11:10	t	110	1	\N
110	haha	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a30601c863e72.26472188.mp4	2026-06-15 17:28:09	2026-06-28 22:11:13	2026-06-28 22:11:13	f	\N	\N	\N
131	MVP da H Media 💙	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69a620913354d6.86533246.mp4	2026-06-28 19:11:20	2026-06-28 22:12:21	2026-06-28 22:12:21	t	2	1	\N
161	teste		2026-08-08 23:42:41	2026-08-09 02:50:47	2026-08-09 02:50:47	f	\N	\N	\N
132	teste		2026-06-28 19:12:24	2026-06-28 22:12:35	2026-06-28 22:12:35	t	112	5	\N
133	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a419d4e721c53.71307569.mp4	2026-06-28 19:16:54	2026-06-28 19:16:54	\N	f	\N	\N	\N
112	teste		2026-06-22 22:58:41	2026-06-28 22:18:35	2026-06-28 22:18:35	f	\N	\N	\N
135	Trabalhando na rede social 🤍	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_jo%C3%A3obatista/media_6a419df34f28f3.20121899.jpg	2026-06-28 19:19:32	2026-06-28 19:19:32	\N	f	\N	\N	\N
136	Legal 	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a419d970e3b45.60192054.mp4	2026-06-28 19:41:00	2026-06-28 22:41:07	2026-06-28 22:41:07	t	134	1	\N
134	Legal 	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a419d970e3b45.60192054.mp4	2026-06-28 19:18:01	2026-06-28 22:44:13	2026-06-28 22:44:13	f	\N	\N	\N
137	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_maradias/media_6a2a7b631c1723.72180230.mp4	2026-06-29 11:34:07	2026-06-29 14:34:24	2026-06-29 14:34:24	t	109	4	\N
139	teste		2026-06-29 11:35:21	2026-06-29 14:35:25	2026-06-29 14:35:25	f	\N	\N	\N
140	teste		2026-06-29 11:38:52	2026-06-29 14:38:54	2026-06-29 14:38:54	f	\N	\N	\N
141	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a308334204ea4.65970375.mp4	2026-06-29 11:39:09	2026-06-29 14:39:14	2026-06-29 14:39:14	t	111	3	\N
158	teste	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebeandrade/media_6a6c158bce6fd3.18283327.jpg	2026-07-31 00:25:01	2026-07-31 03:25:06	2026-07-31 03:25:06	f	\N	\N	\N
160	Studio time !	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6c16526ebd44.97891671.mp4	2026-07-31 00:28:23	2026-07-31 00:28:23	\N	f	\N	\N	\N
159	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebeandrade/media_6a6c15af9bdc47.01220479.mp4	2026-07-31 00:25:37	2026-08-09 04:19:25	2026-08-09 04:19:25	f	\N	\N	\N
162	teste		2026-08-08 23:51:06	2026-08-09 03:02:47	2026-08-09 03:02:47	f	\N	\N	\N
163	teste		2026-08-09 00:02:56	2026-08-09 03:03:00	2026-08-09 03:03:00	f	\N	\N	\N
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
186	Studio time !	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_thortron/media_6a6c16526ebd44.97891671.mp4	2026-08-09 01:25:48	2026-08-09 01:25:48	\N	t	160	3	\N
187	🖤	https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6a7801b3ef1c65.55553091.jpg	2026-08-09 01:27:40	2026-08-09 01:27:40	\N	f	\N	\N	\N
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
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.users (id, name, nickname, phone1, has_whatsapp, phone2, email, password, postal_code, address, number, complement, neighborhood, city, state, country, country_code, state_code, recovery_key, first_access, last_access, bio, website, access_count, receive_newsletter, active, created_at, updated_at, deleted_at, birth_date, userscol, photo, cover_photo, google_id, facebook_id, auth_provider, email_verified, verified_profile) FROM stdin;
5	João Batista	\N	\N	f	\N	joaobatista@gmail.com	$2y$10$hAYqKqf6Kn98R.fbT6th6OvqJy7AkNg5wbI5NgA1k9KIzsn3BFQcO	13051257	Rua Walmir Jose	232	\N	\N		São Paulo	Brazil	BR	SP	\N	2026-06-23 01:57:01	\N	\N	\N	\N	f	t	2026-06-23 01:57:01	2026-06-23 01:57:18	\N	1981-11-13 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_jo%C3%A3obatista/2091435885sol.jpeg	\N	\N	\N	local	t	f
2	Calebe Andrade	\N	\N	f	\N	calebe@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	13392-350	teste	5656	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-03-02 23:45:12	\N	Meu site www.calebe.com.br	\N	\N	f	t	2026-03-02 23:45:12	2026-03-02 23:55:28	\N	2026-03-02 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_calebeandrade/1650059618eu3.jpg	https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebeandrade/684454171capasound.jpg	\N	\N	local	t	f
3	Thor Tron	\N	\N	f	\N	thor@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	13392-350	teste	265	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-03-02 23:48:07	\N	www.thor.com.br	www.mixcloud.com/starprojectt	\N	f	t	2026-03-02 23:48:07	2026-03-02 23:48:14	\N	2026-03-02 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_thortron/1578230748euuu.jpg	\N	\N	\N	local	t	f
1	Hedrei Andrade	\N	\N	f	\N	hedreiandrade@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	13051251	teste	989	\N	\N	Campinas	São Paulo	Brazil	BR	SP	\N	2026-02-28 01:13:41	2026-06-05 15:24:48	www.youtube.com/@starprojectt	www.github.com/hedreiandrade	4	f	t	2026-02-28 01:13:41	2026-07-11 00:06:08	\N	1988-05-07 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_hedreiandrade/35275069ha.jpg	https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/506200019capayoutube.jpg	\N	\N	local	t	t
4	Mara Dias	\N	\N	f	\N	maradias@gmail.com	$2y$10$7SBLIUvkpDdC5km.ATdt/.Xw/szkq2IAQ8btjhgTtVsku4t.tPRUq	11851252	Rua Walmir Jose Peres	5454	\N	\N	Assunção do Piauí	Piauí	Brazil	BR	PI	\N	2026-03-10 19:48:26	\N	Jupiter ⚫	www.maradias.com.br	\N	f	t	2026-03-10 19:48:27	2026-06-03 23:00:14	\N	2026-03-04 00:00:00	\N	https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/58b126c625581c7d0ea3f8472de5303e_maradias/1394953472mandalaart.jpg	\N	\N	\N	local	t	f
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.comments_id_seq', 44, true);


--
-- Name: followers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.followers_id_seq', 24, true);


--
-- Name: likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.likes_id_seq', 57, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.posts_id_seq', 187, true);


--
-- Name: posts_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.posts_users_id_seq', 187, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


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

\unrestrict 111K1dNZ6M48NFMKWCrBVk9qv5vSzP7gs6cU061xWb5dVcu47mfR1Oh2YIJUV1a

