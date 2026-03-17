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

--
-- Name: links; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA links;


ALTER SCHEMA links OWNER TO postgres;

--
-- Name: main; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA main;


ALTER SCHEMA main OWNER TO postgres;

--
-- Name: refs; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA refs;


ALTER SCHEMA refs OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: plant_feature; Type: TABLE; Schema: links; Owner: postgres
--

CREATE TABLE links.plant_feature (
    plant_id integer NOT NULL,
    feature_id integer NOT NULL
);


ALTER TABLE links.plant_feature OWNER TO postgres;

--
-- Name: plant_tip; Type: TABLE; Schema: links; Owner: postgres
--

CREATE TABLE links.plant_tip (
    plant_id integer NOT NULL,
    tip_id integer NOT NULL
);


ALTER TABLE links.plant_tip OWNER TO postgres;

--
-- Name: advice; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.advice (
    id integer NOT NULL,
    tip_text text NOT NULL
);


ALTER TABLE main.advice OWNER TO postgres;

--
-- Name: fertilizer; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.fertilizer (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    usage text,
    type character varying(100)
);


ALTER TABLE main.fertilizer OWNER TO postgres;

--
-- Name: fertilizer_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.fertilizer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE main.fertilizer_id_seq OWNER TO postgres;

--
-- Name: fertilizer_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: postgres
--

ALTER SEQUENCE main.fertilizer_id_seq OWNED BY main.fertilizer.id;


--
-- Name: plant; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.plant (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    sunlight_id integer,
    watering_id integer,
    temperature_id integer,
    safety_id integer,
    difficulty_id integer,
    size_id integer,
    fertilizer_id integer
);


ALTER TABLE main.plant OWNER TO postgres;

--
-- Name: plant_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.plant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE main.plant_id_seq OWNER TO postgres;

--
-- Name: plant_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: postgres
--

ALTER SEQUENCE main.plant_id_seq OWNED BY main.plant.id;


--
-- Name: tip_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.tip_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE main.tip_id_seq OWNER TO postgres;

--
-- Name: tip_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: postgres
--

ALTER SEQUENCE main.tip_id_seq OWNED BY main.advice.id;


--
-- Name: difficulty; Type: TABLE; Schema: refs; Owner: postgres
--

