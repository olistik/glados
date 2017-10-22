DROP TABLE IF EXISTS settings;
CREATE TABLE settings (
  id      serial PRIMARY KEY,
  key     varchar(40) NOT NULL,
  value   text NOT NULL
);

DROP TABLE IF EXISTS devices;
CREATE TABLE devices (
  id          serial PRIMARY KEY,
  name        varchar(40) NOT NULL UNIQUE,
  secret_key  varchar(40) NOT NULL,
  created_at  TIMESTAMP (0) WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at  TIMESTAMP (0) WITH TIME ZONE NOT NULL DEFAULT now()
);

DROP TYPE IF EXISTS device_status;
CREATE TYPE device_status AS ENUM ('initialized', 'ok', 'generic_error', 'late');

DROP TABLE IF EXISTS device_statuses;
CREATE TABLE device_statuses (
  id          serial PRIMARY KEY,
  device_id   integer UNIQUE REFERENCES devices (id) ON DELETE RESTRICT,
  status      device_status DEFAULT 'initialized',
  created_at  TIMESTAMP (0) WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at  TIMESTAMP (0) WITH TIME ZONE NOT NULL DEFAULT now()
);

DROP TABLE IF EXISTS heartbeats;
CREATE TABLE heartbeats (
  id          serial PRIMARY KEY,
  device_id   integer REFERENCES devices (id) ON DELETE RESTRICT,
  data        jsonb,
  created_at  TIMESTAMP (0) WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at  TIMESTAMP (0) WITH TIME ZONE NOT NULL DEFAULT now()
);

INSERT INTO settings (key, value) VALUES ('api_key', 'XXX');
INSERT INTO devices (name,secret_key) VALUES ('glassless','foo bar');
SELECT * FROM devices;

INSERT INTO device_statuses (device_id) VALUES ((SELECT id from devices WHERE name = 'glassless' LIMIT 1));

INSERT INTO heartbeats (device_id,data) VALUES ((SELECT id from devices WHERE name = 'glassless' LIMIT 1),'{"foo":"bar","spam":"egg"}');
SELECT data->'foo' as query_key FROM heartbeats;
