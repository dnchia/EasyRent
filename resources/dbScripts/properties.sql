CREATE TABLE properties (
  id              UUID            NOT NULL,
  owner_id        UUID            ,
  title           VARCHAR(50)     NOT NULL,
  location        VARCHAR(50)     NOT NULL,
  rooms           NUMERIC(2, 0)   NOT NULL,
  capacity        NUMERIC(2, 0)   NOT NULL,
  beds            NUMERIC(2, 0)   NOT NULL,
  bathrooms       NUMERIC(2, 0)   NOT NULL,
  floor_space     NUMERIC(3, 0)   NOT NULL,
  price_per_day   FLOAT(4)        NOT NULL,
  creation_date   DATE            NOT NULL,
  type            VARCHAR(20)     NOT NULL,
  description     VARCHAR(500)    NOT NULL,

  CONSTRAINT pk_properties PRIMARY KEY (id),

  CONSTRAINT fk_pr_username FOREIGN KEY (owner_id)
    REFERENCES users(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);