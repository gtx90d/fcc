--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(64) NOT NULL,
    mass integer,
    distance integer,
    diameter integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(64) NOT NULL,
    mass integer,
    is_spherical boolean,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(64) NOT NULL,
    mass numeric(4,1),
    discovery_year integer,
    distance integer,
    has_life boolean,
    planet_type_id integer,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: planet_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet_type (
    planet_type_id integer NOT NULL,
    name character varying(64) NOT NULL,
    description text
);


ALTER TABLE public.planet_type OWNER TO freecodecamp;

--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_type_planet_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_type_planet_type_id_seq OWNER TO freecodecamp;

--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_type_planet_type_id_seq OWNED BY public.planet_type.planet_type_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(64) NOT NULL,
    mass integer,
    star_type_id integer,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: star_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star_type (
    star_type_id integer NOT NULL,
    name character varying(64) NOT NULL,
    description text
);


ALTER TABLE public.star_type OWNER TO freecodecamp;

--
-- Name: star_type_star_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_type_star_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_type_star_type_id_seq OWNER TO freecodecamp;

--
-- Name: star_type_star_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_type_star_type_id_seq OWNED BY public.star_type.star_type_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: planet_type planet_type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type ALTER COLUMN planet_type_id SET DEFAULT nextval('public.planet_type_planet_type_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: star_type star_type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type ALTER COLUMN star_type_id SET DEFAULT nextval('public.star_type_star_type_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', NULL, 0, 100);
INSERT INTO public.galaxy VALUES (3, 'Andromeda', NULL, 220, 2500);
INSERT INTO public.galaxy VALUES (4, 'Cigar Galaxy', NULL, 37, 11500);
INSERT INTO public.galaxy VALUES (5, 'Hoag''s Object', NULL, 100, 600000);
INSERT INTO public.galaxy VALUES (6, 'Pinwheel Galaxy', NULL, 170, 20870);
INSERT INTO public.galaxy VALUES (2, 'Large Magellanic Cloud', NULL, 14, 158);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 7342, true, 2);
INSERT INTO public.moon VALUES (2, 'Phobos', NULL, false, 3);
INSERT INTO public.moon VALUES (3, 'Deimos', NULL, false, 3);
INSERT INTO public.moon VALUES (4, 'Ganymede', NULL, true, 4);
INSERT INTO public.moon VALUES (5, 'Callisto', NULL, true, 4);
INSERT INTO public.moon VALUES (6, 'Io', NULL, true, 4);
INSERT INTO public.moon VALUES (7, 'Europa', NULL, true, 4);
INSERT INTO public.moon VALUES (8, 'Titan', NULL, true, 5);
INSERT INTO public.moon VALUES (9, 'Enceladus', NULL, true, 5);
INSERT INTO public.moon VALUES (10, 'Mimas', NULL, true, 5);
INSERT INTO public.moon VALUES (11, 'Iapetus', NULL, true, 5);
INSERT INTO public.moon VALUES (12, 'Tethys', NULL, true, 5);
INSERT INTO public.moon VALUES (13, 'Hyperion', NULL, false, 5);
INSERT INTO public.moon VALUES (14, 'Prometheus', NULL, false, 5);
INSERT INTO public.moon VALUES (15, 'Pandora', NULL, false, 5);
INSERT INTO public.moon VALUES (16, 'Janus', NULL, false, 5);
INSERT INTO public.moon VALUES (17, 'Epimetheus', NULL, false, 5);
INSERT INTO public.moon VALUES (18, 'Phoebe', NULL, false, 5);
INSERT INTO public.moon VALUES (19, 'Telesto', NULL, false, 5);
INSERT INTO public.moon VALUES (20, 'Miranda', NULL, true, 6);
INSERT INTO public.moon VALUES (21, 'Ariel', NULL, true, 6);
INSERT INTO public.moon VALUES (22, 'Umbriel', NULL, true, 6);
INSERT INTO public.moon VALUES (23, 'Titania', NULL, true, 6);
INSERT INTO public.moon VALUES (24, 'Oberon', NULL, true, 6);
INSERT INTO public.moon VALUES (25, 'Despina', NULL, NULL, 7);
INSERT INTO public.moon VALUES (26, 'Galatea', NULL, NULL, 7);
INSERT INTO public.moon VALUES (27, 'Halimede', NULL, NULL, 7);
INSERT INTO public.moon VALUES (28, 'Hippocamp', NULL, NULL, 7);
INSERT INTO public.moon VALUES (29, 'Laomedeia', NULL, NULL, 7);
INSERT INTO public.moon VALUES (30, 'Larissa', NULL, NULL, 7);
INSERT INTO public.moon VALUES (31, 'Naiad', NULL, NULL, 7);
INSERT INTO public.moon VALUES (32, 'Nereid', NULL, NULL, 7);
INSERT INTO public.moon VALUES (33, 'Neso', NULL, NULL, 7);
INSERT INTO public.moon VALUES (34, 'Proteus', NULL, NULL, 7);
INSERT INTO public.moon VALUES (35, 'Psamathe', NULL, NULL, 7);
INSERT INTO public.moon VALUES (36, 'Sao', NULL, NULL, 7);
INSERT INTO public.moon VALUES (37, 'Thalassa', NULL, NULL, 7);
INSERT INTO public.moon VALUES (38, 'Triton', NULL, NULL, 7);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 0.5, NULL, NULL, false, 4, 1);
INSERT INTO public.planet VALUES (2, 'Earth', 1.0, NULL, 0, true, 4, 1);
INSERT INTO public.planet VALUES (3, 'Mars', 10.0, NULL, NULL, false, 4, 1);
INSERT INTO public.planet VALUES (4, 'Jupiter', 317.8, NULL, NULL, false, 1, 1);
INSERT INTO public.planet VALUES (5, 'Saturn', 95.2, NULL, NULL, false, 1, 1);
INSERT INTO public.planet VALUES (6, 'Uranus', 14.5, NULL, NULL, false, 5, 1);
INSERT INTO public.planet VALUES (7, 'Neptune', 17.1, NULL, NULL, false, 5, 1);
INSERT INTO public.planet VALUES (8, 'Proxima Centauri b', 1.1, 2016, 42, false, 3, 2);
INSERT INTO public.planet VALUES (9, 'Kepler-452b', 5.0, 2015, 18000, false, 3, 3);
INSERT INTO public.planet VALUES (10, 'Lacaille 9352 b', 4.2, 2020, 107, false, NULL, 5);
INSERT INTO public.planet VALUES (11, 'Lacaille 9352 c', 7.6, 2020, 107, false, NULL, 5);
INSERT INTO public.planet VALUES (12, 'Lacaille 9352 d', 8.3, 2020, 107, false, NULL, 5);