CREATE TABLE refs.difficulty (
    id integer NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE refs.difficulty OWNER TO postgres;

--
-- Name: difficulty_id_seq; Type: SEQUENCE; Schema: refs; Owner: postgres
--

CREATE SEQUENCE refs.difficulty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE refs.difficulty_id_seq OWNER TO postgres;

--
-- Name: difficulty_id_seq; Type: SEQUENCE OWNED BY; Schema: refs; Owner: postgres
--

ALTER SEQUENCE refs.difficulty_id_seq OWNED BY refs.difficulty.id;


--
-- Name: feature; Type: TABLE; Schema: refs; Owner: postgres
--

CREATE TABLE refs.feature (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    intensity_level character varying(255),
    safety_flag boolean
);


ALTER TABLE refs.feature OWNER TO postgres;

--
-- Name: feature_id_seq; Type: SEQUENCE; Schema: refs; Owner: postgres
--

CREATE SEQUENCE refs.feature_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE refs.feature_id_seq OWNER TO postgres;

--
-- Name: feature_id_seq; Type: SEQUENCE OWNED BY; Schema: refs; Owner: postgres
--

ALTER SEQUENCE refs.feature_id_seq OWNED BY refs.feature.id;


--
-- Name: safety; Type: TABLE; Schema: refs; Owner: postgres
--

CREATE TABLE refs.safety (
    id integer NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE refs.safety OWNER TO postgres;

--
-- Name: safety_id_seq; Type: SEQUENCE; Schema: refs; Owner: postgres
--

CREATE SEQUENCE refs.safety_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE refs.safety_id_seq OWNER TO postgres;

--
-- Name: safety_id_seq; Type: SEQUENCE OWNED BY; Schema: refs; Owner: postgres
--

ALTER SEQUENCE refs.safety_id_seq OWNED BY refs.safety.id;


--
-- Name: size; Type: TABLE; Schema: refs; Owner: postgres
--

CREATE TABLE refs.size (
    id integer NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE refs.size OWNER TO postgres;

--
-- Name: size_id_seq; Type: SEQUENCE; Schema: refs; Owner: postgres
--

CREATE SEQUENCE refs.size_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE refs.size_id_seq OWNER TO postgres;

--
-- Name: size_id_seq; Type: SEQUENCE OWNED BY; Schema: refs; Owner: postgres
--

ALTER SEQUENCE refs.size_id_seq OWNED BY refs.size.id;


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
-- Name: temperature; Type: TABLE; Schema: refs; Owner: postgres
--

CREATE TABLE refs.temperature (
    id integer NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE refs.temperature OWNER TO postgres;

--
-- Name: temperature_id_seq; Type: SEQUENCE; Schema: refs; Owner: postgres
--

CREATE SEQUENCE refs.temperature_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE refs.temperature_id_seq OWNER TO postgres;

--
-- Name: temperature_id_seq; Type: SEQUENCE OWNED BY; Schema: refs; Owner: postgres
--

ALTER SEQUENCE refs.temperature_id_seq OWNED BY refs.temperature.id;


--
-- Name: watering; Type: TABLE; Schema: refs; Owner: postgres
--

CREATE TABLE refs.watering (
    id integer NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE refs.watering OWNER TO postgres;

--
-- Name: watering_id_seq; Type: SEQUENCE; Schema: refs; Owner: postgres
--

CREATE SEQUENCE refs.watering_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE refs.watering_id_seq OWNER TO postgres;

--
-- Name: watering_id_seq; Type: SEQUENCE OWNED BY; Schema: refs; Owner: postgres
--

ALTER SEQUENCE refs.watering_id_seq OWNED BY refs.watering.id;


--
-- Name: advice id; Type: DEFAULT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.advice ALTER COLUMN id SET DEFAULT nextval('main.tip_id_seq'::regclass);


--
-- Name: fertilizer id; Type: DEFAULT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.fertilizer ALTER COLUMN id SET DEFAULT nextval('main.fertilizer_id_seq'::regclass);


--
-- Name: plant id; Type: DEFAULT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.plant ALTER COLUMN id SET DEFAULT nextval('main.plant_id_seq'::regclass);


--
-- Name: difficulty id; Type: DEFAULT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.difficulty ALTER COLUMN id SET DEFAULT nextval('refs.difficulty_id_seq'::regclass);


--
-- Name: feature id; Type: DEFAULT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.feature ALTER COLUMN id SET DEFAULT nextval('refs.feature_id_seq'::regclass);


--
-- Name: safety id; Type: DEFAULT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.safety ALTER COLUMN id SET DEFAULT nextval('refs.safety_id_seq'::regclass);


--
-- Name: size id; Type: DEFAULT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.size ALTER COLUMN id SET DEFAULT nextval('refs.size_id_seq'::regclass);


--
-- Name: sunlight id; Type: DEFAULT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.sunlight ALTER COLUMN id SET DEFAULT nextval('refs.sunlight_id_seq'::regclass);


--
-- Name: temperature id; Type: DEFAULT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.temperature ALTER COLUMN id SET DEFAULT nextval('refs.temperature_id_seq'::regclass);


--
-- Name: watering id; Type: DEFAULT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.watering ALTER COLUMN id SET DEFAULT nextval('refs.watering_id_seq'::regclass);


--
-- Name: plant_feature plant_feature_pkey; Type: CONSTRAINT; Schema: links; Owner: postgres
--

ALTER TABLE ONLY links.plant_feature
    ADD CONSTRAINT plant_feature_pkey PRIMARY KEY (plant_id, feature_id);


--
-- Name: plant_tip plant_tip_pkey; Type: CONSTRAINT; Schema: links; Owner: postgres
--

ALTER TABLE ONLY links.plant_tip
    ADD CONSTRAINT plant_tip_pkey PRIMARY KEY (plant_id, tip_id);


--
-- Name: advice advice_tip_text_unique; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.advice
    ADD CONSTRAINT advice_tip_text_unique UNIQUE (tip_text);


--
-- Name: fertilizer fertilizer_name_unique; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.fertilizer
    ADD CONSTRAINT fertilizer_name_unique UNIQUE (name);


--
-- Name: fertilizer fertilizer_pkey; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.fertilizer
    ADD CONSTRAINT fertilizer_pkey PRIMARY KEY (id);


--
-- Name: plant plant_pkey; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.plant
    ADD CONSTRAINT plant_pkey PRIMARY KEY (id);


--
-- Name: advice tip_pkey; Type: CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.advice
    ADD CONSTRAINT tip_pkey PRIMARY KEY (id);


--
-- Name: difficulty difficulty_pkey; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.difficulty
    ADD CONSTRAINT difficulty_pkey PRIMARY KEY (id);


--
-- Name: difficulty difficulty_type_unique; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.difficulty
    ADD CONSTRAINT difficulty_type_unique UNIQUE (type);


--
-- Name: feature feature_name_unique; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.feature
    ADD CONSTRAINT feature_name_unique UNIQUE (name);


--
-- Name: feature feature_pkey; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.feature
    ADD CONSTRAINT feature_pkey PRIMARY KEY (id);


--
-- Name: safety safety_pkey; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.safety
    ADD CONSTRAINT safety_pkey PRIMARY KEY (id);


--
-- Name: safety safety_type_unique; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.safety
    ADD CONSTRAINT safety_type_unique UNIQUE (type);


--
-- Name: size size_pkey; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.size
    ADD CONSTRAINT size_pkey PRIMARY KEY (id);


--
-- Name: size size_type_unique; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.size
    ADD CONSTRAINT size_type_unique UNIQUE (type);


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
-- Name: temperature temperature_pkey; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.temperature
    ADD CONSTRAINT temperature_pkey PRIMARY KEY (id);


--
-- Name: temperature temperature_type_unique; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.temperature
    ADD CONSTRAINT temperature_type_unique UNIQUE (type);


--
-- Name: watering watering_pkey; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.watering
    ADD CONSTRAINT watering_pkey PRIMARY KEY (id);


--
-- Name: watering watering_type_unique; Type: CONSTRAINT; Schema: refs; Owner: postgres
--

ALTER TABLE ONLY refs.watering
    ADD CONSTRAINT watering_type_unique UNIQUE (type);


--
-- Name: plant_feature plant_feature_feature_id_fkey; Type: FK CONSTRAINT; Schema: links; Owner: postgres
--

ALTER TABLE ONLY links.plant_feature
    ADD CONSTRAINT plant_feature_feature_id_fkey FOREIGN KEY (feature_id) REFERENCES refs.feature(id);


--
-- Name: plant_feature plant_feature_plant_id_fkey; Type: FK CONSTRAINT; Schema: links; Owner: postgres
--

ALTER TABLE ONLY links.plant_feature
    ADD CONSTRAINT plant_feature_plant_id_fkey FOREIGN KEY (plant_id) REFERENCES main.plant(id);


--
-- Name: plant_tip plant_tip_plant_id_fkey; Type: FK CONSTRAINT; Schema: links; Owner: postgres
--

ALTER TABLE ONLY links.plant_tip
    ADD CONSTRAINT plant_tip_plant_id_fkey FOREIGN KEY (plant_id) REFERENCES main.plant(id);


--
-- Name: plant_tip plant_tip_tip_id_fkey; Type: FK CONSTRAINT; Schema: links; Owner: postgres
--

ALTER TABLE ONLY links.plant_tip
    ADD CONSTRAINT plant_tip_tip_id_fkey FOREIGN KEY (tip_id) REFERENCES main.advice(id);


--
-- Name: plant plant_difficulty_id_fkey; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.plant
    ADD CONSTRAINT plant_difficulty_id_fkey FOREIGN KEY (difficulty_id) REFERENCES refs.difficulty(id);


--
-- Name: plant plant_fertilizer_id_fkey; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.plant
    ADD CONSTRAINT plant_fertilizer_id_fkey FOREIGN KEY (fertilizer_id) REFERENCES main.fertilizer(id);


--
-- Name: plant plant_safety_id_fkey; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.plant
    ADD CONSTRAINT plant_safety_id_fkey FOREIGN KEY (safety_id) REFERENCES refs.safety(id);


--
-- Name: plant plant_size_id_fkey; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.plant
    ADD CONSTRAINT plant_size_id_fkey FOREIGN KEY (size_id) REFERENCES refs.size(id);


--
-- Name: plant plant_sunlight_id_fkey; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.plant
    ADD CONSTRAINT plant_sunlight_id_fkey FOREIGN KEY (sunlight_id) REFERENCES refs.sunlight(id);


--
-- Name: plant plant_temperature_id_fkey; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.plant
    ADD CONSTRAINT plant_temperature_id_fkey FOREIGN KEY (temperature_id) REFERENCES refs.temperature(id);


--
-- Name: plant plant_watering_id_fkey; Type: FK CONSTRAINT; Schema: main; Owner: postgres
--

ALTER TABLE ONLY main.plant
    ADD CONSTRAINT plant_watering_id_fkey FOREIGN KEY (watering_id) REFERENCES refs.watering(id);


--
-- PostgreSQL database dump complete
--

