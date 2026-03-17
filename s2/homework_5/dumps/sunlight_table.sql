--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

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
-- Name: sunlight; Type: TABLE; Schema: refs; Owner: postgres
--

CREATE TABLE refs.sunlight (
    id integer NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE refs.sunlight OWNER TO postgres;

--
-- Name: sunlight_id_seq; Type: SEQUENCE; Schema: refs; Owner: postgres
--

CREATE SEQUENCE refs.sunlight_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE refs.sunlight_id_seq OWNER TO postgres;

--
-- Name: sunlight_id_seq; Type: SEQUENCE OWNED BY; Schema: refs; Owner: postgres
--

ALTER SEQUENCE refs.sunlight_id_seq OWNED BY refs.sunlight.id;


--
-- Name: sunlight id; Type: DEFAULT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.sunlight ALTER COLUMN id SET DEFAULT nextval('refs.sunlight_id_seq'::regclass);


--
-- Data for Name: sunlight; Type: TABLE DATA; Schema: refs; Owner: postgres
--

COPY refs.sunlight (id, type) FROM stdin;
1	Тень
2	Полутень
3	Рассеянный свет
4	Прямой свет
5	Экстремальный свет
\.


--
-- Name: sunlight_id_seq; Type: SEQUENCE SET; Schema: refs; Owner: postgres
--

SELECT pg_catalog.setval('refs.sunlight_id_seq', 5, true);


--
-- Name: sunlight sunlight_pkey; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.sunlight
    ADD CONSTRAINT sunlight_pkey PRIMARY KEY (id);


--
-- Name: sunlight sunlight_type_unique; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.sunlight
    ADD CONSTRAINT sunlight_type_unique UNIQUE (type);


--
-- PostgreSQL database dump complete
--