--
-- Data for Name: planet_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet_type VALUES (1, 'Gas giant', 'A gas giant is a large planet mostly composed of helium and/or hydrogen. These planets, like Jupiter and Saturn in our solar system, don’t have hard surfaces and instead have swirling gases above a solid core. Gas giant exoplanets can be much larger than Jupiter, and much closer to their stars than anything found in our solar system');
INSERT INTO public.planet_type VALUES (2, 'Neptunian', 'Neptunian exoplanets are similar in size to Neptune or Uranus in our solar system. Neptunian planets typically have hydrogen and helium-dominated atmospheres with cores of rock and heavier metals');
INSERT INTO public.planet_type VALUES (3, 'Super-Earth', 'Super-Earths – a class of planets unlike any in our solar system – are more massive than Earth yet lighter than ice giants like Neptune and Uranus, and can be made of gas, rock or a combination of both. They are between twice the size of Earth and up to 10 times its mass');
INSERT INTO public.planet_type VALUES (4, 'Terrestrial', 'In our solar system, Earth, Mars, Mercury and Venus are terrestrial, or rocky, planets. For planets outside our solar system, those between half of Earth’s size to twice its radius are considered terrestrial and others may be even smaller. Exoplanets twice the size of Earth and larger may be rocky as well, but those are considered super-Earths');
INSERT INTO public.planet_type VALUES (5, 'Ice Giant', 'They are primarily composed of elements heavier than hydrogen and helium, forming a separate type of giant planet altogether. Because during their formation Uranus and Neptune incorporated their material as either ice or gas trapped in water ice, the term ice giant came into use');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1, 6, 1);
INSERT INTO public.star VALUES (2, 'Proxima Centauri', 116, 4, 1);
INSERT INTO public.star VALUES (3, 'Kepler-452', 103, 6, 1);
INSERT INTO public.star VALUES (5, 'Lacaille 9352', 0, 4, 1);
INSERT INTO public.star VALUES (6, '54 Piscium', NULL, 5, 1);
INSERT INTO public.star VALUES (7, 'Sirius B', NULL, 2, 1);


