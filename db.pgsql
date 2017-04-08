--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: articles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE articles (
    id integer NOT NULL,
    title character varying,
    body text,
    player_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ref_url character varying,
    image_url character varying
);


--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE articles_id_seq OWNED BY articles.id;


--
-- Name: field_owners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE field_owners (
    id integer NOT NULL,
    full_name character varying,
    email character varying,
    password_digest character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_url character varying
);


--
-- Name: field_owners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE field_owners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: field_owners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE field_owners_id_seq OWNED BY field_owners.id;


--
-- Name: fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE fields (
    id integer NOT NULL,
    field_owner_id integer,
    name character varying,
    addr character varying,
    image_url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    venue_id integer,
    latitude double precision,
    longitude double precision
);


--
-- Name: fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fields_id_seq OWNED BY fields.id;


--
-- Name: match_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE match_messages (
    id integer NOT NULL,
    body character varying,
    player_id integer,
    match_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: match_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE match_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: match_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE match_messages_id_seq OWNED BY match_messages.id;


--
-- Name: match_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE match_requests (
    id integer NOT NULL,
    match_id integer,
    team_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    team_received_id integer,
    status character varying DEFAULT 'PENDING'::character varying
);


--
-- Name: match_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE match_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: match_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE match_requests_id_seq OWNED BY match_requests.id;


--
-- Name: match_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE match_results (
    id integer NOT NULL,
    match_id integer,
    win_team_id integer,
    loss_team_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: match_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE match_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: match_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE match_results_id_seq OWNED BY match_results.id;


--
-- Name: matches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE matches (
    id integer NOT NULL,
    team_owner_id integer,
    team_away_id integer,
    field_id integer,
    starts_at timestamp without time zone,
    ends_at timestamp without time zone,
    is_start boolean,
    home_goal integer,
    away_goal integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    venue_id integer,
    is_end boolean
);


--
-- Name: matches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE matches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE matches_id_seq OWNED BY matches.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE notifications (
    id integer NOT NULL,
    notified_by_id integer,
    player_id integer,
    match_id integer,
    team_id integer,
    notice_type character varying,
    notice_messages character varying,
    read boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifications_id_seq OWNED BY notifications.id;


--
-- Name: player_references; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE player_references (
    id integer NOT NULL,
    name character varying,
    club character varying,
    image_url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: player_references_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE player_references_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: player_references_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE player_references_id_seq OWNED BY player_references.id;


--
-- Name: player_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE player_results (
    id integer NOT NULL,
    match_id integer,
    player_id integer,
    goal integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    verify_status boolean
);


--
-- Name: player_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE player_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: player_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE player_results_id_seq OWNED BY player_results.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE players (
    id integer NOT NULL,
    team_id integer,
    full_name character varying,
    email character varying,
    password_digest character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_url character varying,
    nickname character varying,
    favorite_player character varying,
    favorite_team character varying,
    goal integer,
    games_played integer
);


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE players_id_seq OWNED BY players.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: team_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE team_messages (
    id integer NOT NULL,
    body character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    team_id integer,
    player_id character varying
);


--
-- Name: team_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE team_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE team_messages_id_seq OWNED BY team_messages.id;


--
-- Name: team_owners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE team_owners (
    id integer NOT NULL,
    player_id integer,
    team_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: team_owners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE team_owners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_owners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE team_owners_id_seq OWNED BY team_owners.id;


--
-- Name: team_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE team_requests (
    id integer NOT NULL,
    player_id integer,
    team_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    kind character varying
);


--
-- Name: team_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE team_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE team_requests_id_seq OWNED BY team_requests.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teams (
    id integer NOT NULL,
    team_owner_id integer,
    name character varying,
    points integer DEFAULT 1000,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_url character varying
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;


--
-- Name: venues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE venues (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: venues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE venues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: venues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE venues_id_seq OWNED BY venues.id;


--
-- Name: world_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE world_messages (
    id integer NOT NULL,
    player_id integer,
    body character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: world_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE world_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: world_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE world_messages_id_seq OWNED BY world_messages.id;


--
-- Name: articles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY articles ALTER COLUMN id SET DEFAULT nextval('articles_id_seq'::regclass);


--
-- Name: field_owners id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY field_owners ALTER COLUMN id SET DEFAULT nextval('field_owners_id_seq'::regclass);


--
-- Name: fields id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fields ALTER COLUMN id SET DEFAULT nextval('fields_id_seq'::regclass);


--
-- Name: match_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY match_messages ALTER COLUMN id SET DEFAULT nextval('match_messages_id_seq'::regclass);


--
-- Name: match_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY match_requests ALTER COLUMN id SET DEFAULT nextval('match_requests_id_seq'::regclass);


--
-- Name: match_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY match_results ALTER COLUMN id SET DEFAULT nextval('match_results_id_seq'::regclass);


--
-- Name: matches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY matches ALTER COLUMN id SET DEFAULT nextval('matches_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifications ALTER COLUMN id SET DEFAULT nextval('notifications_id_seq'::regclass);


--
-- Name: player_references id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY player_references ALTER COLUMN id SET DEFAULT nextval('player_references_id_seq'::regclass);


--
-- Name: player_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY player_results ALTER COLUMN id SET DEFAULT nextval('player_results_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY players ALTER COLUMN id SET DEFAULT nextval('players_id_seq'::regclass);


--
-- Name: team_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY team_messages ALTER COLUMN id SET DEFAULT nextval('team_messages_id_seq'::regclass);


--
-- Name: team_owners id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY team_owners ALTER COLUMN id SET DEFAULT nextval('team_owners_id_seq'::regclass);


--
-- Name: team_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY team_requests ALTER COLUMN id SET DEFAULT nextval('team_requests_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Name: venues id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY venues ALTER COLUMN id SET DEFAULT nextval('venues_id_seq'::regclass);


--
-- Name: world_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY world_messages ALTER COLUMN id SET DEFAULT nextval('world_messages_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: -
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2017-04-05 11:21:10.222926	2017-04-05 11:21:10.222926
\.


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY articles (id, title, body, player_id, created_at, updated_at, ref_url, image_url) FROM stdin;
\.


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('articles_id_seq', 1, false);


--
-- Data for Name: field_owners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY field_owners (id, full_name, email, password_digest, created_at, updated_at, image_url) FROM stdin;
1	Vito Corleone	vito@gmail.com	$2a$10$5Q6hWT3g9DxR4lmft6sfJut7TTO0LjMcjeFgvD.T8KkGGYaLvoEui	2017-04-05 12:32:04.724923	2017-04-05 12:32:04.724923	deniro.jpg
\.


--
-- Name: field_owners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('field_owners_id_seq', 1, true);


--
-- Data for Name: fields; Type: TABLE DATA; Schema: public; Owner: -
--

COPY fields (id, field_owner_id, name, addr, image_url, created_at, updated_at, venue_id, latitude, longitude) FROM stdin;
1	1	Vincom	26 Ly Tu Trong	\N	2017-04-05 18:11:05.556919	2017-04-05 18:11:05.556919	1	10.7782461999999999	106.701035899999994
2	1	Mega Mall	159 Xa lo Ha Noi	\N	2017-04-05 18:11:53.277554	2017-04-05 18:11:53.277554	2	10.8170436999999993	106.757853499999996
3	1	Diamond	34 Le Duan	\N	2017-04-05 18:12:10.159559	2017-04-05 18:12:10.159559	1	10.7813330999999994	106.698582400000006
\.


--
-- Name: fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('fields_id_seq', 3, true);


--
-- Data for Name: match_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY match_messages (id, body, player_id, match_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: match_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('match_messages_id_seq', 1, false);


--
-- Data for Name: match_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY match_requests (id, match_id, team_id, created_at, updated_at, team_received_id, status) FROM stdin;
\.


--
-- Name: match_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('match_requests_id_seq', 1, false);


--
-- Data for Name: match_results; Type: TABLE DATA; Schema: public; Owner: -
--

COPY match_results (id, match_id, win_team_id, loss_team_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: match_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('match_results_id_seq', 1, false);


--
-- Data for Name: matches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY matches (id, team_owner_id, team_away_id, field_id, starts_at, ends_at, is_start, home_goal, away_goal, created_at, updated_at, venue_id, is_end) FROM stdin;
\.


--
-- Name: matches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('matches_id_seq', 1, false);


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY notifications (id, notified_by_id, player_id, match_id, team_id, notice_type, notice_messages, read, created_at, updated_at) FROM stdin;
1	1	14	\N	1	team_request_invite	Team: Real Madrid has sent invite request <br>to you(S. Ramos)	f	2017-04-05 16:15:47.279437	2017-04-05 16:15:47.279437
2	1	4	\N	1	team_request_invite	Team: Real Madrid has sent invite request <br>to you(Marcelo)	f	2017-04-05 16:15:50.455404	2017-04-05 16:15:50.455404
3	1	13	\N	1	team_request_invite	Team: Real Madrid has sent invite request <br>to you(K. Benzema)	f	2017-04-05 16:15:53.307107	2017-04-05 16:15:53.307107
4	1	2	\N	1	team_request_invite	Team: Real Madrid has sent invite request <br>to you(L. Modric)	f	2017-04-05 16:16:02.03658	2017-04-05 16:16:02.03658
5	1	5	\N	1	team_request_invite	Team: Real Madrid has sent invite request <br>to you(C. Ronaldo)	f	2017-04-05 16:16:17.855311	2017-04-05 16:16:17.855311
6	1	3	\N	1	team_request_invite	Team: Real Madrid has sent invite request <br>to you(G. Bale)	t	2017-04-05 16:16:20.360095	2017-04-05 16:43:33.439106
9	4	1	\N	1	team_request_accept_invite	Player: Marcelo has accepted <br>your invitation to join your team(Real Madrid)	f	2017-04-05 16:45:19.186945	2017-04-05 16:45:19.186945
10	14	1	\N	1	team_request_accept_invite	Player: S. Ramos has accepted <br>your invitation to join your team(Real Madrid)	f	2017-04-05 16:45:39.228962	2017-04-05 16:45:39.228962
7	2	1	\N	1	team_request_accept_invite	Player: L. Modric has accepted <br>your invitation to join your team(Real Madrid)	t	2017-04-05 16:44:18.513125	2017-04-05 16:46:20.415524
8	5	1	\N	1	team_request_accept_invite	Player: C. Ronaldo has accepted <br>your invitation to join your team(Real Madrid)	t	2017-04-05 16:44:44.497268	2017-04-05 16:46:44.765114
11	10	7	\N	2	team_request_invite	Team: FC Barcelona has sent invite request <br>to you(L. Messi)	f	2017-04-05 16:51:15.44523	2017-04-05 16:51:15.44523
12	10	11	\N	2	team_request_invite	Team: FC Barcelona has sent invite request <br>to you(Ronaldinho)	f	2017-04-05 16:51:23.595558	2017-04-05 16:51:23.595558
13	10	8	\N	2	team_request_invite	Team: FC Barcelona has sent invite request <br>to you(V. Valdes)	f	2017-04-05 16:51:27.627101	2017-04-05 16:51:27.627101
14	10	9	\N	2	team_request_invite	Team: FC Barcelona has sent invite request <br>to you(G. Pique)	f	2017-04-05 16:51:32.066649	2017-04-05 16:51:32.066649
15	8	10	\N	2	team_request_accept_invite	Player: V. Valdes has accepted <br>your invitation to join your team(FC Barcelona)	f	2017-04-05 16:52:13.165846	2017-04-05 16:52:13.165846
16	11	10	\N	2	team_request_accept_invite	Player: Ronaldinho has accepted <br>your invitation to join your team(FC Barcelona)	f	2017-04-05 16:52:31.554474	2017-04-05 16:52:31.554474
17	7	10	\N	2	team_request_accept_invite	Player: L. Messi has accepted <br>your invitation to join your team(FC Barcelona)	f	2017-04-05 16:52:52.699399	2017-04-05 16:52:52.699399
18	9	10	\N	2	team_request_accept_invite	Player: G. Pique has accepted <br>your invitation to join your team(FC Barcelona)	f	2017-04-05 16:53:16.849525	2017-04-05 16:53:16.849525
19	18	15	\N	3	team_request_request	Player: T. Courtois has sent request request <br>to your team (Chelsea F.C.)	t	2017-04-05 17:08:34.331463	2017-04-05 17:08:40.736066
20	15	18	\N	3	team_request_accept_request	Team: Chelsea F.C. has accepted <br>your request(T. Courtois) to join their team	f	2017-04-05 17:08:46.432953	2017-04-05 17:08:46.432953
23	15	20	\N	3	team_request_accept_request	Team: Chelsea F.C. has accepted <br>your request(C. Fabregas) to join their team	f	2017-04-05 17:13:35.582356	2017-04-05 17:13:35.582356
24	15	19	\N	3	team_request_accept_request	Team: Chelsea F.C. has accepted <br>your request(D. Costa) to join their team	f	2017-04-05 17:13:37.676833	2017-04-05 17:13:37.676833
26	15	21	\N	3	team_request_accept_request	Team: Chelsea F.C. has accepted <br>your request(D. Luiz) to join their team	f	2017-04-05 17:18:02.032881	2017-04-05 17:18:02.032881
21	19	15	\N	3	team_request_request	Player: D. Costa has sent request request <br>to your team (Chelsea F.C.)	t	2017-04-05 17:10:15.078094	2017-04-05 17:21:27.126018
22	20	15	\N	3	team_request_request	Player: C. Fabregas has sent request request <br>to your team (Chelsea F.C.)	t	2017-04-05 17:12:27.785244	2017-04-05 17:21:35.183436
25	21	15	\N	3	team_request_request	Player: D. Luiz has sent request request <br>to your team (Chelsea F.C.)	t	2017-04-05 17:16:18.974548	2017-04-05 17:21:37.970806
27	23	22	\N	4	team_request_request	Player: J. Hart has sent request request <br>to your team (Manchester City F.C.)	f	2017-04-05 17:29:01.088904	2017-04-05 17:29:01.088904
28	24	22	\N	4	team_request_request	Player: S. Aguero has sent request request <br>to your team (Manchester City F.C.)	f	2017-04-05 17:30:34.02064	2017-04-05 17:30:34.02064
29	22	23	\N	4	team_request_accept_request	Team: Manchester City F.C. has accepted <br>your request(J. Hart) to join their team	f	2017-04-05 17:31:13.707703	2017-04-05 17:31:13.707703
30	22	24	\N	4	team_request_accept_request	Team: Manchester City F.C. has accepted <br>your request(S. Aguero) to join their team	f	2017-04-05 17:31:18.790518	2017-04-05 17:31:18.790518
31	25	22	\N	4	team_request_request	Player: V. Kompany has sent request request <br>to your team (Manchester City F.C.)	f	2017-04-05 17:35:45.110511	2017-04-05 17:35:45.110511
32	22	25	\N	4	team_request_accept_request	Team: Manchester City F.C. has accepted <br>your request(V. Kompany) to join their team	f	2017-04-05 17:37:25.447123	2017-04-05 17:37:25.447123
33	26	22	\N	4	team_request_request	Player: K. Bruyne has sent request request <br>to your team (Manchester City F.C.)	f	2017-04-05 17:41:23.990023	2017-04-05 17:41:23.990023
34	22	26	\N	4	team_request_accept_request	Team: Manchester City F.C. has accepted <br>your request(K. Bruyne) to join their team	f	2017-04-05 17:41:45.918913	2017-04-05 17:41:45.918913
36	29	27	\N	5	team_request_request	Player: G. Chiellini  has sent request request <br>to your team (Juventus F.C.)	f	2017-04-05 17:50:16.857342	2017-04-05 17:50:16.857342
37	30	27	\N	5	team_request_request	Player: L. Bonucci has sent request request <br>to your team (Juventus F.C.)	f	2017-04-05 17:51:51.113537	2017-04-05 17:51:51.113537
38	31	27	\N	5	team_request_request	Player: A. Pirlo has sent request request <br>to your team (Juventus F.C.)	f	2017-04-05 17:53:50.001844	2017-04-05 17:53:50.001844
35	28	27	\N	5	team_request_request	Player: G. Higuain has sent request request <br>to your team (Juventus F.C.)	t	2017-04-05 17:48:26.512585	2017-04-05 17:55:14.04222
39	27	31	\N	5	team_request_accept_request	Team: Juventus F.C. has accepted <br>your request(A. Pirlo) to join their team	f	2017-04-05 17:55:16.705199	2017-04-05 17:55:16.705199
40	27	29	\N	5	team_request_accept_request	Team: Juventus F.C. has accepted <br>your request(G. Chiellini ) to join their team	f	2017-04-05 17:55:22.241859	2017-04-05 17:55:22.241859
41	27	28	\N	5	team_request_accept_request	Team: Juventus F.C. has accepted <br>your request(G. Higuain) to join their team	f	2017-04-05 17:55:25.339048	2017-04-05 17:55:25.339048
42	27	30	\N	5	team_request_accept_request	Team: Juventus F.C. has accepted <br>your request(L. Bonucci) to join their team	f	2017-04-05 17:55:29.805838	2017-04-05 17:55:29.805838
43	32	12	\N	6	team_request_request	Player: Charles has sent request request <br>to your team (CoderSchool)	t	2017-04-05 17:59:36.198707	2017-04-05 18:04:12.674455
44	12	32	\N	6	team_request_accept_request	Team: CoderSchool has accepted <br>your request(Charles) to join their team	f	2017-04-05 18:04:16.705373	2017-04-05 18:04:16.705373
45	33	12	\N	6	team_request_request	Player: Dave has sent request request <br>to your team (CoderSchool)	f	2017-04-05 18:05:04.162988	2017-04-05 18:05:04.162988
46	34	12	\N	6	team_request_request	Player: Vy has sent request request <br>to your team (CoderSchool)	f	2017-04-05 18:05:39.427717	2017-04-05 18:05:39.427717
47	35	12	\N	6	team_request_request	Player: Tan has sent request request <br>to your team (CoderSchool)	f	2017-04-05 18:08:11.050668	2017-04-05 18:08:11.050668
48	12	33	\N	6	team_request_accept_request	Team: CoderSchool has accepted <br>your request(Dave) to join their team	f	2017-04-05 18:08:35.099571	2017-04-05 18:08:35.099571
49	12	34	\N	6	team_request_accept_request	Team: CoderSchool has accepted <br>your request(Vy) to join their team	f	2017-04-05 18:08:39.71082	2017-04-05 18:08:39.71082
50	12	35	\N	6	team_request_accept_request	Team: CoderSchool has accepted <br>your request(Tan) to join their team	f	2017-04-05 18:08:42.499243	2017-04-05 18:08:42.499243
\.


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('notifications_id_seq', 50, true);


--
-- Data for Name: player_references; Type: TABLE DATA; Schema: public; Owner: -
--

COPY player_references (id, name, club, image_url, created_at, updated_at) FROM stdin;
1	Cristiano Ronaldo	Real Madrid	https://media.guim.co.uk/bf0a5d44c96331b6588b11a7b0189c92f4c9173f/900_146_1210_1210/500.jpg	2017-04-05 11:21:10.817701	2017-04-05 11:21:10.817701
2	Lionel Messi	Barcelona	https://media.guim.co.uk/c992105c66eb8d1d3649eac6b168773797607811/1494_1268_989_989/500.jpg	2017-04-05 11:21:10.819689	2017-04-05 11:21:10.819689
3	Luis Suárez	Barcelona	https://media.guim.co.uk/ba6a4198b1222a1a4e873d76281a3fcec408725e/842_631_1515_1514/500.jpg	2017-04-05 11:21:10.82125	2017-04-05 11:21:10.82125
4	Antoine Griezmann	Atlético Madrid	https://media.guim.co.uk/8265e0bfe230661a49a153f051a27b5da179d3b1/2228_208_1579_1579/500.jpg	2017-04-05 11:21:10.82283	2017-04-05 11:21:10.82283
5	Neymar	Barcelona	https://media.guim.co.uk/4fa98e1fed25b46e986e9f0e2e909cc9a07ef8b2/1492_60_1254_1254/500.jpg	2017-04-05 11:21:10.824866	2017-04-05 11:21:10.824866
6	Gareth Bale	Real Madrid	https://media.guim.co.uk/b819abd73fb764dcaddc229122f56cce5d0aea51/1938_57_1167_1167/500.jpg	2017-04-05 11:21:10.829462	2017-04-05 11:21:10.829462
7	Robert Lewandowski	Bayern Munich	https://media.guim.co.uk/feb9b03963bcc4e4b4675b70e64d2b25166d043c/1124_290_750_750/500.jpg	2017-04-05 11:21:10.832871	2017-04-05 11:21:10.832871
8	Pierre-Emerick Aubameyang	Borussia Dortmund	https://media.guim.co.uk/ed13bb7d3609d8b99426fcddc3777335edd9d252/902_101_914_914/500.jpg	2017-04-05 11:21:10.835073	2017-04-05 11:21:10.835073
9	Alexis Sánchez	Arsenal	https://media.guim.co.uk/cf71edf5cc381a9d8cd9d9d02c9dd8e99970c3a7/1296_36_1214_1214/500.jpg	2017-04-05 11:21:10.836766	2017-04-05 11:21:10.836766
10	Riyad Mahrez	Leicester City	https://media.guim.co.uk/e845ea550dbd7e1c4f3f6052b88a3aad56d9f1f7/637_158_1189_1188/500.jpg	2017-04-05 11:21:10.838409	2017-04-05 11:21:10.838409
11	Sergio Agüero	Manchester City	https://media.guim.co.uk/450913a0cf0ac8f174e747a82148819d19e45977/2015_112_1325_1325/500.jpg	2017-04-05 11:21:10.839984	2017-04-05 11:21:10.839984
12	Luka Modric	Real Madrid	https://media.guim.co.uk/57e61a3537497dddc0ba43f1fad75f8d38c311c5/907_363_825_825/500.jpg	2017-04-05 11:21:10.841648	2017-04-05 11:21:10.841648
13	Kevin De Bruyne	Manchester City	https://media.guim.co.uk/dcb036afada1fd76c088cb482cf03b17ae0c9a43/731_136_916_915/500.jpg	2017-04-05 11:21:10.843445	2017-04-05 11:21:10.843445
14	Gonzalo Higuaín	Juventus	https://media.guim.co.uk/fc1d56354ccf94990d63220eaa64096bc663a032/1462_463_1180_1180/500.jpg	2017-04-05 11:21:10.84547	2017-04-05 11:21:10.84547
15	Andrés Iniesta	Barcelona	https://media.guim.co.uk/1597af420fdedc6b7dacabe606d8ed4f1e735fe9/713_118_2553_2552/500.jpg	2017-04-05 11:21:10.847208	2017-04-05 11:21:10.847208
16	N'Golo Kanté	Chelsea	https://media.guim.co.uk/aaa95654756ca755ff78f537fff8c03eb15c3795/1172_57_1423_1424/500.jpg	2017-04-05 11:21:10.848866	2017-04-05 11:21:10.848866
17	Paul Pogba	Manchester United	https://media.guim.co.uk/6463deb9ab096af41645ca810977e313c2c8a90c/794_198_958_957/500.jpg	2017-04-05 11:21:10.850409	2017-04-05 11:21:10.850409
18	Manuel Neuer	Bayern Munich	https://media.guim.co.uk/6d25bc9b959aee1f0dadfd95f7caa99ad533b096/1830_50_1904_1904/500.jpg	2017-04-05 11:21:10.852015	2017-04-05 11:21:10.852015
19	Jamie Vardy	Leicester City	https://media.guim.co.uk/456a221a6de59659a9cf690d3a8ae0dcfd769d52/1357_74_911_911/500.jpg	2017-04-05 11:21:10.853584	2017-04-05 11:21:10.853584
20	Zlatan Ibrahimovic	Manchester United	https://media.guim.co.uk/7a2b1863da73d1ac77785b0db4a789b466e0cdb4/1293_146_1158_1158/500.jpg	2017-04-05 11:21:10.855189	2017-04-05 11:21:10.855189
21	Toni Kroos	Real Madrid	https://media.guim.co.uk/aebec5dd9c2a69be127ca11e021a6746bbae0cc8/1560_0_1155_1155/500.jpg	2017-04-05 11:21:10.856793	2017-04-05 11:21:10.856793
22	Gianluigi Buffon	Juventus	https://media.guim.co.uk/f44fa429b502a9187fe6aafcb2a9858450d26891/798_19_1794_1795/500.jpg	2017-04-05 11:21:10.858397	2017-04-05 11:21:10.858397
23	Mesut Özil	Arsenal	https://media.guim.co.uk/063f7274cf15ddc4f622bc36462efd56a4dabc9c/1392_109_815_815/500.jpg	2017-04-05 11:21:10.860058	2017-04-05 11:21:10.860058
24	Diego Godín	Atlético Madrid	https://media.guim.co.uk/78e3942278a5aea198b4c7e9b8f454f80af4452d/1122_1116_625_625/500.jpg	2017-04-05 11:21:10.86168	2017-04-05 11:21:10.86168
25	Sergio Ramos	Real Madrid	https://media.guim.co.uk/6d1349ddf9cd8158d45bbf830904df6e14da1b28/1163_28_650_651/500.jpg	2017-04-05 11:21:10.863276	2017-04-05 11:21:10.863276
26	Leonardo Bonucci	Juventus	https://media.guim.co.uk/19b6e8834297ac105d0e0b2c89eace90074e65df/1217_125_1218_1218/500.jpg	2017-04-05 11:21:10.864852	2017-04-05 11:21:10.864852
27	Dimitri Payet	West Ham United	https://media.guim.co.uk/5065c4ea7a9f5baada07eb15c9502f54731f43ec/823_22_1100_1100/500.jpg	2017-04-05 11:21:10.866446	2017-04-05 11:21:10.866446
28	Philippe Coutinho	Liverpool	https://media.guim.co.uk/3b1d82b6fb5b2bda26e5195bc53f297a6731b61c/1239_85_734_734/500.jpg	2017-04-05 11:21:10.868025	2017-04-05 11:21:10.868025
29	David de Gea	Manchester United	https://media.guim.co.uk/0e3df4e6315634a1ed86f1e2ce3b9e0ad14df409/1420_96_952_951/500.jpg	2017-04-05 11:21:10.869558	2017-04-05 11:21:10.869558
30	Pepe	Real Madrid	https://media.guim.co.uk/bcfb5e7d309817dcf32e2a8ef1c982481e900349/1594_148_1067_1067/500.jpg	2017-04-05 11:21:10.871149	2017-04-05 11:21:10.871149
31	Thomas Müller	Bayern Munich	https://media.guim.co.uk/2f4dd3be9f9217de27199244f980dc80be8f2466/1024_78_1012_1012/500.jpg	2017-04-05 11:21:10.872704	2017-04-05 11:21:10.872704
32	Arturo Vidal	Bayern Munich	https://media.guim.co.uk/0ddd48d34071acf998483c95acfa1e14c3fb14c0/1287_884_989_989/500.jpg	2017-04-05 11:21:10.874465	2017-04-05 11:21:10.874465
33	Harry Kane	Tottenham Hotspur	https://media.guim.co.uk/6bf3025527f9be0fc73f82759fbe14814d024204/1509_32_1063_1064/500.jpg	2017-04-05 11:21:10.876069	2017-04-05 11:21:10.876069
34	Ivan Rakitić 	Barcelona	https://media.guim.co.uk/e5d63a5df4a518c2955f7ee320ce7d2a3b860c97/639_262_966_965/500.jpg	2017-04-05 11:21:10.877617	2017-04-05 11:21:10.877617
35	Eden Hazard	Chelsea	https://media.guim.co.uk/a9ae9a7b7dbd15ca3bbb224ec5ee7f77450fe56e/917_123_640_639/500.jpg	2017-04-05 11:21:10.879293	2017-04-05 11:21:10.879293
36	Jérôme Boateng	Bayern Munich	https://media.guim.co.uk/b5c3b861981147dcba5201a91ad88a509c91e067/127_132_2229_2229/500.jpg	2017-04-05 11:21:10.880892	2017-04-05 11:21:10.880892
37	Paulo Dybala	Juventus	https://media.guim.co.uk/b7f7b77b2bc750caa7f63ab53b077fc556b34db1/761_121_561_561/500.jpg	2017-04-05 11:21:10.882453	2017-04-05 11:21:10.882453
38	Gerard Piqué	Barcelona	https://media.guim.co.uk/4a94eae892f58b235c87a2169a4d3fbb20314aaf/1955_361_866_866/500.jpg	2017-04-05 11:21:10.884129	2017-04-05 11:21:10.884129
39	Sergio Busquets	Barcelona	https://media.guim.co.uk/689a3d806fd1834af88223833a3d7f0b501b2626/844_245_532_532/500.jpg	2017-04-05 11:21:10.885922	2017-04-05 11:21:10.885922
40	Hugo Lloris	Tottenham Hotspur	https://media.guim.co.uk/b59bdc3a516e217e54716517b54b086ded72fe89/499_36_497_497/500.jpg	2017-04-05 11:21:10.887537	2017-04-05 11:21:10.887537
41	Koke	Atlético Madrid	https://media.guim.co.uk/80e5001857c799036a1b8b366f87741eda037f45/2017_175_1317_1317/500.jpg	2017-04-05 11:21:10.88916	2017-04-05 11:21:10.88916
42	Jan Oblak	Atlético Madrid	https://media.guim.co.uk/8a8e8356d2e421d0e031550b7923b0aac8ae748a/804_163_1413_1412/500.jpg	2017-04-05 11:21:10.890684	2017-04-05 11:21:10.890684
43	Ángel di María	PSG	https://media.guim.co.uk/a8a2eccc1a94b5102ab603fa8a43eb3510f488f3/1005_203_863_863/500.jpg	2017-04-05 11:21:10.892313	2017-04-05 11:21:10.892313
44	David Silva	Manchester City	https://media.guim.co.uk/664ec5a4fa809f771121c52b4adfd123ff2ebb2c/1056_372_1187_1187/500.jpg	2017-04-05 11:21:10.893974	2017-04-05 11:21:10.893974
45	Marco Verratti	PSG	https://media.guim.co.uk/1ebe6464a4cbe83dfbe5694694b60edf4b122064/984_182_759_759/500.jpg	2017-04-05 11:21:10.895495	2017-04-05 11:21:10.895495
46	Diego Costa	Chelsea	https://media.guim.co.uk/db551808790b285a20d9ced9d5918368e11ffec8/1267_273_1575_1574/500.jpg	2017-04-05 11:21:10.897063	2017-04-05 11:21:10.897063
47	Edinson Cavani	PSG	https://media.guim.co.uk/e1a3edb1793b90b8ce73e96cfa83a1478ae58479/673_52_798_798/500.jpg	2017-04-05 11:21:10.898661	2017-04-05 11:21:10.898661
48	Marcelo	Real Madrid	https://media.guim.co.uk/b8d8de74ea37739eda328f9cdbd38e4dfdc13f7c/1787_70_1305_1305/500.jpg	2017-04-05 11:21:10.90029	2017-04-05 11:21:10.90029
49	Mauro Icardi	Internazionale	https://media.guim.co.uk/a0f197122fbecec38ca2d417a2f65cbf854ad4f1/1749_106_744_744/500.jpg	2017-04-05 11:21:10.90184	2017-04-05 11:21:10.90184
50	Karim Benzema	Real Madrid	https://media.guim.co.uk/da4f20dc36e9377616438ff58f24f06e06ab8dc2/1155_285_1739_1740/500.jpg	2017-04-05 11:21:10.903652	2017-04-05 11:21:10.903652
51	Mats Hummels	Bayern Munich	https://media.guim.co.uk/b958243b3f022b795974e29bb20a100b7949438a/1188_226_993_993/500.jpg	2017-04-05 11:21:10.905323	2017-04-05 11:21:10.905323
52	Thiago Silva	PSG	https://media.guim.co.uk/05dcc13556eaf63659ce08e93a2f9132a33022c3/651_378_1268_1268/500.jpg	2017-04-05 11:21:10.906863	2017-04-05 11:21:10.906863
53	Casemiro	Real Madrid	https://media.guim.co.uk/56fb269f3b9fb499a89562a9409e188784021139/1132_238_1208_1209/500.jpg	2017-04-05 11:21:10.908403	2017-04-05 11:21:10.908403
54	Renato Sanches	Bayern Munich	https://media.guim.co.uk/6ff40284d7ed18e3ec463a65c65ff165a9b18470/1018_83_723_723/500.jpg	2017-04-05 11:21:10.909998	2017-04-05 11:21:10.909998
55	Keylor Navas	Real Madrid	https://media.guim.co.uk/2acdded66a9d52ee49d33ab79a57bf2af862b51e/439_48_834_833/500.jpg	2017-04-05 11:21:10.911647	2017-04-05 11:21:10.911647
56	Philipp Lahm	Bayern Munich	https://media.guim.co.uk/8e964027f322024aafad6ccc8b01506339ade1a9/2315_128_768_768/500.jpg	2017-04-05 11:21:10.913285	2017-04-05 11:21:10.913285
57	Henrikh Mkhitaryan	Manchester United	https://media.guim.co.uk/af0de22675fe24a4b4dc3e25b59ecaae998026a7/1140_67_576_576/500.jpg	2017-04-05 11:21:10.914879	2017-04-05 11:21:10.914879
58	Toby Alderweireld	Tottenham Hotspur	https://media.guim.co.uk/5fcb60223b2b34012aee837166a427604e949497/792_289_545_544/500.jpg	2017-04-05 11:21:10.91651	2017-04-05 11:21:10.91651
59	Kévin Gameiro	Atlético Madrid	https://media.guim.co.uk/960d4b481996b2e2925b6970a5967b3b1a1d4f68/1404_301_614_615/500.jpg	2017-04-05 11:21:10.918073	2017-04-05 11:21:10.918073
60	Joshua Kimmich	Bayern Munich	https://media.guim.co.uk/e4267d0483cb82f105fc8f232ae519d3afa1416f/793_221_1955_1954/500.jpg	2017-04-05 11:21:10.919635	2017-04-05 11:21:10.919635
61	David Alaba	Bayern Munich	https://media.guim.co.uk/81d0c8be7f321709d3f819208188140f1189e45c/884_27_1125_1124/500.jpg	2017-04-05 11:21:10.92129	2017-04-05 11:21:10.92129
62	Javier Mascherano	Barcelona	https://media.guim.co.uk/be65eee043256df04d21f6eb782f3dfa49a0d445/802_117_1440_1439/500.jpg	2017-04-05 11:21:10.922878	2017-04-05 11:21:10.922878
63	Douglas Costa	Bayern Munich	https://media.guim.co.uk/0a487f56d2e80d35686e19169cebc087fc2e50cd/1378_227_970_970/500.jpg	2017-04-05 11:21:10.924556	2017-04-05 11:21:10.924556
64	Gabriel Jesus	Palmeiras	https://media.guim.co.uk/a06699f657a8411daff94b85e23ef963ab318d44/820_290_776_776/500.jpg	2017-04-05 11:21:10.926118	2017-04-05 11:21:10.926118
65	Mohamed Salah	Roma	https://media.guim.co.uk/02b0674c7ad19bb3a3ebb0c07e6a40855ec4ea49/1335_857_1090_1090/500.jpg	2017-04-05 11:21:10.927707	2017-04-05 11:21:10.927707
66	Giorgio Chiellini	Juventus	https://media.guim.co.uk/84eb30fd47232588bd2aa2efa4c317ced6fc53ac/1172_65_575_575/500.jpg	2017-04-05 11:21:10.929278	2017-04-05 11:21:10.929278
67	Aritz Aduriz	Athletic Bilbao	https://media.guim.co.uk/029d8b3be9c6b20d4ae398e4918d9f890592a3a8/2467_44_1653_1653/500.jpg	2017-04-05 11:21:10.930911	2017-04-05 11:21:10.930911
68	Laurent Koscielny	Arsenal	https://media.guim.co.uk/abf1c948673a2f962a7d5ce0222bf41936f8b4ad/701_144_607_606/500.jpg	2017-04-05 11:21:10.93248	2017-04-05 11:21:10.93248
69	Sadio Mané	Liverpool	https://media.guim.co.uk/3ce500d62edad0d103afdc3d99e102293b4413cc/1005_0_812_812/500.jpg	2017-04-05 11:21:10.934082	2017-04-05 11:21:10.934082
70	Miralem Pjanic	Juventus	https://media.guim.co.uk/74bee49e8444271a44f0f01f7aafdb7bafca0de5/1344_21_901_901/500.jpg	2017-04-05 11:21:10.935719	2017-04-05 11:21:10.935719
71	Álvaro Morata	Real Madrid	https://media.guim.co.uk/51567a09103bcd9835a06cf29c104c68f53e50b1/1341_122_804_804/500.jpg	2017-04-05 11:21:10.937374	2017-04-05 11:21:10.937374
72	Kasper Schmeichel	Leicester City	https://media.guim.co.uk/a788f8b43fa706cf7daab8c7e159fed1d0b243d5/1483_76_815_815/500.jpg	2017-04-05 11:21:10.93896	2017-04-05 11:21:10.93896
73	Aaron Ramsey	Arsenal	https://media.guim.co.uk/f0021284b3e3324920f97d898fd5e63e278f160f/1130_99_1361_1361/500.jpg	2017-04-05 11:21:10.940546	2017-04-05 11:21:10.940546
74	Raphaël Guerreiro	Borussia Dortmund	https://media.guim.co.uk/d95b8bf7d8585972bd85f5ebc296ba09579f38fe/1255_151_941_941/500.jpg	2017-04-05 11:21:10.942098	2017-04-05 11:21:10.942098
75	Rui Patrício	Sporting Lisbon	https://media.guim.co.uk/74d1b5a66467ac3b9ddd40859cbcdbb23465ecf8/1305_313_732_732/500.jpg	2017-04-05 11:21:10.943663	2017-04-05 11:21:10.943663
76	Roberto Firmino	Liverpool	https://media.guim.co.uk/41ec3bcf3e1fae858c8acb05416267bce35b4a60/360_84_827_827/500.jpg	2017-04-05 11:21:10.945257	2017-04-05 11:21:10.945257
77	Yannick Carrasco	Atlético Madrid	https://media.guim.co.uk/0d690be1c81c0a6df6e351626a68025d5b139fb2/792_147_892_892/500.jpg	2017-04-05 11:21:10.946886	2017-04-05 11:21:10.946886
78	Dani Alves	Juventus	https://media.guim.co.uk/6f83b7362308126668332f4ac3796045406c4b42/606_773_994_993/500.jpg	2017-04-05 11:21:10.948471	2017-04-05 11:21:10.948471
79	Nani	Valencia	https://media.guim.co.uk/325ec4419a553c8835318537bc92d1a680f6b033/1284_203_2354_2355/500.jpg	2017-04-05 11:21:10.950097	2017-04-05 11:21:10.950097
80	Gianluigi Donnarumma	Milan	https://media.guim.co.uk/fffaecd27397ef78ee236df404be364e36e17d80/713_635_1434_1433/500.jpg	2017-04-05 11:21:10.951761	2017-04-05 11:21:10.951761
81	Claudio Bravo	Manchester City	https://media.guim.co.uk/664450ba675e5cc4dd9c0d8c6f9391a9fcb0cde8/1001_144_913_913/500.jpg	2017-04-05 11:21:10.953426	2017-04-05 11:21:10.953426
82	Marek Hamsik	Napoli	https://media.guim.co.uk/9400a3a19a0d6aba238e06c2a618b009c042ccd8/272_418_722_722/500.jpg	2017-04-05 11:21:10.955096	2017-04-05 11:21:10.955096
83	Miguel Borja	Atlético Nacional	https://media.guim.co.uk/4d5db0dd08322494d777bbeb3ff52e127e10b5eb/1557_142_1384_1383/500.jpg	2017-04-05 11:21:10.956719	2017-04-05 11:21:10.956719
84	Blaise Matuidi	PSG	https://media.guim.co.uk/7a2a74fde9144818fd5e540f87ce1b953bbe78ea/655_44_1100_1100/500.jpg	2017-04-05 11:21:10.958422	2017-04-05 11:21:10.958422
85	Ilkay Gündogan	Manchester City	https://media.guim.co.uk/b0ee4d45a80c765a4a8a8983449c7c43d08ab965/582_50_670_669/500.jpg	2017-04-05 11:21:10.960036	2017-04-05 11:21:10.960036
86	Juan Mata	Manchester United	https://media.guim.co.uk/b224817e99c770b67a3e0c2f5381df66e504e9be/520_175_892_892/500.jpg	2017-04-05 11:21:10.961702	2017-04-05 11:21:10.961702
87	James Rodríguez	Real Madrid	https://media.guim.co.uk/752bb389acb87a9bf3151ea53de5e3395a98de99/1445_195_1074_1075/500.jpg	2017-04-05 11:21:10.963381	2017-04-05 11:21:10.963381
88	Raheem Sterling	Manchester City	https://media.guim.co.uk/ed052815e69b69287fbb21520fede5feabbb92aa/592_416_648_648/500.jpg	2017-04-05 11:21:10.964943	2017-04-05 11:21:10.964943
89	Arjen Robben	Bayern Munich	https://media.guim.co.uk/386c748a544a67fb817d58c15ee6575a2542c0e8/540_80_704_704/500.jpg	2017-04-05 11:21:10.966511	2017-04-05 11:21:10.966511
90	Dele Alli	Tottenham Hotspur	https://media.guim.co.uk/46a4eef35c953c780207bf1ec88a26c1fb64f271/1228_140_781_781/500.jpg	2017-04-05 11:21:10.96811	2017-04-05 11:21:10.96811
91	Adrien Silva	Sporting Lisbon	https://media.guim.co.uk/82e2bd6c86b596e69b46ea5e2067e4ba64483799/417_252_568_567/500.jpg	2017-04-05 11:21:10.96968	2017-04-05 11:21:10.96968
92	Thibaut Courtois	Chelsea	https://media.guim.co.uk/9baafff22b5154ce2def53e8851e681e1ada7837/533_52_651_650/500.jpg	2017-04-05 11:21:10.971445	2017-04-05 11:21:10.971445
93	Fernandinho	Manchester City	https://media.guim.co.uk/da8e136396c1db79002467bb5b0280f567069553/954_129_704_703/500.jpg	2017-04-05 11:21:10.973123	2017-04-05 11:21:10.973123
94	Alexandre Lacazette	Lyon	https://media.guim.co.uk/c1bf4ba96c8f84bf9ad74456c3de49b805336cfd/1133_185_2112_2113/500.jpg	2017-04-05 11:21:10.974757	2017-04-05 11:21:10.974757
95	Éver Banega	Internazionale	https://media.guim.co.uk/89efc24a4ac29c86fb14ad72d4a3518b3c9dc19c/877_7_1432_1432/500.jpg	2017-04-05 11:21:10.976428	2017-04-05 11:21:10.976428
96	Francesco Totti	Roma	https://media.guim.co.uk/b991f12a34076827dd950e97fc75a1ce5edc8d7d/612_301_1021_1020/500.jpg	2017-04-05 11:21:10.978015	2017-04-05 11:21:10.978015
97	Santi Cazorla	Arsenal	https://media.guim.co.uk/d36c197e6a25c43adb8b8d3edc4575f05ff428df/1392_230_1121_1121/500.jpg	2017-04-05 11:21:10.979595	2017-04-05 11:21:10.979595
98	Thiago Alcântara	Bayern Munich	https://media.guim.co.uk/cc87cd6a90d08fa717f1ecdae9a5fb522f06c6b8/547_133_1379_1378/500.jpg	2017-04-05 11:21:10.981287	2017-04-05 11:21:10.981287
99	Julian Weigl	Borussia Dortmund	https://media.guim.co.uk/9d731fcacc94cfee473bc068207798fd17b24787/279_55_588_588/500.jpg	2017-04-05 11:21:10.982855	2017-04-05 11:21:10.982855
100	Ousmane Dembélé	Borussia Dortmund	https://media.guim.co.uk/df5ef3c5552d7ca5f4b025484a911d988afdaaaa/358_5_796_796/500.jpg	2017-04-05 11:21:10.984438	2017-04-05 11:21:10.984438
\.


--
-- Name: player_references_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('player_references_id_seq', 100, true);


--
-- Data for Name: player_results; Type: TABLE DATA; Schema: public; Owner: -
--

COPY player_results (id, match_id, player_id, goal, created_at, updated_at, verify_status) FROM stdin;
\.


--
-- Name: player_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('player_results_id_seq', 1, false);


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: -
--

COPY players (id, team_id, full_name, email, password_digest, created_at, updated_at, image_url, nickname, favorite_player, favorite_team, goal, games_played) FROM stdin;
15	3	E. Hazard	edenhazard@gmail.com	$2a$10$q8c04lyNC3Lv1qTXUcy1Wux/ciGpPCugXQNlFnQwxt0fgTCiU46Xa	2017-04-05 12:31:07.862941	2017-04-05 17:08:24.760223	hazard.jpg				\N	\N
3	\N	G. Bale	garethbale@gmail.com	$2a$10$8.Z1xLOzLoXtVciBQ4./B.4kVwW8.eBo8Px9QIj/COMn21I6FC9Ky	2017-04-05 12:06:48.005716	2017-04-05 12:07:00.180474	bale.jpg				\N	\N
6	\N	A. Iniesta	andresiniesta@gmail.com	$2a$10$XPVbajIbwhK4jR/0a2vgn.WUBWC9J65cfN4sQKCLfOciFrHHEn2p2	2017-04-05 12:09:27.626639	2017-04-05 12:09:50.028928	iniesta.jpg				\N	\N
12	6	Harley	harleytrung@gmail.com	$2a$10$yoNYsER94pHfIn5qyJyn1OhJzXc4vpvVTYFkkgubWmPyDZl0UJRke	2017-04-05 12:24:36.095159	2017-04-05 17:59:01.641738	11703293_10100901374320434_2543083367635502905_o.jpg				\N	\N
26	4	K. Bruyne	kevindebruyne@gmail.com	$2a$10$F/oQLO7tqX4AA5a3QW3MnO03Gq44nEwXGoJ.tscztmjPzktV0Ovxy	2017-04-05 17:41:19.301777	2017-04-05 17:41:45.908779	kevin-de-bruyne.jpg				\N	\N
20	3	C. Fabregas	cescfabregas@gmail.com	$2a$10$rc8.XPOkJO3cz90UAhlGr.P9FgOxRW/Ovj3ydd4aWrMdaYQqUsYre	2017-04-05 17:12:24.254866	2017-04-05 17:13:35.572805	cesc-fabregas-513844.jpg				\N	\N
19	3	D. Costa	diegocosta@gmail.com	$2a$10$QpF4RNilv6/iKufJTfRv6.cT9xPgvEsY6kHBdcN8Fr8vAHeDjkbxq	2017-04-05 17:09:23.022427	2017-04-05 17:13:37.66784	costa.jpg				\N	\N
35	6	Tan	tan@gmail.com	$2a$10$I.fGjMcS.VtD.aoP7EFzNOHjZ1uHMzxax6w2g64TqWPLFqp2bL8wq	2017-04-05 18:08:07.969601	2017-04-05 18:08:42.49086	tan.jpg				\N	\N
13	\N	K. Benzema	karimbenzema@gmail.com	$2a$10$DATr62P13wgJnY7ygECQvOVcrP7F2ZLtBM7eucF8z.ukyVkA2EXCW	2017-04-05 12:25:59.368937	2017-04-05 12:27:53.962413	benzema.jpg				\N	\N
18	3	T. Courtois	thibautcourtois@gmail.com	$2a$10$SrhaC8.VAu1SVNgxsSPrAeExwuUj6aK/fP60X5/YqrKjVZG387NI6	2017-04-05 17:06:14.795314	2017-04-05 17:17:46.055948	thibaut-courtois-540866.jpg				\N	\N
21	3	D. Luiz	davidluiz@gmail.com	$2a$10$rNJpshk5p8waNHQNhX1OCu3/HqVcQ6WLjaxsJ81/6MIo1sdQWnESe	2017-04-05 17:14:56.704369	2017-04-05 17:18:02.023497	david-luiz.jpg				\N	\N
17	\N	Lanh Hoang	ryu.hayabusha@gmail.com	$2a$10$lz/ILqaU/RKsyTvUvKT3YO.hTr7TX.PXq2skXIOKve/gr79sEmyYG	2017-04-05 15:28:25.260453	2017-04-05 15:55:05.001852	\N	\N	\N	\N	\N	\N
1	1	I. Casillas	casillas@gmail.com	$2a$10$euljWKPe0BR/vCJvFJHoNO/E14glD2apIIluymPUNWaymGYOQmQCC	2017-04-05 11:23:10.961886	2017-04-05 16:15:16.856987	casillas.jpg				\N	\N
2	1	L. Modric	lukamodric@gmail.com	$2a$10$oFLoj/Z5GdbN94QcrMwAv.EmxnCQIHU85qqEeyH1f4zmAMJNcnGuO	2017-04-05 12:04:41.400877	2017-04-05 16:44:18.503755	modric.jpg				\N	\N
5	1	C. Ronaldo	cristianoronaldo@gmail.com	$2a$10$VujyILF0jHtHECdiWuTYjOKDHw4QQ336d4AohRXj4h9gjeMfAMaXG	2017-04-05 12:08:29.462637	2017-04-05 16:44:44.489087	cr.jpg				\N	\N
4	1	Marcelo	marcelo@gmail.com	$2a$10$0n8.fV4LcH7LTINpacZIFu5JwOQs0VRiNjj2.fc8FsQHSN.TMoK0C	2017-04-05 12:07:39.647234	2017-04-05 16:45:19.177064	Marcelo.jpg				\N	\N
14	1	S. Ramos	sergioramos@gmail.com	$2a$10$N6Exq0fwvakkASIvfHY8TehjGe5MOTEkKa89MRUQx7ALZYzoXCjTC	2017-04-05 12:28:28.041186	2017-04-05 16:45:39.220437	ramos.jpg				\N	\N
10	2	Xavi	xavierhernandez@gmail.com	$2a$10$2qGB3jssut8xRXPsLLlnN.VplGRIqa5wOPAq8Ilj/MhlPy4tap4kW	2017-04-05 12:15:37.53193	2017-04-05 16:48:10.939207	xavi.png				\N	\N
8	2	V. Valdes	victorvaldes@gmail.com	$2a$10$EJRu9iV0yA3lDp44fR7yuOZEi//ep.uY2qVW/EwGE/wVnMlM1Kife	2017-04-05 12:12:50.526966	2017-04-05 16:52:13.15608	valdes.jpg				\N	\N
11	2	Ronaldinho	ronaldinho@gmail.com	$2a$10$gWS1ao0gMqIPzS.HDnjvsOqNABP/nNRT1gdFW1r8XZaheGqGcCNo6	2017-04-05 12:18:11.58827	2017-04-05 16:52:31.544799	ronaldinho.jpg				\N	\N
7	2	L. Messi	lionelmessi@gmail.com	$2a$10$bIJh9LwrfJtPsaSE/BsM3uP.Z1twTFu9zjpBIzY2hqTizmHoIPrbG	2017-04-05 12:11:08.473381	2017-04-05 16:52:52.689499	messi.jpg				\N	\N
9	2	G. Pique	geraldpique@gmail.com	$2a$10$djbh3Ux/.Qglqj1va.FroudZiRNab.ZZry3hEv3GcYiwnrxGghm8a	2017-04-05 12:13:58.020224	2017-04-05 16:53:16.838851	pique.jpg				\N	\N
27	5	G. Buffon	gianluigibuffon@gmail.com	$2a$10$SorSVD/wvTWz2tO7rNc95u0mODsgi4vLy9tpU.4iru/ohOF6yFjTi	2017-04-05 17:45:00.873726	2017-04-05 17:47:55.009555	gianluigi-buffon.jpg				\N	\N
22	4	D. Silva	davidsilva@gmail.com	$2a$10$oF4eBlSiUTJnk.72Hc8HPOllZ/bMNRRjPvzVU2ES1P8gWIA0MT3Eq	2017-04-05 17:24:03.917193	2017-04-05 17:26:22.080914	david-silva.jpg				\N	\N
23	4	J. Hart	joehart@gmail.com	$2a$10$yLAYGRNMaTIAhpaB5MftzuEAkx7jOMtoQ9UMVRXaoNOLC26ZXoGhS	2017-04-05 17:28:07.38639	2017-04-05 17:31:13.699209	joe-hart.jpg				\N	\N
24	4	S. Aguero	sergioaguero@gmail.com	$2a$10$L7BRNtItOQ7qiK1yahHGSOUPyqSDq4dEwmmvVCN/o3JNZ/Z.84kFC	2017-04-05 17:29:40.972342	2017-04-05 17:31:18.783643	sergio-aguero-443067.jpg				\N	\N
32	6	Charles	charleslee@gmail.com	$2a$10$WZy1WQ2hcwyyBkqW7B8fI.HGKRtY8mRqJ4c9dltpMMJsPzoiA3AqW	2017-04-05 17:59:31.645193	2017-04-05 18:04:16.696835	Luvocracy_327_1_x8yw9e.jpg				\N	\N
25	4	V. Kompany	vincentkompany@gmail.com	$2a$10$kOE4tHQTpsn8OT.Wj0.Ahexjl71rVCTWpYT0AF/8uTn2cNSOWL5ya	2017-04-05 17:35:39.885709	2017-04-05 17:37:25.435441	vincent1.jpg				\N	\N
31	5	A. Pirlo	andreapirlo@gmail.com	$2a$10$kyw25MrVy05.gMXfrBxAcOzzAJeFFwLMFjloI16Rc1p3VdtIH1L8S	2017-04-05 17:53:46.173911	2017-04-05 17:55:16.693915	Andrea-Pirlo.jpg				\N	\N
29	5	G. Chiellini 	giorgiochiellini@gmail.com	$2a$10$S.6UU9tl17uQC6frpf2U5eLR.3IYp/4BO6LJZio43tc/LSx3AuU8K	2017-04-05 17:50:12.60117	2017-04-05 17:55:22.231434	Giorgio-Chiellini.jpg				\N	\N
28	5	G. Higuain	gonzalohiguain@gmail.com	$2a$10$BFHNd0ekVHqcoMNh1LmmaOUNiir2zmy9Ck1Gb.86MWlkKHICQlFx.	2017-04-05 17:48:21.489886	2017-04-05 17:55:25.329815	Gonzalo-Higuain.jpg				\N	\N
30	5	L. Bonucci	leonardobonucci@gmail.com	$2a$10$gw17VofCbKIg0MMCaU/X4eL1jyzIDL9UVTV/LQhc9NO2sGZ2JWcHG	2017-04-05 17:51:46.511721	2017-04-05 17:55:29.796545	Leonardo-Bonucci.jpg				\N	\N
33	6	Dave	dave@gmail.com	$2a$10$kIETJzt3wEszxKCR/7FQ1eYyqGrLoseYxh9OnaTAaLveHFj5/P2N.	2017-04-05 18:04:37.078945	2017-04-05 18:08:35.089881	dave.jpeg				\N	\N
34	6	Vy	vy@gmail.com	$2a$10$Ah9qvMo7uOQVJGRxq.2SK.CazqiD3H2ekTEl3MOj5IjmJTH7OYupi	2017-04-05 18:05:36.163637	2017-04-05 18:08:39.698926	11751969_480131162153797_5252605283203578367_n.jpg				\N	\N
\.


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('players_id_seq', 35, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY schema_migrations (version) FROM stdin;
20170318125805
20170318131408
20170318135858
20170318140246
20170318140514
20170318141848
20170318141947
20170322051444
20170322051839
20170322052015
20170322052036
20170323100608
20170323114525
20170323125936
20170323130034
20170324065754
20170324084245
20170324155756
20170325075814
20170325075840
20170326080052
20170326083350
20170326150834
20170327160840
20170327181200
20170401063644
20170401095324
20170401173350
20170403094027
20170404072534
20170404133657
20170405021826
20170405065004
20170405110736
\.


--
-- Data for Name: team_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY team_messages (id, body, created_at, updated_at, team_id, player_id) FROM stdin;
\.


--
-- Name: team_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('team_messages_id_seq', 1, false);


--
-- Data for Name: team_owners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY team_owners (id, player_id, team_id, created_at, updated_at) FROM stdin;
2	2	\N	2017-04-05 12:04:45.022958	2017-04-05 12:04:45.022958
3	3	\N	2017-04-05 12:06:48.031219	2017-04-05 12:06:48.031219
4	4	\N	2017-04-05 12:07:39.674951	2017-04-05 12:07:39.674951
5	5	\N	2017-04-05 12:08:29.497344	2017-04-05 12:08:29.497344
6	6	\N	2017-04-05 12:09:27.646314	2017-04-05 12:09:27.646314
7	7	\N	2017-04-05 12:11:08.564013	2017-04-05 12:11:08.564013
8	8	\N	2017-04-05 12:12:50.623856	2017-04-05 12:12:50.623856
9	9	\N	2017-04-05 12:13:58.041139	2017-04-05 12:13:58.041139
11	11	\N	2017-04-05 12:18:11.625168	2017-04-05 12:18:11.625168
13	13	\N	2017-04-05 12:25:59.389855	2017-04-05 12:25:59.389855
14	14	\N	2017-04-05 12:28:28.102638	2017-04-05 12:28:28.102638
17	17	\N	2017-04-05 15:51:15.78471	2017-04-05 15:51:15.78471
1	1	1	2017-04-05 11:23:14.066386	2017-04-05 16:15:16.72744
10	10	2	2017-04-05 12:15:37.569106	2017-04-05 16:48:10.813789
18	18	\N	2017-04-05 17:06:15.081824	2017-04-05 17:06:15.081824
15	15	3	2017-04-05 12:31:07.885284	2017-04-05 17:08:24.634847
19	19	\N	2017-04-05 17:09:23.041343	2017-04-05 17:09:23.041343
20	20	\N	2017-04-05 17:12:24.301447	2017-04-05 17:12:24.301447
21	21	\N	2017-04-05 17:14:56.724507	2017-04-05 17:14:56.724507
22	22	4	2017-04-05 17:24:03.933698	2017-04-05 17:25:27.484147
23	23	\N	2017-04-05 17:28:07.409685	2017-04-05 17:28:07.409685
24	24	\N	2017-04-05 17:29:40.997152	2017-04-05 17:29:40.997152
25	25	\N	2017-04-05 17:35:39.910325	2017-04-05 17:35:39.910325
26	26	\N	2017-04-05 17:41:19.326208	2017-04-05 17:41:19.326208
27	27	5	2017-04-05 17:45:00.890452	2017-04-05 17:46:35.132329
28	28	\N	2017-04-05 17:48:21.519298	2017-04-05 17:48:21.519298
29	29	\N	2017-04-05 17:50:12.62025	2017-04-05 17:50:12.62025
30	30	\N	2017-04-05 17:51:46.529906	2017-04-05 17:51:46.529906
31	31	\N	2017-04-05 17:53:46.239582	2017-04-05 17:53:46.239582
12	12	6	2017-04-05 12:24:36.118984	2017-04-05 17:59:01.518793
32	32	\N	2017-04-05 17:59:31.69199	2017-04-05 17:59:31.69199
33	33	\N	2017-04-05 18:04:37.096709	2017-04-05 18:04:37.096709
34	34	\N	2017-04-05 18:05:36.18326	2017-04-05 18:05:36.18326
35	35	\N	2017-04-05 18:08:07.992999	2017-04-05 18:08:07.992999
\.


--
-- Name: team_owners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('team_owners_id_seq', 35, true);


--
-- Data for Name: team_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY team_requests (id, player_id, team_id, created_at, updated_at, kind) FROM stdin;
\.


--
-- Name: team_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('team_requests_id_seq', 26, true);


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: -
--

COPY teams (id, team_owner_id, name, points, created_at, updated_at, image_url) FROM stdin;
1	1	Real Madrid	1000	2017-04-05 16:15:15.500333	2017-04-05 16:15:15.500333	real-madrid-logo-vector-400x400.png
2	10	FC Barcelona	1000	2017-04-05 16:48:09.733687	2017-04-05 16:48:09.733687	Barcelona.png
3	15	Chelsea F.C.	1000	2017-04-05 17:08:22.285221	2017-04-05 17:08:22.285221	Chelsea_FC.png
4	22	Manchester City F.C.	1000	2017-04-05 17:25:25.160951	2017-04-05 17:25:25.160951	manchester-city-logo.png
5	27	Juventus F.C.	1000	2017-04-05 17:46:34.063796	2017-04-05 17:46:34.063796	Juventus_Crest.jpg
6	12	CoderSchool	1000	2017-04-05 17:59:00.635628	2017-04-05 17:59:00.635628	12508965_440033509524520_1012190472859090009_n.png
\.


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('teams_id_seq', 6, true);


--
-- Data for Name: venues; Type: TABLE DATA; Schema: public; Owner: -
--

COPY venues (id, name, created_at, updated_at) FROM stdin;
1	District 1	2017-04-05 11:21:10.456671	2017-04-05 11:21:10.456671
2	District 2	2017-04-05 11:21:10.459243	2017-04-05 11:21:10.459243
3	District 3	2017-04-05 11:21:10.461759	2017-04-05 11:21:10.461759
4	District 4	2017-04-05 11:21:10.463541	2017-04-05 11:21:10.463541
5	District 5	2017-04-05 11:21:10.465099	2017-04-05 11:21:10.465099
6	District 6	2017-04-05 11:21:10.466646	2017-04-05 11:21:10.466646
7	District 7	2017-04-05 11:21:10.468226	2017-04-05 11:21:10.468226
8	District 8	2017-04-05 11:21:10.470072	2017-04-05 11:21:10.470072
9	District 9	2017-04-05 11:21:10.471749	2017-04-05 11:21:10.471749
10	District 10	2017-04-05 11:21:10.473427	2017-04-05 11:21:10.473427
11	District 11	2017-04-05 11:21:10.475022	2017-04-05 11:21:10.475022
12	District 12	2017-04-05 11:21:10.476537	2017-04-05 11:21:10.476537
13	Binh Chanh	2017-04-05 11:21:10.478037	2017-04-05 11:21:10.478037
14	Binh Tan	2017-04-05 11:21:10.47954	2017-04-05 11:21:10.47954
15	Binh Thanh	2017-04-05 11:21:10.481123	2017-04-05 11:21:10.481123
16	Can Gio	2017-04-05 11:21:10.482641	2017-04-05 11:21:10.482641
17	Cu Chi	2017-04-05 11:21:10.48414	2017-04-05 11:21:10.48414
18	Go Vap	2017-04-05 11:21:10.485669	2017-04-05 11:21:10.485669
19	Hoc Mon	2017-04-05 11:21:10.487218	2017-04-05 11:21:10.487218
20	Nha Be	2017-04-05 11:21:10.488769	2017-04-05 11:21:10.488769
21	Phu Nhuan	2017-04-05 11:21:10.490283	2017-04-05 11:21:10.490283
22	Tan Binh	2017-04-05 11:21:10.491846	2017-04-05 11:21:10.491846
23	Tan Phu	2017-04-05 11:21:10.493396	2017-04-05 11:21:10.493396
24	Thu Duc	2017-04-05 11:21:10.494889	2017-04-05 11:21:10.494889
\.


--
-- Name: venues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('venues_id_seq', 24, true);


--
-- Data for Name: world_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY world_messages (id, player_id, body, created_at, updated_at) FROM stdin;
\.


--
-- Name: world_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('world_messages_id_seq', 1, false);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: field_owners field_owners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY field_owners
    ADD CONSTRAINT field_owners_pkey PRIMARY KEY (id);


--
-- Name: fields fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY fields
    ADD CONSTRAINT fields_pkey PRIMARY KEY (id);


--
-- Name: match_messages match_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY match_messages
    ADD CONSTRAINT match_messages_pkey PRIMARY KEY (id);


--
-- Name: match_requests match_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY match_requests
    ADD CONSTRAINT match_requests_pkey PRIMARY KEY (id);


--
-- Name: match_results match_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY match_results
    ADD CONSTRAINT match_results_pkey PRIMARY KEY (id);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: player_references player_references_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY player_references
    ADD CONSTRAINT player_references_pkey PRIMARY KEY (id);


--
-- Name: player_results player_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY player_results
    ADD CONSTRAINT player_results_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: team_messages team_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY team_messages
    ADD CONSTRAINT team_messages_pkey PRIMARY KEY (id);


--
-- Name: team_owners team_owners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY team_owners
    ADD CONSTRAINT team_owners_pkey PRIMARY KEY (id);


--
-- Name: team_requests team_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY team_requests
    ADD CONSTRAINT team_requests_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: venues venues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);


--
-- Name: world_messages world_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY world_messages
    ADD CONSTRAINT world_messages_pkey PRIMARY KEY (id);


--
-- Name: index_articles_on_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_articles_on_player_id ON articles USING btree (player_id);


--
-- Name: index_match_messages_on_match_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_match_messages_on_match_id ON match_messages USING btree (match_id);


--
-- Name: index_team_messages_on_team_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_team_messages_on_team_id ON team_messages USING btree (team_id);


--
-- Name: articles fk_rails_9392c4193a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT fk_rails_9392c4193a FOREIGN KEY (player_id) REFERENCES players(id);


--
-- Name: team_messages fk_rails_c68c060580; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY team_messages
    ADD CONSTRAINT fk_rails_c68c060580 FOREIGN KEY (team_id) REFERENCES teams(id);


--
-- Name: match_messages fk_rails_e1dbaaefd2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY match_messages
    ADD CONSTRAINT fk_rails_e1dbaaefd2 FOREIGN KEY (match_id) REFERENCES matches(id);


--
-- PostgreSQL database dump complete
--