--
-- Data for Name: star_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star_type VALUES (1, 'Red Giant', 'When a main sequence star less than eight times the Sun’s mass runs out of hydrogen in its core, it starts to collapse because the energy produced by fusion is the only force fighting gravity’s tendency to pull matter together. But squeezing the core also increases its temperature and pressure, so much so that its helium starts to fuse into carbon, which also releases energy. Hydrogen fusion begins moving into the star’s outer layers, causing them to expand. The result is a red giant, which would appear more orange than red. Eventually, the red giant becomes unstable and begins pulsating, periodically expanding and ejecting some of its atmosphere. Eventually, all of its outer layers blow away, creating an expanding cloud of dust and gas called a planetary nebula. The Sun will become a red giant in about 5 billion years');
INSERT INTO public.star_type VALUES (2, 'White Dwarf', 'After a red giant has shed all its atmosphere, only the core remains. Scientists call this kind of stellar remnant a white dwarf. A white dwarf is usually Earth-size but hundreds of thousands of times more massive. A teaspoon of its material would weigh more than a pickup truck. A white dwarf produces no new heat of its own, so it gradually cools over billions of years. Despite the name, white dwarfs can emit visible light that ranges from blue white to red. Scientists sometimes find that white dwarfs are surrounded by dusty disks of material, debris, and even planets – leftovers from the original star’s red giant phase. In about 10 billion years, after its time as a red giant, the Sun will become a white dwarf');
INSERT INTO public.star_type VALUES (3, 'Neutron Star', 'Neutron stars are stellar remnants that pack more mass than the Sun into a sphere about as wide as New York City’s Manhattan Island is long. A neutron star forms when a main sequence star with between about eight and 20 times the Sun’s mass runs out of hydrogen in its core. (Heavier stars produce stellar-mass black holes.) The star starts fusing helium to carbon, like lower-mass stars. But then, when the core runs out of helium, it shrinks, heats up, and starts converting its carbon into neon, which releases energy. This process continues as the star converts neon into oxygen, oxygen into silicon, and finally silicon into iron. These processes produce energy that keep the core from collapsing, but each new fuel buys it less and less time. By the time silicon fuses into iron, the star runs out of fuel in a matter of days. The next step would be fusing iron into some heavier element, but doing so requires energy instead of releasing it. The core collapses and then rebounds back to its original size, creating a shock wave that travels through the star’s outer layers. The result is a huge explosion called a supernova. The remnant core is a superdense neutron star');
INSERT INTO public.star_type VALUES (4, 'Red Dwarf', 'Red dwarfs are the smallest main sequence stars – just a fraction of the Sun’s size and mass. They’re also the coolest, and appear more orange in color than red. When a red dwarf produces helium via fusion in its core, the released energy brings material to the star’s surface, where it cools and sinks back down, taking along a fresh supply of hydrogen to the core. Because of this constant churning, red dwarfs can steadily burn through their entire supply of hydrogen over trillions of years without changing their internal structures, unlike other stars. Scientists think some low-mass red dwarfs, those with just a third of the Sun’s mass, have life spans longer than the current age of the universe, up to about 14 trillion years. Red dwarfs are also born in much greater numbers than more massive stars. Because of that, and because they live so long, red dwarfs make up around 75% of the Milky Way galaxy’s stellar population');
INSERT INTO public.star_type VALUES (5, 'Brown Dwarf', 'Brown dwarfs aren’t technically stars. They’re more massive than planets but not quite as massive as stars. Generally, they have between 13 and 80 times the mass of Jupiter. They emit almost no visible light, but scientists have seen a few in infrared light. Some brown dwarfs form the same way as main sequence stars, from gas and dust clumps in nebulae, but they never gain enough mass to do fusion on the scale of a main sequence star. Others may form like planets, from disks of gas and dust around stars');
INSERT INTO public.star_type VALUES (6, 'Main Sequence Star', 'A normal star forms from a clump of dust and gas in a stellar nursery. Over hundreds of thousands of years, the clump gains mass, starts to spin, and heats up. When the clump''s core heats up to millions of degrees, nuclear fusion starts. This process occurs when two protons, the nuclei of hydrogen atoms, merge to form one helium nucleus. Fusion releases energy that heats the star, creating pressure that pushes against the force of its gravity. A star is born. Scientists call a star that is fusing hydrogen to helium in its core a main sequence star. Main sequence stars make up around 90% of the universe’s stellar population. They range in luminosity, color, and size – from a tenth to 200 times the Sun’s mass – and live for millions to billions of years');


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 38, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: planet_type_planet_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_type_planet_type_id_seq', 5, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 7, true);


--
-- Name: star_type_star_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_type_star_type_id_seq', 6, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: planet_type planet_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type
    ADD CONSTRAINT planet_type_name_key UNIQUE (name);


--
-- Name: planet_type planet_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet_type
    ADD CONSTRAINT planet_type_pkey PRIMARY KEY (planet_type_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: star_type star_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type
    ADD CONSTRAINT star_type_name_key UNIQUE (name);


--
-- Name: star_type star_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type
    ADD CONSTRAINT star_type_pkey PRIMARY KEY (star_type_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_planet_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_planet_type_id_fkey FOREIGN KEY (planet_type_id) REFERENCES public.planet_type(planet_type_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: star star_star_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_star_type_id_fkey FOREIGN KEY (star_type_id) REFERENCES public.star_type(star_type_id);


--
-- PostgreSQL database dump complete
--

